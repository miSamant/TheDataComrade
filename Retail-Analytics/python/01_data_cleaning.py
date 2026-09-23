"""
01_data_cleaning.py
--------------------
Cleans the raw CSVs from data/ and writes clean versions to data/clean/.

Run this from the project root:
    python python/01_data_cleaning.py

This is the step you'll talk about most in interviews — every transformation
below has a comment explaining *why*, not just *what*, because that's what
gets asked about.
"""

import os
import pandas as pd

RAW_DIR = "data"
CLEAN_DIR = "data/clean"
os.makedirs(CLEAN_DIR, exist_ok=True)

# ---------------------------------------------------------------------------
# Customers
# ---------------------------------------------------------------------------
customers = pd.read_csv(os.path.join(RAW_DIR, "customers_raw.csv"))

before = len(customers)
customers = customers.drop_duplicates()                     # exact duplicate rows
customers["customer_name"] = (
    customers["customer_name"].str.strip().str.title()      # trim whitespace, consistent casing
)
customers["email"] = customers["email"].fillna("unknown@missing.com")  # explicit placeholder, not silent NaN
customers["signup_date"] = pd.to_datetime(customers["signup_date"])
print(f"[customers] {before} -> {len(customers)} rows after cleaning")

# ---------------------------------------------------------------------------
# Products
# ---------------------------------------------------------------------------
products = pd.read_csv(os.path.join(RAW_DIR, "products_raw.csv"))
products["margin_pct"] = ((products["unit_price"] - products["unit_cost"]) / products["unit_price"]).round(3)

# ---------------------------------------------------------------------------
# Orders
# ---------------------------------------------------------------------------
orders = pd.read_csv(os.path.join(RAW_DIR, "orders_raw.csv"))

before = len(orders)
orders = orders.drop_duplicates()

# Standardize status casing (raw data had a mix of "Completed" / "completed")
orders["order_status"] = orders["order_status"].str.title()

# Missing quantity: rather than dropping rows (losing revenue signal from
# unit_price), impute with the median quantity per product. This is a
# defensible, documentable choice — flag it in your README/talk about it.
orders["quantity"] = orders.groupby("product_id")["quantity"].transform(
    lambda s: s.fillna(s.median())
)
orders["quantity"] = orders["quantity"].astype(int)

orders["order_date"] = pd.to_datetime(orders["order_date"])
orders["line_revenue"] = orders["quantity"] * orders["unit_price"]

print(f"[orders] {before} -> {len(orders)} rows after cleaning")
print(f"[orders] status values: {orders['order_status'].unique()}")

# ---------------------------------------------------------------------------
# Save clean files (these are what gets loaded into PostgreSQL)
# ---------------------------------------------------------------------------
customers.to_csv(os.path.join(CLEAN_DIR, "customers.csv"), index=False)
products.to_csv(os.path.join(CLEAN_DIR, "products.csv"), index=False)
orders.to_csv(os.path.join(CLEAN_DIR, "orders.csv"), index=False)

print("\nClean files written to data/clean/")
