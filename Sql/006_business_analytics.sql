SET search_path TO logistics;
-- SALES ANALYTICS
-- Total Sales

SELECT
ROUND(SUM(sales),2) AS total_sales
FROM fact_orders;

--Total Orders

SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM fact_orders;

--Average Order Value

SELECT
ROUND(SUM(sales)/COUNT(DISTINCT order_id),2)
AS average_order_value
FROM fact_orders;



-- Monthly Sales Trend

SELECT
d.month_name,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_date d
ON f.date_id = d.date_id

GROUP BY d.month_name,d.month
ORDER BY d.month;



-- Quarterly Sales Trend

SELECT
d.quarter,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_date d
ON f.date_id = d.date_id

GROUP BY d.quarter
ORDER BY d.quarter;



-- Sales By Market

SELECT
l.market,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_locations l
ON f.location_id = l.location_id

GROUP BY l.market
ORDER BY total_sales DESC;

-- Sales By Country

SELECT
l.order_country,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_locations l
ON f.location_id = l.location_id

GROUP BY l.order_country
ORDER BY total_sales DESC;



--Top 10 Sales Days

SELECT
d.full_date,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_date d
ON f.date_id = d.date_id

GROUP BY d.full_date
ORDER BY total_sales DESC
LIMIT 10;

-- PROFIT ANALYTICS
-- Total Profit

SELECT
ROUND(SUM(order_profit),2) AS total_profit
FROM fact_orders;

--Profit Margin %

SELECT

ROUND(
(SUM(order_profit)/SUM(sales))*100
,2) AS profit_margin_percentage

FROM fact_orders;

--Profit By Market

SELECT

l.market,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_locations l
ON f.location_id=l.location_id

GROUP BY l.market
ORDER BY total_profit DESC;

--Top 10 Profitable Products

SELECT

p.product_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 10;

--Least Profitable Products

SELECT

p.product_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.product_name
ORDER BY total_profit ASC
LIMIT 10;

--Profit By Category

SELECT

p.category_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.category_name
ORDER BY total_profit DESC;



--Monthly Profit Trend

SELECT

d.month_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_date d
ON f.date_id=d.date_id

GROUP BY d.month_name,d.month
ORDER BY d.month;



--Profit By Country

SELECT

l.order_country,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_locations l
ON f.location_id=l.location_id

GROUP BY l.order_country
ORDER BY total_profit DESC;

--CUSTOMER ANALYTICS

--Total Customers

SELECT
COUNT(*) AS total_customers
FROM dim_customers;

--Top Customers By Sales

SELECT

c.customer_id,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_customers c
ON f.customer_id=c.customer_id

GROUP BY c.customer_id
ORDER BY total_sales DESC
LIMIT 10;

--Top Customers By Profit

SELECT

c.customer_id,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_customers c
ON f.customer_id=c.customer_id

GROUP BY c.customer_id
ORDER BY total_profit DESC
LIMIT 10;

--Average Customer Spending

SELECT

ROUND(
SUM(sales)/COUNT(DISTINCT customer_id)
,2)

AS average_customer_spending

FROM fact_orders;



--Repeat Customer Analysis

SELECT

customer_id,
COUNT(DISTINCT order_id) AS total_orders

FROM fact_orders

GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)>1

ORDER BY total_orders DESC;



--Customer Contribution %

SELECT

customer_id,

ROUND(
SUM(sales)*100/
(SELECT SUM(sales) FROM fact_orders)
,2)

AS contribution_percentage

FROM fact_orders

GROUP BY customer_id
ORDER BY contribution_percentage DESC;

--SHIPPING ANALYTICS
--Orders By Shipping Mode

SELECT

s.shipping_mode,
COUNT(*) AS total_orders

FROM fact_orders f

JOIN dim_shipping s
ON f.shipping_id=s.shipping_id

GROUP BY s.shipping_mode;

--Late Delivery Analysis

SELECT

delivery_status,
COUNT(*) AS total_orders

FROM dim_shipping

GROUP BY delivery_status;



-- Late Delivery Percentage

SELECT

ROUND(
AVG(late_delivery_risk)*100
,2)

AS late_delivery_percentage

FROM dim_shipping;

--Shipping Mode Performance

SELECT

s.shipping_mode,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_shipping s
ON f.shipping_id=s.shipping_id

GROUP BY s.shipping_mode
ORDER BY total_sales DESC;



--Delivery Status Distribution

SELECT

delivery_status,
COUNT(*) AS total_records

FROM dim_shipping

GROUP BY delivery_status;

--High Risk Orders

SELECT
COUNT(*) AS high_risk_orders

FROM fact_orders f

JOIN dim_shipping s
ON f.shipping_id=s.shipping_id

WHERE late_delivery_risk=1;


-- PRODUCT ANALYTICS
--Top Products By Sales

SELECT

p.product_name,
ROUND(SUM(f.sales),2) AS total_sales

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;



--Top Products By Profit

SELECT

p.product_name,
ROUND(SUM(f.order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 10;

--Top Categories

SELECT

category_name,
ROUND(SUM(sales),2) AS total_sales

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY category_name
ORDER BY total_sales DESC;

--Category Profitability

SELECT

category_name,
ROUND(SUM(order_profit),2) AS total_profit

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY category_name
ORDER BY total_profit DESC;

--Quantity Sold By Product

SELECT

product_name,
SUM(quantity) AS quantity_sold

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY product_name
ORDER BY quantity_sold DESC;

--Product Contribution %

SELECT

product_name,

ROUND(

SUM(sales)*100/
(SELECT SUM(sales) FROM fact_orders)

,2)

AS contribution_percentage

FROM fact_orders f

JOIN dim_products p
ON f.product_id=p.product_id

GROUP BY product_name
ORDER BY contribution_percentage DESC;


-- LOCATION ANALYTICS
--Sales By Region

SELECT

order_region,
ROUND(SUM(sales),2) AS total_sales

FROM fact_orders f

JOIN dim_locations l
ON f.location_id=l.location_id

GROUP BY order_region
ORDER BY total_sales DESC;



--Profit By Region

SELECT
order_region,
ROUND(SUM(order_profit),2) AS total_profit
FROM fact_orders f
JOIN dim_locations l
ON f.location_id=l.location_id
GROUP BY order_region
ORDER BY total_profit DESC;



--Market Performance

SELECT
market,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(order_profit),2) AS total_profit
FROM fact_orders f
JOIN dim_locations l
ON f.location_id=l.location_id
GROUP BY market
ORDER BY total_sales DESC;

--Most Profitable Regions

SELECT
order_region,
ROUND(SUM(order_profit),2) AS total_profit
FROM fact_orders f
JOIN dim_locations l
ON f.location_id=l.location_id
GROUP BY order_region
ORDER BY total_profit DESC
LIMIT 10;

--Underperforming Regions

SELECT
order_region,
ROUND(SUM(order_profit),2) AS total_profit
FROM fact_orders f
JOIN dim_locations l
ON f.location_id=l.location_id
GROUP BY order_region
ORDER BY total_profit ASC
LIMIT 10;

--Total Quantity Sold

SELECT
SUM(quantity) AS total_quantity_sold
FROM fact_orders;
