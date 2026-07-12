
-- 15. Customer Cohort Analysis

SELECT strftime('%Y-%m', registration_date) AS cohort_month,COUNT(customer_id) AS total_customers

FROM clean_customers
GROUP BY cohort_month
ORDER BY cohort_month;


-- 16. Products Bought Together


SELECT p1.product_name AS product_a, p2.product_name AS product_b,COUNT(*) AS times_bought_together
FROM clean_order_items oi1
JOIN clean_order_items oi2 ON oi1.order_id = oi2.order_id
AND oi1.product_id < oi2.product_id
JOIN clean_products p1 ON oi1.product_id = p1.product_id

JOIN clean_products p2 ON oi2.product_id = p2.product_id
GROUP BY product_a,product_b
ORDER BY times_bought_together DESC;