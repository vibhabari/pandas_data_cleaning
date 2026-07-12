
-- WINDOW FUNCTION QUERIES

-- 7. Running Total of Revenue by Region

WITH daily_revenue AS
(SELECT o.region_code,DATE(o.order_date) AS order_date,
SUM(oi.quantity * oi.unit_price *(1 - oi.discount_percent / 100.0)) AS daily_revenue
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
GROUP BY o.region_code, DATE(o.order_date)
)

SELECT region_code,order_date,ROUND(daily_revenue,2) AS daily_revenue,
ROUND(SUM(daily_revenue) OVER(PARTITION BY region_code
ORDER BY order_date),2) AS running_total
FROM daily_revenue
ORDER BY region_code, order_date;

-- 8. Rank Products by Revenue


WITH product_sales AS
(SELECT p.category,p.product_id,p.product_name,
SUM(oi.quantity * oi.unit_price *(1 - oi.discount_percent / 100.0)) AS total_revenue
FROM clean_products p
JOIN clean_order_items oi ON p.product_id = oi.product_id
WHERE oi.quantity > 0
GROUP BY p.category, p.product_id,p.product_name)

SELECT category,product_id,product_name,ROUND(total_revenue,2) AS total_revenue,
DENSE_RANK() OVER(
PARTITION BY category
ORDER BY total_revenue DESC) AS rank_in_category
FROM product_sales
ORDER BY category, rank_in_category;


-- 9. Days Between Consecutive Orders


SELECT customer_id,order_date,
LAG(order_date) OVER(
PARTITION BY customer_id
ORDER BY order_date) AS previous_order_date,
ROUND(julianday(order_date) - julianday(LAG(order_date) OVER(PARTITION BY customer_id
ORDER BY order_date)),1) AS days_gap
FROM clean_orders
WHERE customer_id IS NOT NULL;

---------------------------------------------------------
-- 10. Monthly Revenue Category (CTE)
---------------------------------------------------------

WITH monthly_revenue AS
(SELECT o.customer_id,strftime('%Y-%m', o.order_date) AS month,
SUM(oi.quantity * oi.unit_price*(1 - oi.discount_percent / 100.0)) AS revenue
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
GROUP BY o.customer_id,month)

SELECT month,
CASE
WHEN revenue > 10000 THEN 'High'
WHEN revenue >= 5000 THEN 'Medium'
ELSE 'Low' END AS revenue_category,
COUNT(customer_id) AS total_customers
FROM monthly_revenue
GROUP BY month,revenue_category
ORDER BY month;

-- 11. Customer Segmentation using NTILE

WITH customer_sales AS
(SELECT o.customer_id,
SUM(oi.quantity * oi.unit_price *(1 - oi.discount_percent / 100.0)) AS total_value 
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
GROUP BY o.customer_id)

SELECT customer_id,ROUND(total_value,2) AS total_value,
NTILE(4) OVER(ORDER BY total_value DESC) AS quartile,
CASE NTILE(4) OVER(ORDER BY total_value DESC)
WHEN 1 THEN 'Platinum'
WHEN 2 THEN 'Gold'
WHEN 3 THEN 'Silver'
ELSE 'Bronze' END AS quartile_label
FROM customer_sales;

-- 12. Year-over-Year Revenue Comparison


WITH yearly_revenue AS(
SELECT strftime('%Y', o.order_date) AS year,SUM(oi.quantity * oi.unit_price *(1 - oi.discount_percent / 100.0)) AS revenue
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
GROUP BY year)

SELECT year,ROUND(revenue,2) AS revenue,LAG(ROUND(revenue,2)) OVER(
ORDER BY year) AS previous_year_revenue
FROM yearly_revenue;


-- 13. First and Latest Purchased Category

SELECT DISTINCT o.customer_id,FIRST_VALUE(p.category) OVER(
PARTITION BY o.customer_id
ORDER BY o.order_date) AS first_category,
LAST_VALUE(p.category) OVER(
PARTITION BY o.customer_id
ORDER BY o.order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS latest_category
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
JOIN clean_products p ON oi.product_id = p.product_id;

-- 14. Cumulative Revenue Percentage

WITH customer_revenue AS(
SELECT o.customer_id,SUM(oi.quantity * oi.unit_price *(1 - oi.discount_percent / 100.0)) AS revenue
FROM clean_orders o
JOIN clean_order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
GROUP BY o.customer_id)

SELECT customer_id,ROUND(revenue,2) AS revenue,
ROUND(SUM(revenue) OVER(ORDER BY revenue DESC),2) AS cumulative_revenue,
ROUND(100.0 *SUM(revenue) OVER(
ORDER BY revenue DESC)/SUM(revenue) OVER(),2) AS cumulative_percent
FROM customer_revenue
ORDER BY revenue DESC;

