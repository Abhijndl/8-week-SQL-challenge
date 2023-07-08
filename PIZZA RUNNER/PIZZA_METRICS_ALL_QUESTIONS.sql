USE PIZZA_RUNNER;
-- Q1.How many pizzas were ordered?

SELECT count(order_id) as TOTAL_PIZZA_ORDERED from customer_orders;

-- Q2. How many unique customer orders were made?

SELECT count(distinct order_id) AS UNIQUE_CUSTOMER_ORDER
 from customer_orders;
 
 -- Q3. How many successful orders were delivered by each runner?
 
 SELECT runner_id ,count(order_id) as NO_OF_DELIVERY
 FROM runner_orders
 where distance is not null
 group by runner_id;
  
-- Q4. How many of each type of pizza was delivered?

SELECT p.pizza_name ,count(c.pizza_id) as NO_OF_PIZZA from customer_orders c inner join pizza_names p using(pizza_id) inner join runner_orders ro using (order_id)
where ro.distance is not null
group by p.pizza_name;

-- Q5 . How many Vegetarian and Meatlovers were ordered by each customer?

SELECT c.customer_id,p.pizza_name ,count(c.pizza_id) as NO_OF_PIZZA from customer_orders c inner join pizza_names p using(pizza_id)
group by c.customer_id,p.pizza_name
order by c.customer_id;

-- Q6 .What was the maximum number of pizzas delivered in a single order?
with max_pizza as(
SELECT order_id,count(pizza_id) as NO_OF_PIZZA from customer_orders  group by order_id)
select max(NO_OF_PIZZA) as MAX_PIZZA_PER_ORDER from max_pizza;


-- Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT c.customer_id as CUSTOMER_ID,
sum(case when c.exclusions is not null or c.extras is not null then 1 else 0 end) as ATLEAT_1_CHANGES,
sum(case when c.exclusions is  null and c.extras is  null then 1 else 0 end) as NO_CHANGES
FROM customer_orders c join runner_orders r using(order_id)
where distance is not null
group by c.customer_id
order by c.customer_id;

-- Q8.How many pizzas were delivered that had both exclusions and extras?

SELECT 
sum(case when c.exclusions is not null and c.extras is not null then 1 else 0 end) as BOTH_CHANGES
FROM customer_orders c join runner_orders r using(order_id)
where distance is not null;

-- Q9.What was the total volume of pizzas ordered for each hour of the day?

SELECT hour(order_time) as HOUR_OF_DAY,count(order_id) as ORDER_PLACED_COUNT
FROM customer_orders
group by hour(order_time)
order by HOUR_OF_DAY;

-- Q10 .What was the volume of orders for each day of the week?

SELECT dayname(order_time) as DAY,count(order_id) as ORDER_COUNT
from customer_orders
group by DAY;




