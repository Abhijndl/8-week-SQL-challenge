-- Q1. How many customers has Foodie-Fi ever had?

SELECT
    COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMER
FROM
    subscriptions;

