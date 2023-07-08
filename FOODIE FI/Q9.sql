-- Q9 How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi? 
WITH trial AS 
  (SELECT 
    customer_id, 
    start_date AS trial_date
  FROM subscriptions
  WHERE plan_id = 0
),
pro_annual AS
  (SELECT 
    customer_id, 
    start_date AS annual_date
  FROM subscriptions
  WHERE plan_id = 3
)
SELECT 
  ROUND(AVG(datediff(annual_date , trial_date)),0) AS Avg_days_to_upgrade
FROM trial tp
JOIN pro_annual ap
  USING(customer_id);