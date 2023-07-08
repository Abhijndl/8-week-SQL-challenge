-- Q8 How many customers have upgraded to an annual plan in 2020?

SELECT p.plan_name,count(s.customer_id) as c 
from plans p join subscriptions s using(plan_id)
where year(s.start_date)=2020 and p.plan_id=3
group by p.plan_name
