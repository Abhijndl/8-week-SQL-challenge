-- Q7 What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31


WITH cte AS (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY start_date desc) AS rn 
  FROM 
    subscriptions
    where start_date <= '2020-12-31'
) 
Select p.plan_name,count(p.plan_id) as NUMBER_OF_CUSTOMER,
round((count(p.plan_id)/(select count(plan_id) from cte where rn=1))*100.00,1) as PERCENTAGE
FROM plans p join cte c using(plan_id)
where rn=1
group by p.plan_id,p.plan_name
order by NUMBER_OF_CUSTOMER desc;