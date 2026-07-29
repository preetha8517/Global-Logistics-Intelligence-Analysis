SET search_path TO  logistics;
-- Verify row count

SELECT COUNT(*) AS total_rows
FROM orders_final;

-- Check NULL values

SELECT
COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
COUNT(*) FILTER (WHERE product_name IS NULL) AS product_name_nulls,
COUNT(*) FILTER (WHERE category_name IS NULL) AS category_name_nulls,
COUNT(*) FILTER (WHERE sales IS NULL) AS sales_nulls,
COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_nulls
FROM orders_final;

-- Check leading/trailing spaces

SELECT *
FROM orders_final
WHERE product_name <> TRIM(product_name)
   OR category_name <> TRIM(category_name);

-- Check empty strings

SELECT
COUNT(*) FILTER (WHERE TRIM(product_name) = '') AS product_name_empty,
COUNT(*) FILTER (WHERE TRIM(category_name) = '') AS category_name_empty
FROM orders_final;

-- Quantity Validation

SELECT *
FROM orders_final
WHERE quantity <= 0;

-- Sales Validation

SELECT *
FROM orders_final
WHERE sales < 0;

-- Data Type

SELECT
column_name,
data_type
FROM information_schema.columns
WHERE table_name = 'orders_final' AND table_schema='logistics'
ORDER BY ordinal_position;

-- Product name whitespaces 

SELECT COUNT(*)
FROM orders_final
WHERE product_name <> TRIM(product_name);

--Category name whitespcae

SELECT COUNT(*)
FROM orders_final
WHERE category_name <> TRIM(category_name);