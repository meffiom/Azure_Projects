-- dim_customers
CREATE TABLE analytics.dim_customers (
    customer_key INT IDENTITY(1,1),
    customer_id  VARCHAR(50),
    zip_code     VARCHAR(10),
    city         VARCHAR(100),
    state        VARCHAR(5)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);

-- dim_sellers
CREATE TABLE analytics.dim_sellers (
    seller_key INT IDENTITY(1,1),
    seller_id  VARCHAR(50),
    zip_code   VARCHAR(10),
    city       VARCHAR(100),
    state      VARCHAR(5)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);

-- dim_products
CREATE TABLE analytics.dim_products (
    product_key       INT IDENTITY(1,1),
    product_id        VARCHAR(50),
    category_name_pt  VARCHAR(100),
    category_name_en  VARCHAR(100),
    product_weight_g  DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm  DECIMAL(10,2)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);

-- dim_date
CREATE TABLE analytics.dim_date (
    date_key         INT NOT NULL,
    full_date        DATE,
    year             INT,
    quarter          INT,
    month            INT,
    month_name       VARCHAR(20),
    day_of_week      INT,
    is_weekend       BIT,
    quarter_label    VARCHAR(10),
    month_year_label VARCHAR(20)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);

-- dim_payment_types
CREATE TABLE analytics.dim_payment_types (
    payment_type_key INT IDENTITY(1,1),
    payment_type     VARCHAR(30)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);

-- dim_order_status
CREATE TABLE analytics.dim_order_status (
    status_key   INT IDENTITY(1,1),
    order_status VARCHAR(30)
) WITH (DISTRIBUTION = REPLICATE, CLUSTERED COLUMNSTORE INDEX);
