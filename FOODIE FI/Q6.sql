-- Q6. What is the number and percentage of customer plans after their initial free trial?


WITH cte AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY start_date) AS rn 
  FROM 
    subscriptions
) 
Select p.plan_id,p.plan_name,count(p.plan_id) as NUMBER_OF_CUSTOMER,
round((count(p.plan_id)/(select count(plan_id) from cte where rn=2))*100.00,2) as PERCENTAGE
FROM plans p join cte c using(plan_id)
where rn=2
group by p.plan_id,p.plan_name
order by p.plan_id
