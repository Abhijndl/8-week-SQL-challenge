-- Q11 How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

WITH next_plan_cte AS (
  SELECT 
    customer_id, 
    plan_id, 
    LEAD(plan_id, 1) OVER(
      PARTITION BY customer_id 
      ORDER BY plan_id) as next_plan
      ,start_date
  FROM subscriptions)
  SELECT 
  COUNT(*) AS Downgraded_Customers_Count
FROM next_plan_cte
WHERE YEAR(start_date) = '2020'
  AND plan_id = 2 
  AND next_plan = 1;