select * from runner_orders;

update runner_orders
set cancellation=null
where cancellation='' or cancellation='null';

update runner_orders
set pickup_time=null
where pickup_time='null';

update runner_orders
set distance=null
where distance='null';

update runner_orders
set distance=case when distance like '%km%' then TRIM('km' from distance) else distance end;

update runner_orders
set duration=case when duration like '%minutes' then TRIM('minutes' from duration) 
					when duration like '%mins' then TRIM('mins' from duration) 
                    when duration like '%minute' then TRIM('minute' from duration)
                    else duration end;