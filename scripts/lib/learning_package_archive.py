#!/usr/bin/env python3
"""Validate and safely extract a bounded learning-package ZIP archive."""

from __future__ import annotations

import argparse
import os
from pathlib import Path, PurePosixPath
import shutil
import stat
import sys
import time
import zipfile


MAX_ARCHIVE_BYTES = 512 * 1024 * 1024
MAX_ENTRIES = 10_000
MAX_ENTRY_BYTES = 128 * 1024 * 1024
MAX_TOTAL_BYTES = 1024 * 1024 * 1024
MAX_COMPRESSION_RATIO = 200
MAX_EXTRACT_SECONDS = 120
MAX_MEMBER_NAME_BYTES = 4096
MAX_TOTAL_NAME_BYTES = 16 * 1024 * 1024


class ArchiveError(RuntimeError):
    """Raised when the archive violates the bounded extraction contract."""


def _member_path(name: str) -> PurePosixPath:
    if not name or "\x00" in name or "\\" in name:
        raise ArchiveError(f"ungueltiger ZIP-Eintrag: {name!r}")
    path = PurePosixPath(name)
    if path.is_absolute() or any(part in {"", ".", ".."} for part in path.parts):
        raise ArchiveError(f"unsicherer ZIP-Pfad: {name!r}")
    return path


def _member_kind(info: zipfile.ZipInfo) -> str:
    mode = (info.external_attr >> 16) & 0xFFFF
    if mode:
        kind = stat.S_IFMT(mode)
        if kind == stat.S_IFLNK:
            raise ArchiveError(f"symbolischer Link im ZIP: {info.filename}")
        if kind not in {0, stat.S_IFREG, stat.S_IFDIR}:
            raise ArchiveError(f"nicht unterstuetzter ZIP-Eintrag: {info.filename}")
    return "directory" if info.is_dir() else "file"


def inspect_archive(archive: Path) -> list[tuple[zipfile.ZipInfo, PurePosixPath, str]]:
    if not archive.is_file() or archive.is_symlink():
        raise ArchiveError(f"ZIP ist keine regulaere Datei: {archive}")
    if archive.stat().st_size > MAX_ARCHIVE_BYTES:
        raise ArchiveError("ZIP ueberschreitet das Groessenlimit")

    members: list[tuple[zipfile.ZipInfo, PurePosixPath, str]] = []
    seen: set[str] = set()
    total = 0
    total_compressed = 0
    total_name_bytes = 0
    with zipfile.ZipFile(archive) as package:
        infos = package.infolist()
        if not infos:
            raise ArchiveError("ZIP ist leer")
        if len(infos) > MAX_ENTRIES:
            raise ArchiveError("ZIP enthaelt zu viele Eintraege")
        for info in infos:
            name_bytes = len(info.filename.encode("utf-8", "surrogatepass"))
            total_name_bytes += name_bytes
            if name_bytes > MAX_MEMBER_NAME_BYTES or total_name_bytes > MAX_TOTAL_NAME_BYTES:
                raise ArchiveError("ZIP-Eintragsnamen ueberschreiten das Limit")
            path = _member_path(info.filename)
            folded = path.as_posix().casefold().rstrip("/")
            if folded in seen:
                raise ArchiveError(f"mehrdeutiger oder doppelter ZIP-Pfad: {info.filename}")
            seen.add(folded)
            kind = _member_kind(info)
            if info.flag_bits & 0x1:
                raise ArchiveError(f"verschluesselter ZIP-Eintrag: {info.filename}")
            if info.file_size > MAX_ENTRY_BYTES:
                raise ArchiveError(f"ZIP-Eintrag ist zu gross: {info.filename}")
            total += info.file_size
            total_compressed += info.compress_size
            if total > MAX_TOTAL_BYTES:
                raise ArchiveError("ZIP ueberschreitet das Entpacklimit")
            if info.file_size and (
                info.compress_size == 0
                or info.file_size > max(1024 * 1024, info.compress_size * MAX_COMPRESSION_RATIO)
            ):
                raise ArchiveError(f"ZIP-Eintrag hat eine unzulaessige Kompressionsrate: {info.filename}")
            members.append((info, path, kind))
        if total and (
            total_compressed == 0
            or total > max(1024 * 1024, total_compressed * MAX_COMPRESSION_RATIO)
        ):
            raise ArchiveError("ZIP hat insgesamt eine unzulaessige Kompressionsrate")
    return members


