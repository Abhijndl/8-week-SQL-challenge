-- Q4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

WITH cte AS(
    SELECT
        COUNT(DISTINCT customer_id) AS total_customer,
        SUM(
            CASE
                WHEN p.plan_name = 'churn' THEN 1
            END
        ) AS churned_count
    FROM
        plans p
        INNER JOIN subscriptions s USING(plan_id)
)
SELECT
    total_customer,
    churned_count AS Churned_customers,
    round((churned_count / total_customer) * 100, 1) AS Percentage_Churned
FROM
    cte;