-- Q1 If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
with c as(
 SELECT * from runner_orders where cancellation is  null)
 ,c1 as (
 select distinct *,if(pizza_id=1,12,10) as pizza_cost
 from c join customer_orders co using(order_id)
 )
 select runner_id,concat('$ ',sum(pizza_cost)) as TOTALCOST
 from c1 group by runner_id;
 
 -- Q2 The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, 
 -- how would you design an additional table for this new dataset - generate a schema for this new table and insert 
 -- your own data for ratings for each successful customer order between 1 to 5.
 
 CREATE view ranking_table as(
 select *,if(cancellation is null,floor(1+rand()*5),null) as ratings from runner_orders);

 select * from ranking_table;
 
 
 -- Q3.If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled 
 -- how much money does Pizza Runner have left over after these deliveries?
 
 
 
 with c as(
 SELECT distinct c.order_id, r.runner_id, c.pizza_id, r.distance,(0.30*r.distance) as runner_cost,if(c.pizza_id=1,12,10) as pizza_cost from customer_orders c
join runner_orders r using (order_id) where r.cancellation is null)
 select runner_id ,concat('$ ',round(sum(pizza_cost)-sum(runner_cost),2)) as LEFT_OVER_MONEY  from c group by runner_id;
 

 
 
 
 
 