-- Q 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

WITH cte AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY start_date) AS rn 
  FROM 
    subscriptions
) 
SELECT Sum(CASE
             WHEN rn = 2 AND p.plan_name = 'churn' THEN 1
             ELSE 0
           END)
       AS NO_Churned_Customer,
       Concat(Round(( Sum(CASE
                            WHEN rn = 2 AND p.plan_name = 'churn' THEN 1
                            ELSE 0
                          END) / Count(DISTINCT c.customer_id) ) * 100.0, 0),' %') 
                          AS CHURNED_PERCENTAGE
	FROM cte c INNER JOIN plans p using(plan_id); 