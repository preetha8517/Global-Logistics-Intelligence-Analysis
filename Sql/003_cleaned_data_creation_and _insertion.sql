SET search_path TO logistics;
CREATE TABLE orders_final (
    order_id INTEGER,
    order_date TIMESTAMP,
    customer_id INTEGER,
    customer_fname VARCHAR(50),
    customer_lname VARCHAR(50),
    product_name VARCHAR(255),
    category_name VARCHAR(100),
    market VARCHAR(50),
    order_country VARCHAR(100),
    order_region VARCHAR(100),
    sales NUMERIC(10,2),
    order_profit NUMERIC(10,2),
    quantity INTEGER,
    delivery_status VARCHAR(50),
    shipping_mode VARCHAR(50),
    late_delivery_risk INTEGER
);

INSERT INTO orders_final
SELECT DISTINCT
    order_id,
    order_date,
    customer_id,
    INITCAP(TRIM(customer_fname)) AS customer_fname,
    INITCAP(TRIM(customer_lname)) AS customer_lname,
    TRIM(product_name) AS product_name,
    TRIM(category_name) AS category_name,
    TRIM(market) AS market,
    INITCAP(TRIM(order_country)) AS order_country,
    INITCAP(TRIM(order_region)) AS order_region,
    sales,
    order_profit,
    quantity,
    INITCAP(TRIM(delivery_status)) AS delivery_status,
    INITCAP(TRIM(shipping_mode)) AS shipping_mode,
    late_delivery_risk
FROM orders_cleaned
WHERE
    quantity > 0
    AND sales >= 0
    AND late_delivery_risk IN (0,1);