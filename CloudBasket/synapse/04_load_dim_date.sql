-- Load dim_date with all dates from orders
INSERT INTO analytics.dim_date
SELECT DISTINCT
    CAST(FORMAT(TRY_CAST(order_purchase_timestamp AS DATETIME), 'yyyyMMdd') AS INT) AS date_key,
    CAST(TRY_CAST(order_purchase_timestamp AS DATETIME) AS DATE) AS full_date,
    YEAR(TRY_CAST(order_purchase_timestamp AS DATETIME)) AS year,
    DATEPART(QUARTER, TRY_CAST(order_purchase_timestamp AS DATETIME)) AS quarter,
    MONTH(TRY_CAST(order_purchase_timestamp AS DATETIME)) AS month,
    DATENAME(MONTH, TRY_CAST(order_purchase_timestamp AS DATETIME)) AS month_name,
    DATEPART(WEEKDAY, TRY_CAST(order_purchase_timestamp AS DATETIME)) AS day_of_week,
    CASE WHEN DATEPART(WEEKDAY, TRY_CAST(order_purchase_timestamp AS DATETIME)) 
        IN (1,7) THEN 1 ELSE 0 END AS is_weekend,
    'Q' + CAST(DATEPART(QUARTER, TRY_CAST(order_purchase_timestamp AS DATETIME)) AS VARCHAR) 
        AS quarter_label,
    DATENAME(MONTH, TRY_CAST(order_purchase_timestamp AS DATETIME)) + ' ' + 
        CAST(YEAR(TRY_CAST(order_purchase_timestamp AS DATETIME)) AS VARCHAR) 
        AS month_year_label
FROM raw.orders
WHERE order_purchase_timestamp IS NOT NULL
AND TRY_CAST(order_purchase_timestamp AS DATETIME) IS NOT NULL;