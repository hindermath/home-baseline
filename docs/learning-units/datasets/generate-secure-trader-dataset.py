#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Deterministic sample-data generator for the Secure Trader universe.

DE: Erzeugt konsistente, fiktive Beispieldaten fuer die drei Systeme
    (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker) bis
    einschliesslich Juli 2026. Grundlage ist das klassische Northwind-Layout.
EN: Produces consistent, fictional sample data for the three systems up to and
    including July 2026, based on the classic Northwind layout.

WHY deterministic:
    Alle Lernpfade (C#, Go, Java, Python, Rust, Swift) muessen exakt denselben
    Datenbestand erhalten. Deshalb wird EIN fester Seed gesetzt und es gibt
    KEINE Abhaengigkeit von der Wanduhr (kein datetime.now(), keine echte Zeit,
    kein os.urandom). Der Endmonat ist fest auf 2026-07 kodiert, nicht aus dem
    heutigen Datum abgeleitet. So ist jeder Lauf bitgleich reproduzierbar.
"""

import csv
import os
import random

# --- Determinismus / Determinism ------------------------------------------
# WHY 20260707: fester, dokumentierter Seed. Aendern => komplett neuer, aber
# weiterhin reproduzierbarer Datenbestand. Nie durch time-basierte Werte ersetzen.
SEED = 20260707
random.seed(SEED)

# Fester Snapshot-Endpunkt / fixed snapshot end point (NOT derived from clock).
END_YEAR, END_MONTH = 2026, 7

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ORDERDESK = os.path.join(BASE_DIR, "orderdesk")
HARVESTER = os.path.join(BASE_DIR, "serviceharvester")
CASETRACKER = os.path.join(BASE_DIR, "casetracker")
for _d in (ORDERDESK, HARVESTER, CASETRACKER):
    os.makedirs(_d, exist_ok=True)


def write_csv(path, header, rows):
    """Schreibt eine CSV mit fester Spaltenreihenfolge (LF, UTF-8)."""
    with open(path, "w", newline="", encoding="utf-8") as fh:
        writer = csv.writer(fh)
        writer.writerow(header)
        writer.writerows(rows)


# ==========================================================================
# 1) Northwind-Stammdaten / static reference data
# ==========================================================================

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

# --- Suppliers (29) --------------------------------------------------------
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

# --- Products (77) ---------------------------------------------------------
# Plausible, markenneutrale Namensbausteine je Kategorie.
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
# 77 Produkte verteilt ueber 8 Kategorien; Namen bleiben eindeutig.
for cat_id in range(1, 9):
    words = PRODUCT_WORDS[cat_id]
    # ~10 Produkte je Kategorie, aber Gesamtzahl bei 77 kappen.
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


# ==========================================================================
# 2) Kunden / customers
# ==========================================================================

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
    return "%s %s %s" % (
        rnd.choice(COMPANY_A), rnd.choice(COMPANY_B), rnd.choice(COMPANY_C)
    )


def make_contact_name(rnd):
    return "%s %s" % (rnd.choice(FIRST_NAMES), rnd.choice(LAST_NAMES))


used_ids = set()


def make_customer_id(rnd, forced=None):
    """Erzeugt eine eindeutige 5-Grossbuchstaben-CustomerID."""
    if forced is not None:
        used_ids.add(forced)
        return forced
    while True:
        cid = "".join(rnd.choice("ABCDEFGHIJKLMNOPQRSTUVWXYZ") for _ in range(5))
        if cid not in used_ids:
            used_ids.add(cid)
            return cid


# customers: dict CustomerID -> (CompanyName, ContactName, City, Country)
customers = {}
customer_order = []  # insertion order for CSV output


def add_customer(cid, company, contact, city, country):
    customers[cid] = (company, contact, city, country)
    customer_order.append(cid)


# Pflicht- und Anker-Datensaetze / mandatory and anchor records.
add_customer("ALFKI", "Alfreds Futterkiste", "Maria Anders", "Berlin", "Germany")
add_customer("AROUT", "Around the Horn", "Thomas Hardy", "London", "UK")

# Restliche 89 Start-Kund*innen (91 gesamt) fiktiv/plausibel.
while len(customers) < 91:
    cid = make_customer_id(random)
    city, country = random.choice(CITY_COUNTRY)
    add_customer(cid, make_company_name(random), make_contact_name(random), city, country)

# Spezielle Neukunden, die die Systemlandschaft-Beispiele spiegeln.
# WHY: CaseTracker verweist auf NORDW (2019-03) und ALPBI (2024-11).
SCHEDULED_NEW = {
    (2019, 3): [("NORDW", "Nordwind Feinkost GmbH", "Lena Brandt", "Hamburg", "Germany")],
    (2024, 11): [("ALPBI", "Alpenbistro Handels AG", "Marco Keller", "Innsbruck", "Austria")],
}
for recs in SCHEDULED_NEW.values():
    for cid, *_ in recs:
        used_ids.add(cid)


# ==========================================================================
# 3) Bestellungen / orders + order details
# ==========================================================================

DISCOUNTS = [0.0, 0.05, 0.10, 0.15, 0.20, 0.25]

orders = []          # (OrderID, CustomerID, EmployeeID, OrderDate, ShipVia, Freight)
order_details = []   # (OrderID, ProductID, UnitPrice, Quantity, Discount)
next_order_id = 10248  # klassischer Northwind-Start-OrderID


def month_range(start, end):
    """Liefert (year, month)-Tupel inklusive Start bis inklusive End."""
    y, m = start
    ey, em = end
    while (y, m) <= (ey, em):
        yield (y, m)
        m += 1
        if m > 12:
            m = 1
            y += 1


def generate_orders_for_month(year, month, n_orders, active_customers, force_alfki):
    global next_order_id
    for i in range(n_orders):
        # WHY force_alfki: ALFKI muss ueber den gesamten Zeitraum regelmaessig
        # auftauchen; deshalb wird pro so markiertem Monat eine Bestellung fix
        # auf ALFKI gesetzt.
        if force_alfki and i == 0:
            cust = "ALFKI"
        else:
            cust = random.choice(active_customers)
        oid = next_order_id
        next_order_id += 1
        emp = random.choice(EMPLOYEE_IDS)
        day = random.randint(1, 28)  # 28 -> monatsunabhaengig gueltig
        order_date = "%04d-%02d-%02d" % (year, month, day)
        ship_via = random.randint(1, 3)
        freight = round(random.uniform(5.0, 250.0), 2)
        orders.append((oid, cust, emp, order_date, ship_via, freight))

        # 1..5 eindeutige Positionen je Bestellung.
        n_lines = random.randint(1, 5)
        chosen = random.sample(PRODUCT_IDS, n_lines)
        for prod in chosen:
            unit_price = PRODUCT_PRICE[prod]
            qty = random.randint(1, 40)
            disc = random.choice(DISCOUNTS)
            order_details.append((oid, prod, unit_price, qty, disc))


# --- Original-Zeitraum 1996-07 .. 1998-05 (nur Start-Kundenstamm) ----------
active = list(customer_order)  # die 91 Start-Kund*innen
for (y, m) in month_range((1996, 7), (1998, 5)):
    n = random.randint(15, 35)
    # ALFKI mindestens jeden zweiten Monat aktiv halten.
    force = (m % 2 == 0)
    generate_orders_for_month(y, m, n, active, force)

# --- Fiktive Erweiterung 1998-06 .. 2026-07 --------------------------------
for (y, m) in month_range((1998, 6), (END_YEAR, END_MONTH)):
    # 1..2 neue Kund*innen pro Monat.
    scheduled = SCHEDULED_NEW.get((y, m), [])
    for cid, company, contact, city, country in scheduled:
        add_customer(cid, company, contact, city, country)
    n_new = random.randint(1, 2)
    while len(scheduled) < n_new:
        cid = make_customer_id(random)
        city, country = random.choice(CITY_COUNTRY)
        add_customer(cid, make_company_name(random), make_contact_name(random), city, country)
        scheduled.append(cid)
    active = list(customer_order)  # alt + neu gemischt

    n_orders = random.randint(8, 16)
    # ALFKI regelmaessig: in ~2 von 3 Monaten mindestens eine ALFKI-Bestellung.
    force = (m % 3 != 0)
    generate_orders_for_month(y, m, n_orders, active, force)


# ==========================================================================
# 4) ServiceHarvester machines
# ==========================================================================

# WHY: Start 1998 mit WS-01, WS-02 (2 Arbeitsplaetze) + SRV-01.
# Danach pro Jahr 1..2 neue Arbeitsplaetze; SRV-02..SRV-04 kamen mit der Last.
machines = []
PC_OS = ["Windows 10 Pro", "Windows 11 Pro"]

pc_count = 2  # WS-01, WS-02 aus 1998
for year in range(1999, END_YEAR + 1):
    pc_count += random.randint(1, 2)

# 4 Windows-Server / four windows servers.
SERVERS = [
    ("SRV-01", "Windows Server 2016"),
    ("SRV-02", "Windows Server 2019"),
    ("SRV-03", "Windows Server 2022"),
    ("SRV-04", "Windows Server 2022"),
]


def last_contact(rnd):
    """Plausibler letzter Kontakt nahe 2026-07 (aktive Maschine)."""
    day = rnd.choice([6, 7])       # 2026-07-06 / 2026-07-07
    hour = rnd.randint(6, 22)
    minute = rnd.randint(0, 59)
    return "2026-07-%02dT%02d:%02dZ" % (day, hour, minute)


for name, os_name in SERVERS:
    machines.append((name, os_name, last_contact(random)))

for i in range(1, pc_count + 1):
    name = "WS-%02d" % i
    # AEltere Arbeitsplaetze eher Windows 10, neuere Windows 11 Pro.
    os_name = "Windows 10 Pro" if i <= max(2, pc_count // 3) else "Windows 11 Pro"
    machines.append((name, os_name, last_contact(random)))


# ==========================================================================
# 5) CaseTracker cases
# ==========================================================================

# Reale Referenzen aus den erzeugten Daten ziehen / pull real references.
def first_order_for(cid):
    for o in orders:
        if o[1] == cid:
            return o[0]
    return None


alfki_order = None
for o in orders:
    if o[1] == "ALFKI":
        alfki_order = o[0]  # erste ALFKI-Bestellung
        break
nordw_order = first_order_for("NORDW")

cases = [
    # Kundenanfragen / customer cases (4)
    ("CASE-0001", "Maria Anders", "customer",
     "Lieferstatus zu Bestellung %s unklar" % alfki_order, "Order %s" % alfki_order, "in_progress"),
    ("CASE-0002", "Thomas Hardy", "customer",
     "Angebot fuer Grossmenge Produkt 28 angefragt", "Product 28", "new"),
    ("CASE-0003", "Lena Brandt", "customer",
     "Rechnung zu Bestellung %s weicht ab" % nordw_order, "Order %s" % nordw_order, "in_progress"),
    ("CASE-0004", "Marco Keller", "customer",
     "Neuanlage Lieferadresse gewuenscht", "Customer ALPBI", "resolved"),
    # Mitarbeitenden-Anfragen / employee cases (3)
    ("CASE-0005", "Nancy Davolio", "employee",
     "OrderDesk-Login nach Passwortablauf gesperrt", "WS-01", "resolved"),
    ("CASE-0006", "Margaret Peacock", "employee",
     "SRV-03 meldet vollen Log-Datentraeger", "SRV-03", "in_progress"),
    ("CASE-0007", "Anne Dodsworth", "employee",
     "Arbeitsplatz WS-07 braucht OrderDesk-Zugriff", "WS-07", "new"),
]


# ==========================================================================
# 6) Ausgabe / write all files
# ==========================================================================

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
          ["OrderID", "CustomerID", "EmployeeID", "OrderDate", "ShipVia", "Freight"],
          orders)
write_csv(os.path.join(ORDERDESK, "order_details.csv"),
          ["OrderID", "ProductID", "UnitPrice", "Quantity", "Discount"],
          order_details)

write_csv(os.path.join(HARVESTER, "machines.csv"),
          ["MachineName", "OperatingSystem", "LastContact"], machines)

write_csv(os.path.join(CASETRACKER, "cases.csv"),
          ["CaseID", "ContactName", "ContactType", "Subject", "AssetRef", "Status"], cases)


# --- kompakte Lauf-Zusammenfassung / compact run summary -------------------
order_dates = [o[3] for o in orders]
print("Secure Trader dataset generated (seed=%d, end=%04d-%02d)" % (SEED, END_YEAR, END_MONTH))
print("  categories      : %d" % len(CATEGORIES))
print("  suppliers       : %d" % len(suppliers))
print("  shippers        : %d" % len(SHIPPERS))
print("  products        : %d" % len(products))
print("  employees       : %d" % len(EMPLOYEES))
print("  customers       : %d" % len(customer_order))
print("  orders          : %d" % len(orders))
print("  order_details   : %d" % len(order_details))
print("  machines        : %d (servers=4, pcs=%d)" % (len(machines), pc_count))
print("  cases           : %d" % len(cases))
print("  order date range: %s .. %s" % (min(order_dates), max(order_dates)))
print("  ALFKI orders    : %d" % sum(1 for o in orders if o[1] == "ALFKI"))
