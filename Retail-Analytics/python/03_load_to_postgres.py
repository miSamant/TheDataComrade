"""
03_load_to_postgres.py
-----------------------
Loads the cleaned CSVs into the PostgreSQL database created by
sql/01_create_tables.sql.

Before running:
    1. Make sure PostgreSQL is installed and running (see INSTALLATION.md)
    2. Create the database:      createdb retail_analytics
    3. Create the tables:        psql -d retail_analytics -f sql/01_create_tables.sql
    4. pip install sqlalchemy psycopg2-binary

Then run from project root:
    python python/03_load_to_postgres.py
"""

import pandas as pd
from sqlalchemy import create_engine

# ---- EDIT THESE to match your local PostgreSQL setup -----------------
DB_USER = "postgres"
DB_PASSWORD = "postgres"       # whatever you set during install
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "retail_analytics"
# ------------------------------------------------------------------------

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

customers = pd.read_csv("data/clean/customers.csv")
products = pd.read_csv("data/clean/products.csv")
orders = pd.read_csv("data/clean/orders.csv")

# order matters: customers/products first (orders has foreign keys to them)
customers.to_sql("customers", engine, if_exists="append", index=False)
products.to_sql("products", engine, if_exists="append", index=False)
orders.drop(columns=["row_id"], errors="ignore").to_sql(
    "orders", engine, if_exists="append", index=False
)

print("Loaded:")
print(f"  customers: {len(customers)} rows")
print(f"  products:  {len(products)} rows")
print(f"  orders:    {len(orders)} rows")
