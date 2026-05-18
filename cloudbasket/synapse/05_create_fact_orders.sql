-- Create fact_orders table
CREATE TABLE analytics.fact_orders (
    fact_key      INT IDENTITY(1,1),
    order_id      VARCHAR(50),
    customer_key  INT,
    seller_key    INT,
    product_key   INT,
    date_key      INT,
    order_status  VARCHAR(30),
    payment_type  VARCHAR(30),
    payment_value DECIMAL(12,2),
    price         DECIMAL(12,2),
    freight_value DECIMAL(12,2),
    total_value   DECIMAL(12,2),
    review_score  INT,
    delivery_days INT,
    is_late       BIT,
    is_cancelled  BIT
) WITH (
    DISTRIBUTION = HASH(customer_key),
    CLUSTERED COLUMNSTORE INDEX
);