-- 01_create_tables.sql
-- Run this against a fresh PostgreSQL database, e.g.:
--   psql -U postgres -d retail_analytics -f sql/01_create_tables.sql

DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id     INTEGER PRIMARY KEY,
    customer_name   TEXT NOT NULL,
    email           TEXT,
    region          TEXT,
    signup_date     DATE
);

CREATE TABLE products (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT,
    unit_cost       NUMERIC(10, 2),
    unit_price      NUMERIC(10, 2),
    margin_pct      NUMERIC(5, 3)
);

CREATE TABLE orders (
    -- Note: order_id repeats across line items (one order can have multiple
    -- products), so the real primary key is a surrogate row id.
    row_id          SERIAL PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    customer_id     INTEGER REFERENCES customers(customer_id),
    product_id      INTEGER REFERENCES products(product_id),
    order_date      TIMESTAMP NOT NULL,
    quantity        INTEGER NOT NULL,
    unit_price      NUMERIC(10, 2) NOT NULL,
    order_status    TEXT NOT NULL,
    line_revenue    NUMERIC(12, 2) NOT NULL
);

CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_product ON orders(product_id);
CREATE INDEX idx_orders_status ON orders(order_status);
