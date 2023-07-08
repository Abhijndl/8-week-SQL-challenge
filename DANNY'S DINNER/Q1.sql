
-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id AS CUSTOMER_NAME, SUM(price) AS TOTAL_SPENT
FROM
    menu m
        JOIN
    sales s ON m.product_id = s.product_id
GROUP BY s.customer_id;