#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Deterministic, growing sample-data generator for the Secure Trader universe.

DE: Erzeugt konsistente, fiktive Beispieldaten fuer die drei Systeme
    (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker). Alle drei
    wachsen monatlich bis zum ENDMONAT mit — standardmaessig bis zum heutigen
    Monat (`datetime.now()`), damit Auszubildende mit Daten bis zu ihrem
    Projektdatum arbeiten. Grundlage ist das klassische Northwind-Layout.
EN: Produces consistent, fictional sample data for the three systems. All three
    grow monthly up to the END month, by default the current month
    (`datetime.now()`), so apprentices work with data up to their project date.

WHY zwei getrennte Achsen / two separate axes:
    * ENDMONAT: dynamisch aus now() (oder --end). Bestimmt, WIE WEIT die
      Zeitachse reicht. So wachsen die Daten bis zum Projektdatum mit.
    * SEED: fest (Default), ueberschreibbar mit --seed. Bestimmt, WELCHE
      konkreten Datensaetze entstehen. Fest, damit ALLE sechs Sprachpfade
      (C#, Go, Java, Python, Rust, Swift) und alle Lernenden einer Kohorte bei
      gleichem (end, seed) EXAKT denselben Datenbestand erhalten -- Grundlage
      fuer den Vergleich der Implementierungen.
    Reproduzierbarkeit gilt je (end, seed): gleiches Paar => bitgleiche Ausgabe.
    Kein os.urandom, keine Zufallszeit; now() wird NUR fuer das Default-Enddatum
    genutzt, NICHT fuer den Seed.

Der eingecheckte Snapshot wird mit gepinnten Parametern erzeugt und dokumentiert
(siehe README): `python3 generate-secure-trader-dataset.py --end 2026-07`.
"""

import argparse
import csv
import datetime
import os
import random

DEFAULT_SEED = 20260707


def parse_end(value):
    """Parst 'YYYY-MM' zu (year, month)."""
    y, m = value.split("-")
    y, m = int(y), int(m)
    if not (1 <= m <= 12) or y < 1996:
        raise ValueError("ungueltiger Endmonat (>= 1996-01): %s" % value)
    return y, m


def main():
    now = datetime.datetime.now()
    parser = argparse.ArgumentParser(
        description="Deterministischer Secure-Trader-Datensatz-Generator "
                    "(waechst bis zum Endmonat; Default: heutiger Monat).")
    parser.add_argument("--end", default="%04d-%02d" % (now.year, now.month),
                        help="Endmonat YYYY-MM (Default: heutiger Monat aus now()).")
    parser.add_argument("--seed", type=int, default=DEFAULT_SEED,
                        help="Zufalls-Seed (Default: fest, fuer reproduzierbare Daten "
                             "ueber alle Sprachpfade).")
    parser.add_argument("--out", default=None,
                        help="Zielverzeichnis (Default: Verzeichnis dieses Skripts).")
    args = parser.parse_args()

    end_year, end_month = parse_end(args.end)
    seed = args.seed
    base_dir = args.out or os.path.dirname(os.path.abspath(__file__))
    build(end_year, end_month, seed, base_dir)


def build(END_YEAR, END_MONTH, SEED, BASE_DIR):
    random.seed(SEED)

    ORDERDESK = os.path.join(BASE_DIR, "orderdesk")
    HARVESTER = os.path.join(BASE_DIR, "serviceharvester")
    CASETRACKER = os.path.join(BASE_DIR, "casetracker")
    for _d in (ORDERDESK, HARVESTER, CASETRACKER):
        os.makedirs(_d, exist_ok=True)

    def write_csv(path, header, rows):
        # LF-Zeilenenden explizit (nicht csv.writer-Default \r\n), damit der
        # Arbeitsbaum den committeten LF-Dateien entspricht und Diffs sauber sind.
        with open(path, "w", newline="", encoding="utf-8") as fh:
            writer = csv.writer(fh, lineterminator="\n")
            writer.writerow(header)
            writer.writerows(rows)

    def month_range(start, end):
        y, m = start
        ey, em = end
        while (y, m) <= (ey, em):
            yield (y, m)
            m += 1
            if m > 12:
                m = 1
                y += 1

    def months_between(a, b):
        """Anzahl Monate von a=(y,m) bis b=(y,m); b-a."""
        return (b[0] - a[0]) * 12 + (b[1] - a[1])

    # ======================================================================
    # 1) Northwind-Stammdaten / static reference data
    # ======================================================================

    CATEGORIES = [
        (1, "Beverages", "Soft drinks, coffees, teas, beers and ales"),
        (2, "Condiments", "Sweet and savory sauces, relishes, spreads and seasonings"),
        (3, "Confections", "Desserts, candies and sweet breads"),
        (4, "Dairy Products", "Cheeses"),
        (5, "Grains/Cereals", "Breads, crackers, pasta and cereal"),
        (6, "Meat/Poultry", "Prepared meats"),
        (7, "Produce", "Dried fruit and bean curd"),
        (8, "Seafood", "Seaweed and fish"),
    ]

    SHIPPERS = [
        (1, "Speedy Express", "(503) 555-9831"),
        (2, "United Package", "(503) 555-3199"),
        (3, "Federal Shipping", "(503) 555-9931"),
    ]

    # 9 Start-Mitarbeitende / starting employees (klassische Northwind-Namen, fiktiv).
    EMPLOYEES = [
        (1, "Davolio", "Nancy", "Sales Representative", "Seattle", "USA", "1996-05-01"),
        (2, "Fuller", "Andrew", "Vice President, Sales", "Tacoma", "USA", "1996-08-14"),
        (3, "Leverling", "Janet", "Sales Representative", "Kirkland", "USA", "1996-04-01"),
        (4, "Peacock", "Margaret", "Sales Representative", "Redmond", "USA", "1997-05-03"),
        (5, "Buchanan", "Steven", "Sales Manager", "London", "UK", "1997-10-17"),
        (6, "Suyama", "Michael", "Sales Representative", "London", "UK", "1997-10-17"),
        (7, "King", "Robert", "Sales Representative", "London", "UK", "1998-01-02"),
        (8, "Callahan", "Laura", "Inside Sales Coordinator", "Seattle", "USA", "1998-03-05"),
        (9, "Dodsworth", "Anne", "Sales Representative", "London", "UK", "1998-11-15"),
    ]
    EMPLOYEE_IDS = [e[0] for e in EMPLOYEES]

    # --- Suppliers (29) ---------------------------------------------------
    SUPPLIER_STEMS = [
        "Exotic Liquids", "New Orleans Cajun Delights", "Grandma Kelly's Homestead",
        "Tokyo Traders", "Cooperativa de Quesos", "Mayumi's", "Pavlova Ltd.",
        "Specialty Biscuits", "PB Knaeckebroed AB", "Refrescos Americanas",
        "Heli Suesswaren GmbH", "Plutzer Lebensmittel", "Nord-Ost Fisch",
        "Formaggi Fortini", "Norske Meierier", "Bigfoot Breweries",
        "Svensk Sjoefoeda AB", "Aux Joyeux Ecclesiastiques", "New England Seafood",
        "Leka Trading", "Lyngbysild", "Zaanse Snoepfabriek", "Karkki Oy",
        "G'day Trading", "Ma Maison", "Pasta Buttini srl", "Escargots Nouveaux",
        "Gai Paturage", "Forets d'erables",
    ]
    SUPPLIER_CITY = [
        ("London", "UK"), ("New Orleans", "USA"), ("Ann Arbor", "USA"),
        ("Tokyo", "Japan"), ("Oviedo", "Spain"), ("Osaka", "Japan"),
        ("Melbourne", "Australia"), ("Manchester", "UK"), ("Goeteborg", "Sweden"),
        ("Sao Paulo", "Brazil"), ("Berlin", "Germany"), ("Frankfurt", "Germany"),
        ("Cuxhaven", "Germany"), ("Ravenna", "Italy"), ("Sandvika", "Norway"),
        ("Bend", "USA"), ("Stockholm", "Sweden"), ("Paris", "France"),
        ("Boston", "USA"), ("Singapore", "Singapore"), ("Lyngby", "Denmark"),
        ("Zaandam", "Netherlands"), ("Lappeenranta", "Finland"), ("Sydney", "Australia"),
        ("Montreal", "Canada"), ("Salerno", "Italy"), ("Montceau", "France"),
        ("Annecy", "France"), ("Ste-Hyacinthe", "Canada"),
    ]
    FIRST_NAMES = [
        "Charlotte", "Shelley", "Regina", "Yoshi", "Antonio", "Mayumi", "Ian",
        "Peter", "Lars", "Carlos", "Petra", "Martin", "Sven", "Elio", "Beate",
        "Cheryl", "Michael", "Guylene", "Robb", "Chandra", "Niels", "Dirk",
        "Anne", "Wendy", "Jean", "Giovanni", "Marie", "Eliane", "Chantal",
        "Lena", "Marco", "Sofia", "Jonas", "Katrin", "Pavel", "Emma", "Noah",
    ]
    LAST_NAMES = [
        "Cooper", "Burke", "Murphy", "Nagase", "del Valle", "Ohno", "Devling",
        "Wilson", "Peterson", "Diaz", "Winkler", "Bein", "Petersen", "Rossi",
        "Vileid", "Saveley", "Merchant", "Nodier", "Bein", "Damodaran", "Petersen",
        "Luchini", "Heikkonen", "Mendoza", "Fresnel", "Crespi", "Bertrand",
        "Nolot", "Goulet", "Brandt", "Keller", "Amsel", "Weber", "Schulz",
    ]

    suppliers = []
    for i in range(29):
        sid = i + 1
        name = SUPPLIER_STEMS[i]
        contact = "%s %s" % (
            FIRST_NAMES[i % len(FIRST_NAMES)],
            LAST_NAMES[(i * 3) % len(LAST_NAMES)],
        )
        city, country = SUPPLIER_CITY[i]
        suppliers.append((sid, name, contact, city, country))

    # --- Products (77) ----------------------------------------------------
    PRODUCT_WORDS = {
        1: ["Chai", "Chang Ale", "Lager", "Espresso Roast", "Green Tea", "Cider",
            "Cola Classic", "Sparkling Water", "Herbal Infusion", "Dark Stout"],
        2: ["Aniseed Syrup", "Cajun Seasoning", "Gumbo Mix", "Olive Oil", "Soy Sauce",
            "Curry Paste", "Tomato Relish", "Mustard", "Hot Pepper Sauce", "Marmalade"],
        3: ["Chocolate Biscuits", "Fudge Bar", "Marzipan", "Gummi Bears", "Licorice",
            "Sponge Cake", "Scones", "Nougat", "Toffee Roll", "Caramel Wafers"],
        4: ["Gouda Wheel", "Camembert", "Mozzarella", "Blue Cheese", "Cheddar Block",
            "Emmental", "Brie", "Feta", "Parmesan", "Gruyere"],
        5: ["Rye Bread", "Whole Wheat Pasta", "Oat Cereal", "Crackers", "Wild Rice",
            "Cornmeal", "Muesli", "Baguette", "Rice Noodles", "Barley Flakes"],
        6: ["Smoked Sausage", "Cured Ham", "Chicken Breast", "Beef Jerky", "Pate",
            "Salami", "Turkey Roll", "Pork Ribs", "Duck Confit", "Meatballs"],
        7: ["Dried Apples", "Bean Curd", "Mixed Nuts", "Dried Figs", "Tofu Firm",
            "Raisins", "Sun-dried Tomatoes", "Prunes", "Dried Apricots", "Cashews"],
        8: ["Smoked Salmon", "Dried Seaweed", "Herring Fillets", "Crab Meat",
            "Shrimp", "Tuna Steak", "Cod Fillet", "Caviar", "Mussels", "Scallops"],
    }

    products = []
    pid = 0
    for cat_id in range(1, 9):
        words = PRODUCT_WORDS[cat_id]
        for w in words:
            if pid >= 77:
                break
            pid += 1
            sup_id = ((pid * 7) % 29) + 1
            unit_price = round(random.uniform(4.0, 120.0), 2)
            units_in_stock = random.randint(0, 125)
            discontinued = 1 if (pid % 19 == 0) else 0
            products.append((pid, w, sup_id, cat_id, unit_price, units_in_stock, discontinued))
        if pid >= 77:
            break
    PRODUCT_IDS = [p[0] for p in products]
    PRODUCT_PRICE = {p[0]: p[4] for p in products}

    # ======================================================================
    # 2) Kunden / customers
    # ======================================================================

    CITY_COUNTRY = [
        ("Berlin", "Germany"), ("Hamburg", "Germany"), ("Munich", "Germany"),
        ("London", "UK"), ("Manchester", "UK"), ("Paris", "France"),
        ("Lyon", "France"), ("Madrid", "Spain"), ("Barcelona", "Spain"),
        ("Rome", "Italy"), ("Milan", "Italy"), ("Vienna", "Austria"),
        ("Innsbruck", "Austria"), ("Zurich", "Switzerland"), ("Amsterdam", "Netherlands"),
        ("Brussels", "Belgium"), ("Lisbon", "Portugal"), ("Stockholm", "Sweden"),
        ("Oslo", "Norway"), ("Copenhagen", "Denmark"), ("Helsinki", "Finland"),
        ("Warsaw", "Poland"), ("Prague", "Czechia"), ("Dublin", "Ireland"),
        ("Graz", "Austria"), ("Cologne", "Germany"), ("Nantes", "France"),
        ("Turin", "Italy"), ("Bern", "Switzerland"), ("Bergen", "Norway"),
    ]
    COMPANY_A = [
        "Alpen", "Nord", "Sued", "Ost", "West", "Blaue", "Goldene", "Rote",
        "Grosse", "Kleine", "Feine", "Frische", "Bunte", "Alte", "Neue", "Beste",
        "Erste", "Freie", "Klare", "Stille", "Weite", "Hohe", "Tiefe", "Runde",
    ]
    COMPANY_B = [
        "Feinkost", "Handels", "Delikatessen", "Gourmet", "Markt", "Kontor",
        "Speisekammer", "Vorratshaus", "Genuss", "Bistro", "Taverna", "Cantina",
        "Emporium", "Provisions", "Larder", "Pantry", "Trading", "Import",
    ]
    COMPANY_C = ["GmbH", "AG", "KG", "Ltd.", "SARL", "S.p.A.", "BV", "AB", "OY", "& Co."]

    def make_company_name(rnd):
        return "%s %s %s" % (rnd.choice(COMPANY_A), rnd.choice(COMPANY_B), rnd.choice(COMPANY_C))

    def make_contact_name(rnd):
        return "%s %s" % (rnd.choice(FIRST_NAMES), rnd.choice(LAST_NAMES))

    used_ids = set()

    def make_customer_id(rnd):
        while True:
            cid = "".join(rnd.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ") for _ in range(5))
            if cid not in used_ids:
                used_ids.add(cid)
                return cid

    customers = {}
    customer_order = []
    customer_added_ym = {}         # cid -> (year, month) der Aufnahme
    added_in_month = {}            # (year, month) -> [cids]

    def add_customer(cid, company, contact, city, country, ym):
        customers[cid] = (company, contact, city, country)
        customer_order.append(cid)
        customer_added_ym[cid] = ym
        added_in_month.setdefault(ym, []).append(cid)

    START_YM = (1996, 7)
    add_customer("ALFKI", "Alfreds Futterkiste", "Maria Anders", "Berlin", "Germany", START_YM)
    add_customer("AROUT", "Around the Horn", "Thomas Hardy", "London", "UK", START_YM)
    used_ids.add("ALFKI")
    used_ids.add("AROUT")
    while len(customers) < 91:
        cid = make_customer_id(random)
        city, country = random.choice(CITY_COUNTRY)
        add_customer(cid, make_company_name(random), make_contact_name(random), city, country, START_YM)

    # Spezielle Neukunden, die die Systemlandschaft-Beispiele spiegeln.
    SCHEDULED_NEW = {
        (2019, 3): [("NORDW", "Nordwind Feinkost GmbH", "Lena Brandt", "Hamburg", "Germany")],
        (2024, 11): [("ALPBI", "Alpenbistro Handels AG", "Marco Keller", "Innsbruck", "Austria")],
    }
    for recs in SCHEDULED_NEW.values():
        for cid, *_ in recs:
            used_ids.add(cid)

    # ======================================================================
    # 3) Bestellungen / orders + order details
    # ======================================================================

    DISCOUNTS = [0.0, 0.05, 0.10, 0.15, 0.20, 0.25]
    orders = []
    order_details = []
    next_order_id = [10248]

    def generate_orders_for_month(year, month, n_orders, active_customers, force_alfki):
        for i in range(n_orders):
            if force_alfki and i == 0:
                cust = "ALFKI"
            else:
                cust = random.choice(active_customers)
            oid = next_order_id[0]
            next_order_id[0] += 1
            emp = random.choice(EMPLOYEE_IDS)
            day = random.randint(1, 28)
            order_date = "%04d-%02d-%02d" % (year, month, day)
            ship_via = random.randint(1, 3)
            freight = round(random.uniform(5.0, 250.0), 2)
            orders.append((oid, cust, emp, order_date, ship_via, freight))
            n_lines = random.randint(1, 5)
            chosen = random.sample(PRODUCT_IDS, n_lines)
            for prod in chosen:
                order_details.append((oid, prod, PRODUCT_PRICE[prod],
                                      random.randint(1, 40), random.choice(DISCOUNTS)))

    # Original-Zeitraum 1996-07 .. 1998-05 (nur Start-Kundenstamm).
    active = list(customer_order)
    for (y, m) in month_range((1996, 7), (1998, 5)):
        generate_orders_for_month(y, m, random.randint(15, 35), active, (m % 2 == 0))

    # Fiktive Erweiterung 1998-06 .. END (1..2 neue Kund*innen + 8..16 Bestellungen/Monat).
    for (y, m) in month_range((1998, 6), (END_YEAR, END_MONTH)):
        scheduled_recs = SCHEDULED_NEW.get((y, m), [])
        for cid, company, contact, city, country in scheduled_recs:
            add_customer(cid, company, contact, city, country, (y, m))
        n_new = random.randint(1, 2)
        added = len(scheduled_recs)
        while added < n_new:
            cid = make_customer_id(random)
            city, country = random.choice(CITY_COUNTRY)
            add_customer(cid, make_company_name(random), make_contact_name(random), city, country, (y, m))
            added += 1
        active = list(customer_order)
        generate_orders_for_month(y, m, random.randint(8, 16), active, (m % 3 != 0))

    # Index Kunde -> chronologische Bestellungen (nach der Order-Erzeugung, kein RNG).
    orders_by_customer = {}
    for o in orders:
        orders_by_customer.setdefault(o[1], []).append((o[3], o[0]))

    # ======================================================================
    # 4) ServiceHarvester machines (waechst bis END; Server-Kadenz kalibriert)
    # ======================================================================
    # RNG-Reihenfolge bleibt identisch zur fruehen Fassung: erst pc_count-Schleife
    # (randint je Jahr), dann last_contact je Server, dann je PC. Bei END=2026-07
    # sind das 4 Server -> machines.csv bitgleich.

    # PC-/Personalwachstum: Start 1998 mit WS-01, WS-02; danach 1..2 pro Jahr.
    pc_intro = {1: 1998, 2: 1998}
    pc_idx = 2
    for year in range(1999, END_YEAR + 1):
        for _ in range(random.randint(1, 2)):
            pc_idx += 1
            pc_intro[pc_idx] = year
    pc_count = pc_idx

    # Windows-Server: historische Kadenz, kalibriert auf 4 im Jahr 2026, danach
    # weiter (grob +1 alle ~8 Jahre). Einfuehrungsjahre fest (kein RNG).
    SERVER_INTRO_YEARS = [1998, 2007, 2016, 2022, 2030, 2038, 2046]
    SERVER_OS = [
        "Windows Server 2016", "Windows Server 2019", "Windows Server 2022",
        "Windows Server 2022", "Windows Server 2025", "Windows Server 2025",
        "Windows Server 2025",
    ]
    server_intro = {}
    server_os_by_idx = {}
    s_idx = 0
    for k, yr in enumerate(SERVER_INTRO_YEARS):
        if yr <= END_YEAR:
            s_idx += 1
            server_intro[s_idx] = yr
            server_os_by_idx[s_idx] = SERVER_OS[k]
    server_count = s_idx

    def last_contact(rnd):
        day = rnd.choice([6, 7])
        hour = rnd.randint(6, 22)
        minute = rnd.randint(0, 59)
        return "%04d-%02d-%02dT%02d:%02dZ" % (END_YEAR, END_MONTH, day, hour, minute)

    machines = []
    server_name = {}
    for n in range(1, server_count + 1):
        name = "SRV-%02d" % n
        server_name[n] = name
        machines.append((name, server_os_by_idx[n], last_contact(random)))
    for i in range(1, pc_count + 1):
        name = "WS-%02d" % i
        os_name = "Windows 10 Pro" if i <= max(2, pc_count // 3) else "Windows 11 Pro"
        machines.append((name, os_name, last_contact(random)))

    # ======================================================================
    # 5) CaseTracker cases (monatliche Kadenz; periodengueltige Referenzen)
    # ======================================================================
    # ALLE RNG-Draws hier liegen NACH OrderDesk/ServiceHarvester -> deren Ausgabe
    # bleibt bei gleichem (end, seed) unveraendert.
    #
    # Pro Monat 1998-06 .. END: 4 Kundenanfragen + randint(2,4) Mitarbeitenden-Anfragen.

    # Belegschaft je Arbeitsplatz (Namen: die 9 Northwind-Kraefte fuer WS-01..09,
    # danach fiktiv erzeugt). Nur zur Anzeige in Cases.
    ws_user = {}
    for n in range(1, pc_count + 1):
        if n <= 9:
            ws_user[n] = "%s %s" % (EMPLOYEES[n - 1][2], EMPLOYEES[n - 1][1])
        else:
            ws_user[n] = make_contact_name(random)

    CUST_SUBJECTS_ORDER = [
        "Lieferstatus zu Bestellung %s unklar",
        "Rechnung zu Bestellung %s weicht ab",
        "Reklamation zu Bestellung %s",
        "Aenderung an offener Bestellung %s gewuenscht",
        "Ruecksendung zu Bestellung %s beantragt",
        "Liefertermin zu Bestellung %s anfragen",
    ]
    CUST_SUBJECTS_PLAIN = [
        "Angebot fuer Grossmenge angefragt",
        "Frage zur Produktverfuegbarkeit",
        "Neuanlage Lieferadresse gewuenscht",
        "Konditionen fuer Rahmenbestellung angefragt",
    ]
    EMP_SUBJECTS_WS = [
        "OrderDesk-Login nach Passwortablauf gesperrt",
        "Arbeitsplatz %s braucht OrderDesk-Zugriff",
        "Drucker an %s nicht erreichbar",
        "Software-Update fuer %s angefragt",
        "Berechtigung fuer Reporting fehlt an %s",
        "Datenexport aus OrderDesk stockt an %s",
    ]
    EMP_SUBJECTS_SRV = [
        "%s meldet vollen Log-Datentraeger",
        "Backup auf %s pruefen",
        "Dienst-Neustart auf %s noetig",
        "Zertifikat auf %s laeuft bald ab",
    ]

    def case_status(months_from_end):
        if months_from_end >= 6:
            return random.choices(["resolved", "in_progress", "new"], weights=[88, 9, 3])[0]
        if months_from_end >= 2:
            return random.choices(["resolved", "in_progress", "new"], weights=[55, 30, 15])[0]
        return random.choices(["new", "in_progress", "resolved"], weights=[45, 40, 15])[0]

    cases = []
    case_no = 0
    eligible_customers = []       # waechst monatlich mit den Aufnahmen
    # Startkund*innen (1996-07) sind ab Beginn der Case-Zeitachse aktiv.
    eligible_customers.extend(added_in_month.get(START_YM, []))

    end_ym = (END_YEAR, END_MONTH)
    for (y, m) in month_range((1998, 6), end_ym):
        # Neue Kund*innen dieses Monats aufnehmen.
        for cid in added_in_month.get((y, m), []):
            eligible_customers.append(cid)
        months_from_end = months_between((y, m), end_ym)

        def new_case_id():
            nonlocal case_no
            case_no += 1
            return "CASE-%05d" % case_no

        def created_date():
            return "%04d-%02d-%02d" % (y, m, random.randint(1, 28))

        def ref_order_for(cid, case_date):
            cand = [oid for (d, oid) in orders_by_customer.get(cid, []) if d <= case_date]
            if not cand:
                return None
            return random.choice(cand[-12:])

        # -- 4 Kundenanfragen --
        force_alfki_idx = 0 if (m % 3 == 0) else -1  # ALFKI regelmaessig einstreuen
        for i in range(4):
            cd = created_date()
            cust = "ALFKI" if i == force_alfki_idx else random.choice(eligible_customers)
            contact = customers[cust][1]
            oid = ref_order_for(cust, cd)
            if oid is not None and random.random() < 0.7:
                subject = random.choice(CUST_SUBJECTS_ORDER) % oid
                asset = "Order %s" % oid
            else:
                subject = random.choice(CUST_SUBJECTS_PLAIN)
                asset = "Customer %s" % cust
            cases.append((new_case_id(), cd, contact, "customer", subject, asset,
                          case_status(months_from_end)))

        # -- 2..4 Mitarbeitenden-Anfragen --
        elig_ws = [n for n in range(1, pc_count + 1) if pc_intro[n] <= y]
        elig_srv = [n for n in range(1, server_count + 1) if server_intro[n] <= y]
        for _ in range(random.randint(2, 4)):
            cd = created_date()
            if elig_srv and random.random() < 0.25:
                s = random.choice(elig_srv)
                subject = random.choice(EMP_SUBJECTS_SRV) % server_name[s]
                cases.append((new_case_id(), cd, "IT-Betrieb", "employee", subject,
                              server_name[s], case_status(months_from_end)))
            else:
                n = random.choice(elig_ws) if elig_ws else 1
                ws = "WS-%02d" % n
                tmpl = random.choice(EMP_SUBJECTS_WS)
                subject = tmpl % ws if "%s" in tmpl else tmpl
                cases.append((new_case_id(), cd, ws_user.get(n, "Mitarbeitende"), "employee",
                              subject, ws, case_status(months_from_end)))

    # ======================================================================
    # 6) Ausgabe / write all files
    # ======================================================================

    write_csv(os.path.join(ORDERDESK, "categories.csv"),
              ["CategoryID", "CategoryName", "Description"], CATEGORIES)
    write_csv(os.path.join(ORDERDESK, "suppliers.csv"),
              ["SupplierID", "CompanyName", "ContactName", "City", "Country"], suppliers)
    write_csv(os.path.join(ORDERDESK, "shippers.csv"),
              ["ShipperID", "CompanyName", "Phone"], SHIPPERS)
    write_csv(os.path.join(ORDERDESK, "products.csv"),
              ["ProductID", "ProductName", "SupplierID", "CategoryID", "UnitPrice",
               "UnitsInStock", "Discontinued"], products)
    write_csv(os.path.join(ORDERDESK, "employees.csv"),
              ["EmployeeID", "LastName", "FirstName", "Title", "City", "Country", "HireDate"],
              EMPLOYEES)
    write_csv(os.path.join(ORDERDESK, "customers.csv"),
              ["CustomerID", "CompanyName", "ContactName", "City", "Country"],
              [(cid, *customers[cid]) for cid in customer_order])
    write_csv(os.path.join(ORDERDESK, "orders.csv"),
              ["OrderID", "CustomerID", "EmployeeID", "OrderDate", "ShipVia", "Freight"], orders)
    write_csv(os.path.join(ORDERDESK, "order_details.csv"),
              ["OrderID", "ProductID", "UnitPrice", "Quantity", "Discount"], order_details)

    write_csv(os.path.join(HARVESTER, "machines.csv"),
              ["MachineName", "OperatingSystem", "LastContact"], machines)

    write_csv(os.path.join(CASETRACKER, "cases.csv"),
              ["CaseID", "CreatedDate", "ContactName", "ContactType", "Subject",
               "AssetRef", "Status"], cases)

    # --- kompakte Lauf-Zusammenfassung / compact run summary --------------
    order_dates = [o[3] for o in orders]
    case_dates = [c[1] for c in cases]
    print("Secure Trader dataset generated (seed=%d, end=%04d-%02d)" % (SEED, END_YEAR, END_MONTH))
    print("  categories      : %d" % len(CATEGORIES))
    print("  suppliers       : %d" % len(suppliers))
    print("  shippers        : %d" % len(SHIPPERS))
    print("  products        : %d" % len(products))
    print("  employees (sales): %d" % len(EMPLOYEES))
    print("  customers       : %d" % len(customer_order))
    print("  orders          : %d" % len(orders))
    print("  order_details   : %d" % len(order_details))
    print("  machines        : %d (servers=%d, pcs=%d)" % (len(machines), server_count, pc_count))
    print("  cases           : %d" % len(cases))
    print("  order date range: %s .. %s" % (min(order_dates), max(order_dates)))
    print("  case date range : %s .. %s" % (min(case_dates), max(case_dates)))
    print("  ALFKI orders    : %d" % sum(1 for o in orders if o[1] == "ALFKI"))
    print("  ALFKI cases     : %d" % sum(1 for c in cases if c[2] == "Maria Anders"))


if __name__ == "__main__":
    main()
