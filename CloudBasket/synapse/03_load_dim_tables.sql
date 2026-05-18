-- Load dim_customers
INSERT INTO analytics.dim_customers
SELECT 
    customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM raw.customers;

-- Load dim_sellers
INSERT INTO analytics.dim_sellers
SELECT 
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM raw.sellers;

-- Load dim_products (joining to translation table for English names)
INSERT INTO analytics.dim_products
SELECT
    p.product_id,
    p.product_category_name,
    ISNULL(t.product_category_name_english, p.product_category_name),
    TRY_CAST(p.product_weight_g    AS DECIMAL(10,2)),
    TRY_CAST(p.product_length_cm   AS DECIMAL(10,2)),
    TRY_CAST(p.product_height_cm   AS DECIMAL(10,2)),
    TRY_CAST(p.product_width_cm    AS DECIMAL(10,2))
FROM raw.products p
LEFT JOIN raw.category_translation t
    ON p.product_category_name = t.product_category_name;

-- Load dim_payment_types
INSERT INTO analytics.dim_payment_types
SELECT DISTINCT payment_type
FROM raw.payments
WHERE payment_type IS NOT NULL;

-- Load dim_order_status
INSERT INTO analytics.dim_order_status
SELECT DISTINCT order_status
FROM raw.orders
WHERE order_status IS NOT NULL;