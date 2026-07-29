
-- SALES SUMMARY VIEW

CREATE VIEW vw_sales_summary AS

SELECT

l.market,
ROUND(SUM(f.sales),2) AS total_sales,
COUNT(DISTINCT f.order_id) AS total_orders

FROM fact_orders f

JOIN dim_locations l
ON f.location_id=l.location_id

GROUP BY l.market;

-- PROFIT SUMMARY VIEW

CREATE VIEW vw_profit_summary AS

SELECT

p.category_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.category_name;

-- SHIPPING PERFORMANCE VIEW

CREATE VIEW vw_shipping_summary AS

SELECT

s.shipping_mode,
COUNT(*) AS total_orders,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_shipping s
ON f.shipping_id=s.shipping_id

GROUP BY s.shipping_mode;



-- View Validation

SELECT * FROM vw_sales_summary;

SELECT * FROM vw_profit_summary;

SELECT * FROM vw_shipping_summary;

--CTEs

-- TOP 10 CUSTOMERS BY SALES


WITH customer_sales AS (

SELECT

customer_id,
SUM(sales) AS total_sales

FROM fact_orders

GROUP BY customer_id

)

SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

-- TOP PRODUCT CATEGORY


WITH category_sales AS (

SELECT

p.category_name,
SUM(f.sales) AS total_sales

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.category_name

)

SELECT *
FROM category_sales
ORDER BY total_sales DESC;

--WINDOW FUNCTIONS

-- RANK PRODUCTS BY SALES

SELECT

p.product_name,

SUM(f.sales) AS total_sales,

RANK() OVER(
ORDER BY SUM(f.sales) DESC
) AS sales_rank

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.product_name;

-- DENSE RANK CUSTOMERS

SELECT

customer_id,

SUM(sales) AS total_sales,

DENSE_RANK() OVER(
ORDER BY SUM(sales) DESC
) AS customer_rank

FROM fact_orders

GROUP BY customer_id;

--CASE STATEMENTS

-- PROFITABILITY CLASSIFICATION


SELECT

product_name,

SUM(order_profit) AS total_profit,

CASE

WHEN SUM(order_profit) > 100000
THEN 'High Profit'

WHEN SUM(order_profit) > 50000
THEN 'Medium Profit'

ELSE 'Low Profit'

END AS profit_category

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY product_name;


-- SHIPPING RISK CLASSIFICATION


SELECT

shipping_mode,

CASE

WHEN late_delivery_risk=1
THEN 'High Risk'

ELSE 'Low Risk'

END AS delivery_risk

FROM dim_shipping;

--INDEXES

-- Fact Table Indexes

CREATE INDEX idx_order_id
ON fact_orders(order_id);


CREATE INDEX idx_customer_id
ON fact_orders(customer_id);


CREATE INDEX idx_product_id
ON fact_orders(product_id);


CREATE INDEX idx_date_id
ON fact_orders(date_id);


CREATE INDEX idx_location_id
ON fact_orders(location_id);


-- Dimension Table Indexes

CREATE INDEX idx_product_name
ON dim_products(product_name);


CREATE INDEX idx_market
ON dim_locations(market);


CREATE INDEX idx_shipping_mode
ON dim_shipping(shipping_mode);

