"""
generate_data.py
-----------------
Generates a synthetic e-commerce dataset for the Retail Sales Analytics project.

Why synthetic data? It's reproducible (no broken download links), large enough
to be interesting, and we can inject realistic messiness (nulls, duplicates,
inconsistent formatting) so the cleaning step in 01_data_cleaning.py has real
work to do.

Output (written to this same folder):
    customers_raw.csv
    products_raw.csv
    orders_raw.csv
"""

import random
from datetime import datetime, timedelta

import numpy as np
import pandas as pd
from faker import Faker

fake = Faker()
Faker.seed(42)
random.seed(42)
np.random.seed(42)

N_CUSTOMERS = 800
N_PRODUCTS = 60
N_ORDERS = 6000
START_DATE = datetime(2024, 1, 1)
END_DATE = datetime(2025, 12, 31)

CATEGORIES = {
    "Electronics": ["Headphones", "Bluetooth Speaker", "Laptop Stand", "Webcam", "USB-C Hub", "Smartwatch"],
    "Home & Kitchen": ["Air Fryer", "Coffee Maker", "Blender", "Cutlery Set", "Storage Bins"],
    "Apparel": ["T-Shirt", "Hoodie", "Jeans", "Jacket", "Sneakers"],
    "Office": ["Desk Lamp", "Notebook Set", "Ergonomic Chair", "Whiteboard", "Pen Set"],
    "Sports": ["Yoga Mat", "Dumbbell Set", "Water Bottle", "Resistance Bands", "Running Shoes"],
}

REGIONS = ["North", "South", "East", "West", "Central"]

# ---------------------------------------------------------------------------
# 1. Customers
# ---------------------------------------------------------------------------
customers = []
for cid in range(1, N_CUSTOMERS + 1):
    signup_date = fake.date_between(start_date=START_DATE, end_date=END_DATE - timedelta(days=30))
    name = fake.name()

    # Inject messiness: inconsistent casing, occasional missing email, whitespace
    email = fake.email()
    if random.random() < 0.03:
        email = None
    if random.random() < 0.1:
        name = name.upper()
    if random.random() < 0.05:
        name = f"  {name}  "  # stray whitespace

    customers.append({
        "customer_id": cid,
        "customer_name": name,
        "email": email,
        "region": random.choice(REGIONS),
        "signup_date": signup_date,
    })

customers_df = pd.DataFrame(customers)

# Inject a handful of exact duplicate rows (common in real exports)
dupes = customers_df.sample(15, random_state=1)
customers_df = pd.concat([customers_df, dupes], ignore_index=True)

# ---------------------------------------------------------------------------
# 2. Products
# ---------------------------------------------------------------------------
products = []
pid = 1
for category, items in CATEGORIES.items():
    for item in items:
        for variant in range(1, (N_PRODUCTS // (len(CATEGORIES) * 5)) + 2):
            if pid > N_PRODUCTS:
                break
            base_price = round(random.uniform(8, 250), 2)
            products.append({
                "product_id": pid,
                "product_name": f"{item} {'' if variant == 1 else f'v{variant}'}".strip(),
                "category": category,
                "unit_cost": round(base_price * random.uniform(0.4, 0.65), 2),
                "unit_price": base_price,
            })
            pid += 1

products_df = pd.DataFrame(products[:N_PRODUCTS])

# ---------------------------------------------------------------------------
# 3. Orders (one row per order line item — like a real orders export)
# ---------------------------------------------------------------------------
order_rows = []
order_id = 1000
for _ in range(N_ORDERS):
    customer_id = random.choice(customers_df["customer_id"].unique())
    order_date = fake.date_time_between(start_date=START_DATE, end_date=END_DATE)
    n_items = np.random.choice([1, 1, 1, 2, 2, 3], p=[0.35, 0.2, 0.15, 0.15, 0.1, 0.05])

    for _ in range(n_items):
        product = products_df.sample(1).iloc[0]
        quantity = np.random.choice([1, 1, 2, 3, 4], p=[0.5, 0.2, 0.15, 0.1, 0.05])

        # Slight seasonal / promo price variation
        price = product["unit_price"]
        if random.random() < 0.15:  # occasional discount
            price = round(price * random.uniform(0.75, 0.95), 2)

        status = np.random.choice(
            ["Completed", "Completed", "Completed", "Completed", "Returned", "Cancelled"],
            p=[0.72, 0.08, 0.06, 0.04, 0.06, 0.04],
        )

        order_rows.append({
            "order_id": order_id,
            "customer_id": customer_id,
            "product_id": product["product_id"],
            "order_date": order_date,
            "quantity": quantity,
            "unit_price": price,
            "order_status": status,
        })
    order_id += 1

orders_df = pd.DataFrame(order_rows)

# Inject messiness: some null quantities, inconsistent status casing, duplicate rows
messy_idx = orders_df.sample(frac=0.02, random_state=2).index
orders_df.loc[messy_idx, "quantity"] = np.nan

case_idx = orders_df.sample(frac=0.1, random_state=3).index
orders_df.loc[case_idx, "order_status"] = orders_df.loc[case_idx, "order_status"].str.lower()

dupe_orders = orders_df.sample(30, random_state=4)
orders_df = pd.concat([orders_df, dupe_orders], ignore_index=True)

# ---------------------------------------------------------------------------
# Save
# ---------------------------------------------------------------------------
customers_df.to_csv("customers_raw.csv", index=False)
products_df.to_csv("products_raw.csv", index=False)
orders_df.to_csv("orders_raw.csv", index=False)

print(f"customers_raw.csv -> {len(customers_df)} rows")
print(f"products_raw.csv  -> {len(products_df)} rows")
print(f"orders_raw.csv    -> {len(orders_df)} rows")
