-- 2. How many days has each customer visited the restaurant?
SELECT 
    customer_id AS NAME,COUNT(DISTINCT order_date) AS NO_OF_VISITS
FROM
    sales
   GROUP BY customer_id;
    