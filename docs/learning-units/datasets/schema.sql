-- Secure Trader / Secure OrderDesk — portable SQL DDL (ANSI-near)
-- DE: Kanonisches Northwind-Kernschema (Feldnamen, Typen, Fremdschluessel).
--     Bewusst portabel gehalten: keine herstellerspezifischen Typen, keine
--     AUTO_INCREMENT/IDENTITY-Klauseln, damit alle sechs MSL-Sprachpfade
--     (C#, Go, Java, Python, Rust, Swift) dieselbe Datei laden koennen.
-- EN: Canonical Northwind core schema (field names, types, foreign keys),
--     kept portable so every language path can load the same file.
--
-- Datenherkunft / data origin: klassische Northwind-Traders-Sample-Datenbank,
-- markenneutral und rein didaktisch verwendet. Alle Daten sind fiktiv.
-- Reihenfolge der CREATE-Anweisungen respektiert die Fremdschluessel.

CREATE TABLE Categories (
    CategoryID   INTEGER      NOT NULL,
    CategoryName VARCHAR(15)  NOT NULL,
    Description  VARCHAR(255),
    PRIMARY KEY (CategoryID)
);

CREATE TABLE Suppliers (
    SupplierID  INTEGER      NOT NULL,
    CompanyName VARCHAR(40)  NOT NULL,
    ContactName VARCHAR(30),
    City        VARCHAR(15),
    Country     VARCHAR(15),
    PRIMARY KEY (SupplierID)
);

CREATE TABLE Shippers (
    ShipperID   INTEGER      NOT NULL,
    CompanyName VARCHAR(40)  NOT NULL,
    Phone       VARCHAR(24),
    PRIMARY KEY (ShipperID)
);

CREATE TABLE Employees (
    EmployeeID INTEGER     NOT NULL,
    LastName   VARCHAR(20) NOT NULL,
    FirstName  VARCHAR(10) NOT NULL,
    Title      VARCHAR(30),
    City       VARCHAR(15),
    Country    VARCHAR(15),
    HireDate   DATE,
    PRIMARY KEY (EmployeeID)
);

CREATE TABLE Customers (
    CustomerID  CHAR(5)      NOT NULL,
    CompanyName VARCHAR(40)  NOT NULL,
    ContactName VARCHAR(30),
    City        VARCHAR(15),
    Country     VARCHAR(15),
    PRIMARY KEY (CustomerID)
);

CREATE TABLE Products (
    ProductID    INTEGER        NOT NULL,
    ProductName  VARCHAR(40)    NOT NULL,
    SupplierID   INTEGER,
    CategoryID   INTEGER,
    UnitPrice    DECIMAL(10, 2) DEFAULT 0,
    UnitsInStock INTEGER        DEFAULT 0,
    Discontinued INTEGER        DEFAULT 0,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);

CREATE TABLE Orders (
    OrderID    INTEGER        NOT NULL,
    CustomerID CHAR(5),
    EmployeeID INTEGER,
    OrderDate  DATE,
    ShipVia    INTEGER,
    Freight    DECIMAL(10, 2) DEFAULT 0,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
    FOREIGN KEY (ShipVia)    REFERENCES Shippers (ShipperID)
);

CREATE TABLE OrderDetails (
    OrderID   INTEGER        NOT NULL,
    ProductID INTEGER        NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL DEFAULT 0,
    Quantity  INTEGER        NOT NULL DEFAULT 1,
    Discount  DECIMAL(4, 2)  NOT NULL DEFAULT 0,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID)   REFERENCES Orders (OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
