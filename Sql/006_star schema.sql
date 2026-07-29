/*

Source Tables:
customers
categories
products
shipping
locations
orders
order_items

Target Tables:
dim_customers
dim_products
dim_shipping
dim_locations
dim_date
fact_orders
*/

-- CREATE DIMENSION TABLES
CREATE TABLE dim_customers(

    customer_id INTEGER PRIMARY KEY,
    customer_fname VARCHAR(50),
    customer_lname VARCHAR(50)

);

CREATE TABLE dim_products(

    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(255),
    category_name VARCHAR(100)

);

CREATE TABLE dim_shipping(

    shipping_id INTEGER PRIMARY KEY,
    shipping_mode VARCHAR(50),
    delivery_status VARCHAR(50),
    late_delivery_risk INTEGER

);

CREATE TABLE dim_locations(

    location_id INTEGER PRIMARY KEY,
    market VARCHAR(100),
    order_country VARCHAR(100),
    order_region VARCHAR(100)

);

CREATE TABLE dim_date(

    date_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_date DATE UNIQUE,
    day INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    quarter INTEGER,
    year INTEGER,
    week_number INTEGER

);

--CREATE FACT TABLE
CREATE TABLE fact_orders(
    fact_order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER,
    date_id INTEGER,
    customer_id INTEGER,
    product_id INTEGER,
    shipping_id INTEGER,
    location_id INTEGER,
    quantity INTEGER,
    sales NUMERIC(10,2),
    order_profit NUMERIC(10,2),

    FOREIGN KEY (date_id)
    REFERENCES dim_date(date_id),

    FOREIGN KEY (customer_id)
    REFERENCES dim_customers(customer_id),

    FOREIGN KEY (product_id)
    REFERENCES dim_products(product_id),

    FOREIGN KEY (shipping_id)
    REFERENCES dim_shipping(shipping_id),

    FOREIGN KEY (location_id)
    REFERENCES dim_locations(location_id)

);

-- INSERT DATA INTO DIMENSION TABLES

INSERT INTO dim_customers

SELECT *
FROM customers;

INSERT INTO dim_products(

product_id,
product_name,
category_name

)

SELECT

p.product_id,
p.product_name,
c.category_name

FROM products p

JOIN categories c
ON p.category_id = c.category_id;


INSERT INTO dim_shipping

SELECT *
FROM shipping;

INSERT INTO dim_locations

SELECT *
FROM locations;

INSERT INTO dim_date(

full_date,
day,
month,
month_name,
quarter,
year,
week_number

)

SELECT DISTINCT

DATE(order_date),

EXTRACT(DAY FROM order_date),
EXTRACT(MONTH FROM order_date),
TO_CHAR(order_date,'Month'),
EXTRACT(QUARTER FROM order_date),
EXTRACT(YEAR FROM order_date),
EXTRACT(WEEK FROM order_date)

FROM orders

ORDER BY DATE(order_date);

-- INSERT DATA INTO FACT TABLE

INSERT INTO fact_orders(

order_id,
date_id,
customer_id,
product_id,
shipping_id,
location_id,
quantity,
sales,
order_profit

)

SELECT

oi.order_id,
d.date_id,
o.customer_id,
oi.product_id,
o.shipping_id,
o.location_id,
oi.quantity,
oi.sales,
oi.order_profit

FROM order_items oi

JOIN orders o
ON oi.order_id = o.order_id

JOIN dim_date d
ON DATE(o.order_date) = d.full_date;

-- VALIDATION
-- Row Counts

SELECT COUNT(*) FROM dim_customers;

SELECT COUNT(*) FROM dim_products;

SELECT COUNT(*) FROM dim_shipping;

SELECT COUNT(*) FROM dim_locations;

SELECT COUNT(*) FROM dim_date;

SELECT COUNT(*) FROM fact_orders;



-- Foreign Key Validation

SELECT COUNT(*)
FROM fact_orders
WHERE date_id IS NULL;


SELECT COUNT(*)
FROM fact_orders
WHERE customer_id IS NULL;


SELECT COUNT(*)
FROM fact_orders
WHERE product_id IS NULL;


SELECT COUNT(*)
FROM fact_orders
WHERE shipping_id IS NULL;


SELECT COUNT(*)
FROM fact_orders
WHERE location_id IS NULL;



/*

STAR SCHEMA IMPLEMENTED SUCCESSFULLY

Dimensions:
1. dim_customers
2. dim_products
3. dim_shipping
4. dim_locations
5. dim_date

Fact Table:
1. fact_orders

*/