def _open_regular_nofollow(source: Path) -> int:
    absolute = source.absolute()
    nofollow = getattr(os, "O_NOFOLLOW", 0)
    parent = absolute.parent.resolve(strict=True)
    directory = os.open(parent, os.O_RDONLY | getattr(os, "O_DIRECTORY", 0))
    try:
        if os.open in os.supports_dir_fd:
            descriptor = os.open(absolute.name, os.O_RDONLY | nofollow, dir_fd=directory)
        else:
            descriptor = os.open(parent / absolute.name, os.O_RDONLY | nofollow)
    finally:
        os.close(directory)
    information = os.fstat(descriptor)
    if not stat.S_ISREG(information.st_mode):
        os.close(descriptor)
        raise ArchiveError(f"Quelle ist keine regulaere Datei: {source}")
    return descriptor


def copy_regular_nofollow(source: Path, destination: Path, max_bytes: int | None = None) -> None:
    source_descriptor = _open_regular_nofollow(source)
    destination.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
    flags = os.O_WRONLY | os.O_CREAT | os.O_EXCL | getattr(os, "O_NOFOLLOW", 0)
    destination_descriptor = -1
    written = 0
    try:
        destination_descriptor = os.open(destination, flags, 0o600)
        with os.fdopen(source_descriptor, "rb") as source_file, os.fdopen(destination_descriptor, "wb") as destination_file:
            source_descriptor = -1
            destination_descriptor = -1
            while True:
                chunk = source_file.read(1024 * 1024)
                if not chunk:
                    break
                written += len(chunk)
                if max_bytes is not None and written > max_bytes:
                    raise ArchiveError("Quelldatei ueberschreitet das Groessenlimit")
                destination_file.write(chunk)
    finally:
        if source_descriptor >= 0:
            os.close(source_descriptor)
        if destination_descriptor >= 0:
            os.close(destination_descriptor)
        if max_bytes is not None and written > max_bytes and destination.exists():
            destination.unlink()


def _ensure_directory(root: Path, relative: PurePosixPath) -> Path:
    current = root
    for part in relative.parts:
        current = current / part
        if current.exists():
            if current.is_symlink() or not current.is_dir():
                raise ArchiveError(f"unsicherer Zielpfad beim Entpacken: {relative}")
        else:
            current.mkdir(mode=0o700)
    return current


def extract_archive(archive: Path, destination: Path) -> None:
    members = inspect_archive(archive)
    destination.mkdir(mode=0o700, parents=True, exist_ok=False)
    started = time.monotonic()
    actual_total = 0
    with zipfile.ZipFile(archive) as package:
        for info, relative, kind in members:
            if time.monotonic() - started > MAX_EXTRACT_SECONDS:
                raise ArchiveError("Zeitlimit beim Entpacken ueberschritten")
            if kind == "directory":
                _ensure_directory(destination, relative)
                continue
            parent = _ensure_directory(destination, relative.parent)
            target = parent / relative.name
            flags = os.O_WRONLY | os.O_CREAT | os.O_EXCL
            if hasattr(os, "O_NOFOLLOW"):
                flags |= os.O_NOFOLLOW
            written = 0
            descriptor = os.open(target, flags, 0o600)
            try:
                with package.open(info) as source, os.fdopen(descriptor, "wb") as output:
                    descriptor = -1
                    while True:
                        chunk = source.read(1024 * 1024)
                        if not chunk:
                            break
                        written += len(chunk)
                        actual_total += len(chunk)
                        if written > MAX_ENTRY_BYTES or actual_total > MAX_TOTAL_BYTES:
                            raise ArchiveError("tatsaechliches Entpacklimit ueberschritten")
                        if time.monotonic() - started > MAX_EXTRACT_SECONDS:
                            raise ArchiveError("Zeitlimit beim Entpacken ueberschritten")
                        output.write(chunk)
                if written != info.file_size:
                    raise ArchiveError(f"ZIP-Groessenangabe stimmt nicht: {info.filename}")
            finally:
                if descriptor >= 0:
                    os.close(descriptor)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("archive", type=Path, nargs="?")
    parser.add_argument("--extract", type=Path)
    parser.add_argument("--snapshot", nargs=2, metavar=("SOURCE", "DESTINATION"), type=Path)
    parser.add_argument("--copy-file", nargs=2, metavar=("SOURCE", "DESTINATION"), type=Path)
    args = parser.parse_args()
    try:
        if args.snapshot:
            copy_regular_nofollow(args.snapshot[0], args.snapshot[1], MAX_ARCHIVE_BYTES)
        elif args.copy_file:
            copy_regular_nofollow(args.copy_file[0], args.copy_file[1])
        elif not args.archive:
            parser.error("archive or copy operation required")
        elif args.extract:
            extract_archive(args.archive, args.extract)
        else:
            inspect_archive(args.archive)
    except (ArchiveError, OSError, zipfile.BadZipFile, zipfile.LargeZipFile) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        if args.extract and args.extract.exists():
            shutil.rmtree(args.extract, ignore_errors=True)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
