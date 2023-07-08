select * from customer_orders;

update customer_orders
set exclusions =null
where exclusions='null' or exclusions='';

update customer_orders
set extras =null
where extras='null' or extras='';