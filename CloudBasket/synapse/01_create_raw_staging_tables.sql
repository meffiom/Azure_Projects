-- Create raw and analytics schemas
CREATE SCHEMA raw;
GO
CREATE SCHEMA analytics;
GO

CREATE TABLE raw.orders (
    order_id                      VARCHAR(50),
    customer_id                   VARCHAR(50),
    order_status                  VARCHAR(30),
    order_purchase_timestamp      VARCHAR(50),
    order_approved_at             VARCHAR(50),
    order_delivered_carrier_date  VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.customers (
    customer_id              VARCHAR(50),
    customer_unique_id       VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city            VARCHAR(100),
    customer_state           VARCHAR(5)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.order_items (
    order_id            VARCHAR(50),
    order_item_id       VARCHAR(10),
    product_id          VARCHAR(50),
    seller_id           VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price               VARCHAR(20),
    freight_value       VARCHAR(20)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.payments (
    order_id             VARCHAR(50),
    payment_sequential   VARCHAR(10),
    payment_type         VARCHAR(30),
    payment_installments VARCHAR(10),
    payment_value        VARCHAR(20)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.reviews (
    review_id               VARCHAR(50),
    order_id                VARCHAR(50),
    review_score            VARCHAR(5),
    review_comment_title    VARCHAR(100),
    review_comment_message  VARCHAR(500),
    review_creation_date    VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.products (
    product_id                 VARCHAR(50),
    product_category_name      VARCHAR(100),
    product_name_lenght        VARCHAR(10),
    product_description_lenght VARCHAR(10),
    product_photos_qty         VARCHAR(10),
    product_weight_g           VARCHAR(10),
    product_length_cm          VARCHAR(10),
    product_height_cm          VARCHAR(10),
    product_width_cm           VARCHAR(10)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.sellers (
    seller_id              VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city            VARCHAR(100),
    seller_state           VARCHAR(5)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

IF OBJECT_ID('raw.geolocation', 'U') IS NOT NULL 
    DROP TABLE raw.geolocation;

CREATE TABLE raw.geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat             VARCHAR(50),
    geolocation_lng             VARCHAR(50),
    geolocation_city            VARCHAR(200),
    geolocation_state           VARCHAR(5)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);

CREATE TABLE raw.category_translation (
    product_category_name         VARCHAR(100),
    product_category_name_english VARCHAR(100)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);


IF OBJECT_ID('raw.reviews', 'U') IS NOT NULL DROP TABLE raw.reviews;

CREATE TABLE raw.reviews (
    review_id               VARCHAR(50),
    order_id                VARCHAR(50),
    review_score            VARCHAR(5),
    review_comment_title    VARCHAR(500),
    review_comment_message  VARCHAR(4000),
    review_creation_date    VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
) WITH (DISTRIBUTION = ROUND_ROBIN, HEAP);
