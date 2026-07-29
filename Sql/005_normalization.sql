SET search_path TO logistics;
/*
DATABASE NORMALIZATION (3NF)

Source Table:
orders_final

Normalized Tables:
1. customers
2. categories
3. products
4. shipping
5. locations
6. orders
7. order_items

*/

-- CUSTOMERS TABLE

CREATE TABLE customers(

	customer_id INTEGER PRIMARY KEY,
	customer_fname VARCHAR(50) NOT NULL,
	customer_lname VARCHAR(50) 

);


-- CATEGORIES TABLE

CREATE TABLE categories(

	category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	category_name VARCHAR(100) UNIQUE NOT NULL

);

-- PRODUCTS TABLE

CREATE TABLE products(

	product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	product_name VARCHAR(255) UNIQUE NOT NULL,
	category_id INTEGER NOT NULL REFERENCES categories(category_id)

);

-- SHIPPING TABLE

CREATE TABLE shipping(

	shipping_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	shipping_mode VARCHAR(50) NOT NULL,
	delivery_status VARCHAR(50) NOT NULL,
	late_delivery_risk INTEGER NOT NULL

);

-- LOCATIONS TABLE

CREATE TABLE locations(

	location_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	market VARCHAR(100) NOT NULL,
	order_country VARCHAR(100) NOT NULL,
	order_region VARCHAR(100) NOT NULL

);
-- ORDERS TABLE

CREATE TABLE orders(

	order_id INTEGER PRIMARY KEY,
	order_date TIMESTAMP NOT NULL,
	customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
	shipping_id INTEGER NOT NULL REFERENCES shipping(shipping_id),
	location_id INTEGER NOT NULL REFERENCES locations(location_id)

);

-- ORDER ITEMS TABLE

CREATE TABLE order_items(

	order_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	order_id INTEGER NOT NULL REFERENCES orders(order_id),
	product_id INTEGER NOT NULL REFERENCES products(product_id),
	quantity INTEGER NOT NULL,
	sales NUMERIC(10,2) NOT NULL,
	order_profit NUMERIC(10,2) NOT NULL

);

--Insertion 

INSERT INTO customers (
    customer_id,
    customer_fname,
    customer_lname
)
SELECT DISTINCT
    customer_id,
    customer_fname,
    customer_lname
FROM orders_final;