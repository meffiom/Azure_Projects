-- View 1: Monthly Revenue
CREATE VIEW analytics.vw_monthly_revenue AS
SELECT
    d.year,
    d.month,
    d.month_name,
    d.month_year_label,
    COUNT(DISTINCT f.order_id)              AS total_orders,
    SUM(f.total_value)                      AS total_revenue,
    AVG(CAST(f.review_score AS FLOAT))      AS avg_review_score
FROM analytics.fact_orders f
JOIN analytics.dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name, d.month_year_label;

-- View 2: Seller Performance
CREATE VIEW analytics.vw_seller_performance AS
SELECT
    s.seller_id,
    s.city,
    s.state,
    COUNT(DISTINCT f.order_id)              AS total_orders,
    SUM(f.total_value)                      AS total_revenue,
    AVG(CAST(f.is_late AS FLOAT)) * 100     AS late_rate_pct,
    AVG(CAST(f.review_score AS FLOAT))      AS avg_review_score,
    AVG(CAST(f.delivery_days AS FLOAT))     AS avg_delivery_days
FROM analytics.fact_orders f
JOIN analytics.dim_sellers s ON f.seller_key = s.seller_key
GROUP BY s.seller_id, s.city, s.state;

-- View 3: Product Performance
CREATE VIEW analytics.vw_product_performance AS
SELECT
    p.category_name_en,
    COUNT(DISTINCT f.order_id)              AS total_orders,
    SUM(f.total_value)                      AS total_revenue,
    AVG(CAST(f.review_score AS FLOAT))      AS avg_review_score
FROM analytics.fact_orders f
JOIN analytics.dim_products p ON f.product_key = p.product_key
GROUP BY p.category_name_en;

-- View 4: Review Analysis
CREATE VIEW analytics.vw_review_analysis AS
SELECT
    p.category_name_en,
    f.review_score,
    COUNT(*)                                AS review_count,
    AVG(CAST(f.review_score AS FLOAT))      AS avg_score
FROM analytics.fact_orders f
JOIN analytics.dim_products p ON f.product_key = p.product_key
WHERE f.review_score IS NOT NULL
GROUP BY p.category_name_en, f.review_score;

-- View 5: Delivery Performance
CREATE VIEW analytics.vw_delivery_performance AS
SELECT
    c.state,
    s.seller_id,
    COUNT(DISTINCT f.order_id)              AS total_orders,
    AVG(CAST(f.delivery_days AS FLOAT))     AS avg_delivery_days,
    AVG(CAST(f.is_late AS FLOAT)) * 100     AS late_rate_pct
FROM analytics.fact_orders f
JOIN analytics.dim_customers c  ON f.customer_key = c.customer_key
JOIN analytics.dim_sellers s    ON f.seller_key   = s.seller_key
GROUP BY c.state, s.seller_id;


-- Check row counts in all tables
SELECT 'fact_orders' AS table_name, COUNT(*) AS row_count FROM analytics.fact_orders
UNION ALL
SELECT 'dim_customers', COUNT(*) FROM analytics.dim_customers
UNION ALL
SELECT 'dim_sellers', COUNT(*) FROM analytics.dim_sellers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM analytics.dim_products
UNION ALL
SELECT 'dim_date', COUNT(*) FROM analytics.dim_date
UNION ALL
SELECT 'dim_payment_types', COUNT(*) FROM analytics.dim_payment_types
UNION ALL
SELECT 'dim_order_status', COUNT(*) FROM analytics.dim_order_status;