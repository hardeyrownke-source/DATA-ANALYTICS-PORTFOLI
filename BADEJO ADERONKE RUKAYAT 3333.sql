create table foodsales(orderdate date,
region varchar (50),
city varchar (100),
category varchar (100),
product varchar (100),
quantity int,
unitprice numeric (10,2),
totalprice numeric (12,2)
);
select *
from foodsales;

/*to calculate the total quantity sold per product*/
select product,sum(quantity) as total_quantity
from foodsales
group by product

/* calculate total revenue per product*/
select product,sum(totalprice) as total_revenue
from foodsales
group by product

/*calculate the average unit price per product*/
select product,avg(unitprice) as average_unit_price
from foodsales
group by product

/*count sales transaction per product*/
select product,count(*) as order_count
from foodsales
group by product

/*calculate the total revenue by product and category*/
select product,
category,sum(quantity) as total_quantity,
sum(totalprice) as total_revenue
from foodsales
group by product,category

/*calculate the average total revenue per product*/
select product,sum(totalprice) as total_revenue
from foodsales
group by product;
select avg(product_revenue) as avg_revenue
from (select product,sum(totalprice) as product_revenue
from foodsales
group by product) as product_totals;

/*identify products generating above-average revenue*/
select product,
sum(quantity) as total_quantity,
sum(totalprice) as total_revenue,
AVG(Unitprice) as avg_unit_price,
count(*) as order_count
from foodsales
group by product
having sum(totalprice)>(
select avg (product_revenue)
from(
select product,sum(totalprice) as product_revenue
from foodsales
group by product) as product_totals
)
order by 
total_revenue desc,
total_quantity desc;


/*PART B*/
1)SELECT 
EMPLOYEE_NAME
DEPARTMENT,
SALARY
FROM EMPLOYEE
WHERE SALARY > 200000
ORDER BY SALARY DESC

2) SELECT
SUM(REVENUE) AS TOTAL_REVENUE,
AVG(REVENUE) AS AVERAGE_REVENUE
MAX(REVENUE) AS HIGHEST_REVENUE,
MIN(REVENUE) AS LOWEST_REVENUE,
COUNT(*) AS Total_transaction
from sales

3)select
department,
count() as number_of_employees
from employees
group by department
having count()>10

4)select
employee_name,
salary,
case
when salary >=500000 then'High salary'
when salary >=200000 then'Medium salary'
ELSE 'Low salary'
end as salary_category
from employees

5)select
product_name
pricefrom products
where price>(select avg(price)
from products)

6)select
salesperson,
sum(revenue) as total_revenue
from sales
group by salesperson
having sum(revenue)>1000000

7)select
c.customer_id
c.customer_name
from customer c
where not exist (select 1 
from orders o
where o.customer_id = c.customer_id
);

8)with montyhly_revenue as (select date_trunc('month',sale_date)
)
select
sales_month
total_revenue
from monthly_revenue
where total_revenue<500000
order by sales_month

9)select
employee_name,
department,
salary,
rank() over (
partition by department order by salary desc) as salary_rank
from employees

10)with monthly_comarison as (select
period,
customers,
revenue,
lag(customer) over(order by month_number) as previous_customers,
lag(revenue) over(order by month_number) as previous_revenue
from monthly_sales)
select
period,
customers,
revenue,
previous_customers,
previous_revenue
from monthly_comparision
where customer>previous_customers
and revenue< previous_revenue


