INSERT INTO analytics.fact_orders
SELECT
    o.order_id,
    c.customer_key,
    s.seller_key,
    p.product_key,
    CAST(FORMAT(TRY_CAST(o.order_purchase_timestamp AS DATETIME),
        'yyyyMMdd') AS INT)                                        AS date_key,
    o.order_status,
    pay.payment_type,
    TRY_CAST(pay.payment_value AS DECIMAL(12,2))                  AS payment_value,
    TRY_CAST(oi.price          AS DECIMAL(12,2))                  AS price,
    TRY_CAST(oi.freight_value  AS DECIMAL(12,2))                  AS freight_value,
    TRY_CAST(oi.price AS DECIMAL(12,2))
        + TRY_CAST(oi.freight_value AS DECIMAL(12,2))             AS total_value,
    TRY_CAST(r.review_score AS INT)                               AS review_score,
    DATEDIFF(day,
        TRY_CAST(o.order_purchase_timestamp AS DATETIME),
        TRY_CAST(o.order_delivered_customer_date AS DATETIME))    AS delivery_days,
    CASE 
        WHEN TRY_CAST(o.order_delivered_customer_date AS DATETIME)
            > TRY_CAST(o.order_estimated_delivery_date AS DATETIME)
        THEN 1 ELSE 0 
    END                                                            AS is_late,
    CASE 
        WHEN o.order_status = 'canceled' 
        THEN 1 ELSE 0 
    END                                                            AS is_cancelled
FROM raw.orders o
JOIN analytics.dim_customers c  ON o.customer_id  = c.customer_id
JOIN raw.order_items oi         ON o.order_id     = oi.order_id
JOIN analytics.dim_sellers s    ON oi.seller_id   = s.seller_id
JOIN analytics.dim_products p   ON oi.product_id  = p.product_id
LEFT JOIN raw.payments pay      ON o.order_id     = pay.order_id
LEFT JOIN raw.reviews r         ON o.order_id     = r.order_id;