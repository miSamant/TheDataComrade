-- 02_analysis_queries.sql
-- Business-question queries for the Retail Sales Analytics project.
-- These are also what feed the Metabase dashboard questions.
-- Run individually in psql, DBeaver, or paste into Metabase's SQL editor.

-- =========================================================
-- Q1. Monthly revenue trend (completed orders only)
-- =========================================================
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    ROUND(SUM(line_revenue), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM orders
WHERE order_status = 'Completed'
GROUP BY 1
ORDER BY 1;

-- =========================================================
-- Q2. Top 10 products by revenue
-- =========================================================
SELECT
    p.product_name,
    p.category,
    ROUND(SUM(o.line_revenue), 2) AS revenue,
    SUM(o.quantity) AS units_sold
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- Q3. Revenue and margin by category
-- =========================================================
SELECT
    p.category,
    ROUND(SUM(o.line_revenue), 2) AS revenue,
    ROUND(SUM(o.line_revenue * p.margin_pct), 2) AS est_gross_profit,
    ROUND(AVG(p.margin_pct) * 100, 1) AS avg_margin_pct
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;

-- =========================================================
-- Q4. Customer lifetime value (top 20)
-- =========================================================
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    ROUND(SUM(o.line_revenue), 2) AS lifetime_value,
    COUNT(DISTINCT o.order_id) AS num_orders,
    ROUND(SUM(o.line_revenue) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name, c.region
ORDER BY lifetime_value DESC
LIMIT 20;

-- =========================================================
-- Q5. Month-over-month revenue growth (window function)
-- =========================================================
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(line_revenue) AS revenue
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY 1
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(LAG(revenue) OVER (ORDER BY month), 2) AS prev_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0),
        1
    ) AS mom_growth_pct
FROM monthly
ORDER BY month;

-- =========================================================
-- Q6. RFM customer segmentation (Recency, Frequency, Monetary)
-- A classic "shows SQL depth" query — great to walk through in interviews.
-- =========================================================
WITH rfm_base AS (
    SELECT
        c.customer_id,
        c.customer_name,
        MAX(o.order_date) AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(o.line_revenue) AS monetary
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
),
rfm_scored AS (
    SELECT
        *,
        (SELECT MAX(order_date) FROM orders)::DATE - last_order_date::DATE AS recency_days,
        NTILE(4) OVER (ORDER BY (SELECT MAX(order_date) FROM orders)::DATE - last_order_date::DATE DESC) AS recency_score,
        NTILE(4) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(4) OVER (ORDER BY monetary) AS monetary_score
    FROM rfm_base
)
SELECT
    customer_id,
    customer_name,
    recency_days,
    frequency,
    ROUND(monetary, 2) AS monetary,
    recency_score,
    frequency_score,
    monetary_score,
    CASE
        WHEN recency_score >= 3 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'Champion'
        WHEN recency_score >= 3 AND frequency_score <= 2 THEN 'New / Promising'
        WHEN recency_score <= 2 AND frequency_score >= 3 THEN 'At Risk'
        WHEN recency_score <= 2 AND frequency_score <= 2 THEN 'Lost'
        ELSE 'Regular'
    END AS segment
FROM rfm_scored
ORDER BY monetary DESC;

-- =========================================================
-- Q7. Return rate by category (data quality / ops question)
-- =========================================================
SELECT
    p.category,
    COUNT(*) FILTER (WHERE o.order_status = 'Returned') AS returned,
    COUNT(*) AS total_lines,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE o.order_status = 'Returned') / COUNT(*),
        1
    ) AS return_rate_pct
FROM orders o
JOIN products p ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY return_rate_pct DESC;

-- =========================================================
-- Q8. New vs. returning customer revenue per month
-- =========================================================
WITH first_order AS (
    SELECT customer_id, MIN(DATE_TRUNC('month', order_date))::DATE AS first_month
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS month,
    CASE
        WHEN DATE_TRUNC('month', o.order_date)::DATE = f.first_month THEN 'New'
        ELSE 'Returning'
    END AS customer_type,
    ROUND(SUM(o.line_revenue), 2) AS revenue
FROM orders o
JOIN first_order f ON f.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY 1, 2
ORDER BY 1, 2;
