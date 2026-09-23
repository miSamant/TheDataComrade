"""
02_eda.py
---------
Exploratory Data Analysis on the cleaned dataset. Produces a handful of PNG
charts in python/eda_charts/ that you can drop straight into your resume
project README or a portfolio page.

Run from project root:
    python python/02_eda.py
"""

import os
import pandas as pd
import matplotlib.pyplot as plt

OUT_DIR = "python/eda_charts"
os.makedirs(OUT_DIR, exist_ok=True)

customers = pd.read_csv("data/clean/customers.csv", parse_dates=["signup_date"])
products = pd.read_csv("data/clean/products.csv")
orders = pd.read_csv("data/clean/orders.csv", parse_dates=["order_date"])

completed = orders[orders["order_status"] == "Completed"]

# 1. Monthly revenue trend
monthly = (
    completed.set_index("order_date")
    .resample("MS")["line_revenue"]
    .sum()
)
plt.figure(figsize=(9, 4))
monthly.plot(marker="o")
plt.title("Monthly Revenue (Completed Orders)")
plt.ylabel("Revenue ($)")
plt.xlabel("Month")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/monthly_revenue.png", dpi=120)
plt.close()

# 2. Revenue by category
merged = completed.merge(products, on="product_id")
by_cat = merged.groupby("category")["line_revenue"].sum().sort_values(ascending=False)
plt.figure(figsize=(8, 4))
by_cat.plot(kind="bar", color="#4C72B0")
plt.title("Revenue by Category")
plt.ylabel("Revenue ($)")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/revenue_by_category.png", dpi=120)
plt.close()

# 3. Order status breakdown
status_counts = orders["order_status"].value_counts()
plt.figure(figsize=(5, 5))
status_counts.plot(kind="pie", autopct="%1.1f%%")
plt.title("Order Status Breakdown")
plt.ylabel("")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/order_status.png", dpi=120)
plt.close()

# 4. Revenue by region
by_region = merged.merge(customers, on="customer_id").groupby("region")["line_revenue"].sum().sort_values(ascending=False)
plt.figure(figsize=(7, 4))
by_region.plot(kind="bar", color="#55A868")
plt.title("Revenue by Customer Region")
plt.ylabel("Revenue ($)")
plt.tight_layout()
plt.savefig(f"{OUT_DIR}/revenue_by_region.png", dpi=120)
plt.close()

print("Summary stats")
print("-------------")
print(f"Total completed revenue: ${completed['line_revenue'].sum():,.2f}")
print(f"Total orders (unique order_id): {orders['order_id'].nunique()}")
print(f"Return rate: {(orders['order_status'] == 'Returned').mean():.1%}")
print(f"Cancellation rate: {(orders['order_status'] == 'Cancelled').mean():.1%}")
print(f"\nCharts saved to {OUT_DIR}/")
