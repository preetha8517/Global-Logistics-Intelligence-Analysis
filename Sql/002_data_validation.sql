SET search_path TO logistics;

-- Structural Validation
-- Verify total row count

SELECT COUNT(*) AS total_rows
FROM orders_cleaned;

-- Verify total columns

SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name='orders_cleaned' AND table_schema='logistics';

-- Verify column data types

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name='orders_cleaned' AND table_schema='logistics'
ORDER BY ordinal_position;

--Null  validation
--Check NULL values

SELECT
COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
COUNT(*) FILTER (WHERE order_date IS NULL) AS order_date_nulls,
COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
COUNT(*) FILTER (WHERE product_name IS NULL) AS product_name_nulls,
COUNT(*) FILTER (WHERE sales IS NULL) AS sales_nulls,
COUNT(*) FILTER (WHERE order_profit IS NULL) AS order_profit_nulls,
COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_nulls
FROM orders_cleaned;

-- Check empty strings

SELECT
COUNT(*) FILTER (WHERE TRIM(product_name)='') AS product_name_empty,
COUNT(*) FILTER (WHERE TRIM(category_name)='') AS category_name_empty,
COUNT(*) FILTER (WHERE TRIM(market)='') AS market_empty,
COUNT(*) FILTER (WHERE TRIM(order_country)='') AS country_empty,
COUNT(*) FILTER (WHERE TRIM(shipping_mode)='') AS shipping_mode_empty
FROM orders_cleaned;

-- Duplicate validation
-- Check duplicate orders

SELECT
order_id,
COUNT(*)
FROM orders_cleaned
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Customer duplicates (expected)

SELECT
customer_id,
COUNT(*)
FROM orders_cleaned
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 20;

-- Domain Validation
-- Distinct markets

SELECT DISTINCT market
FROM orders_cleaned
ORDER BY market;

-- Shipping modes

SELECT
shipping_mode,
COUNT(*)
FROM orders_cleaned
GROUP BY shipping_mode
ORDER BY COUNT(*) DESC;

-- Delivery status

SELECT
delivery_status,
COUNT(*)
FROM orders_cleaned
GROUP BY delivery_status
ORDER BY COUNT(*) DESC;

-- Countries

SELECT COUNT(DISTINCT order_country)
AS total_countries
FROM orders_cleaned;
SELECT DISTINCT order_country
FROM orders_cleaned;

-- Regions

SELECT DISTINCT order_region
FROM orders_cleaned
ORDER BY order_region;

--Categories

SELECT
category_name,
COUNT(*)
FROM orders_cleaned
GROUP BY category_name
ORDER BY COUNT(*) DESC;

-- Late delivery risk

SELECT late_delivery_risk,COUNT(*)
FROM orders_cleaned 
GROUP BY late_delivery_risk
ORDER BY COUNT(*)  DESC;

-- Numerical Validation
-- Negative Sales

SELECT *
FROM orders_cleaned
WHERE sales<0;

-- Negative profits

SELECT *
FROM orders_cleaned
WHERE order_profit < 0;

-- Invalid quantity

SELECT *
FROM orders_cleaned
WHERE quantity <= 0;

-- Date Validation

-- Date range

SELECT
MIN(order_date) AS first_order,
MAX(order_date) AS last_order
FROM orders_cleaned;

--Text Validation
--Trailing spaces

SELECT *
FROM orders_cleaned
WHERE product_name <> TRIM(product_name)
   OR category_name <> TRIM(category_name)
   OR market <> TRIM(market)
   OR shipping_mode <> TRIM(shipping_mode);
   
-- Case consistency

SELECT
LOWER(shipping_mode) AS normalized_value,
COUNT(*) AS total_records
FROM orders_cleaned
GROUP BY LOWER(shipping_mode)

-- Manual spelling review

SELECT DISTINCT delivery_status
FROM orders_cleaned
ORDER BY delivery_status;

SELECT DISTINCT shipping_mode
FROM orders_cleaned
ORDER BY shipping_mode;

SELECT DISTINCT category_name
FROM orders_cleaned
ORDER BY category_name;
ORDER BY total_records DESC;