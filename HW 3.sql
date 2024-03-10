--Question 1
select * from products
select productname, unitprice from products 
--avg unitprice
select avg(unitprice) as avg_unitprice from products
-- avg unitsinstock
select avg(unitsinstock) as avg_unitsinstock from products
--putting it together
select productid, productname from products
group by productid
having unitprice >(select avg(unitprice) as avg_unitprice from products) 
and unitsinstock < (select avg(unitsinstock) as avg_unitsinstock from products)
order by productname asc

--Question 2
select * from employees
select * from orders
-- total number of orders for each employee
select employees.employeeid, lastname, firstname, count(orderid) as total_orders from employees
join orders
on employees.employeeid = orders.employeeid
group by employees.employeeid
--putting it together
select sum(total_orders)/count(employeeid) as avg_orders_per_employee from 
(select employees.employeeid, lastname, firstname, count(orderid) as total_orders from employees
join orders
on employees.employeeid = orders.employeeid
group by employees.employeeid)

--Question 3
select * from orderdetails
select * from products
--avg total discount per categoryid
select categoryid, avg(quantity*discount*orderdetails.unitprice) as total_discount from orderdetails
join products
on products.productid = orderdetails.productid
group by categoryid
--avg total discount across all categories
select avg(quantity*discount*orderdetails.unitprice) as across_total from orderdetails
--putting it together
with avg_category_discount as
(select categoryid, avg(quantity*discount*orderdetails.unitprice) as total_discount from orderdetails
join products
on products.productid = orderdetails.productid
group by categoryid)

select categoryname, total_discount from avg_category_discount
join categories
on categories.categoryid = avg_category_discount.categoryid
group by categoryname, total_discount
having total_discount > (select avg(quantity*discount*orderdetails.unitprice) as across_total from orderdetails)
--Question 4
select * from customers
select * from orders
--
select companyname, contactname, count(orderid) as num_orders from customers
join orders 
on customers.customerid = orders.customerid
group by companyname, contactname
order by num_orders desc
limit 5

--Question 5
select customers.companyname, customers.contactname,
(select count(*)
from orders 
where orders.customerid = customers.customerid) AS num_orders
from customers 
order by num_orders desc
limit 5

-- Question 6
select * from customers
select * from orders
-- number of countries where customers didn't order
select customers.customerid, companyname, country, count(orderid) as num_orders from customers
left join orders
on customers.customerid=orders.customerid
group by customers.customerid, companyname, country
having count(orderid) = 0
--how many companies in each country
select country, count(companyname) as num_cust from customers
group by country
-- putting it together
with cust_count as 
(select customers.customerid, companyname, country, count(orderid) as num_orders from customers
left join orders
on customers.customerid=orders.customerid
group by customers.customerid, companyname, country
having count(orderid) = 0)

select country, count(companyname) as cust_no_order from cust_count
group by country

--Question 7
select * from customers
select * from orders

--avg number of orders across customers
with company_orders as 
(select companyname, count(orderid) as num_orders from customers
join orders 
on customers.customerid = orders.customerid
group by companyname)

select avg(num_orders) from company_orders
-- putting it all together
with company_orders as 
(select companyname, count(orderid) as num_orders from customers
join orders 
on customers.customerid = orders.customerid
group by companyname)

select customers.customerid, count(orderid) as num_orders from customers
join orders
on customers.customerid = orders.customerid
group by customers.customerid
having count(orderid) > (select avg(num_orders) from company_orders)
order by num_orders desc
limit 5

--Question 8
select * from products
select * from orderdetails

-- top 5 best selling products
with top_products as
(select productid, sum(unitprice * quantity) as total_order_value from orderdetails
group by productid
order by total_order_value desc
limit 5)

--putting it all together: units in stock for top 5 products
with top_products as
(select productid, sum(unitprice * quantity) as total_order_value from orderdetails
group by productid
order by total_order_value desc
limit 5)

select products.productid, productname, unitsinstock from products
right join top_products
on top_products.productid = products.productid

--putting it all together: avg units in stock for top 5 products
with top_products as
(select productid, sum(unitprice * quantity) as total_order_value from orderdetails
group by productid
order by total_order_value desc
limit 5)

select avg(unitsinstock) from products
right join top_products
on top_products.productid = products.productid

--Question 9
select * from orderdetails
select * from orders
-- employees with total value > 10000
with top_employees as 
(select employeeid, sum(unitprice * quantity) as total_value from orderdetails
join orders
on orders.orderid = orderdetails.orderid
group by employeeid
having sum(unitprice * quantity) > 100000)

--putting it all together
with top_employees as 
(select employeeid, sum(unitprice * quantity) as total_value from orderdetails
join orders
on orders.orderid = orderdetails.orderid
group by employeeid
having sum(unitprice * quantity) > 100000)

select orderid, customerid, freight, orderdate from orders
right join top_employees
on top_employees.employeeid = orders.employeeid
order by orderdate desc
limit 10

--Question 10
select * from orders

--
select * from orders
where freight > 200
--
with heavy_employee as
(select employeeid, count(orderid) as heavy_orders from orders
where freight > 200
group by employeeid)

--avg number heavy orders
with heavy_employee as
(select employeeid, count(orderid) as heavy_orders from orders
where freight > 200
group by employeeid)

select avg(heavy_orders) from heavy_employee

--
select * from employees
--putting it all together
with heavy_employee as
(select employeeid, count(orderid) as heavy_orders from orders
where freight > 200
group by employeeid)

select lastname, firstname, heavy_orders from employees
join heavy_employee
on heavy_employee.employeeid = employees.employeeid
where heavy_orders > (select avg(heavy_orders) from heavy_employee)
order by heavy_orders desc, lastname asc, firstname asc

--Question 11
select * from orders
select * from employees
--
select lastname, firstname, count(orderid) as orders_processed,
case
when count(orderid) > 75 then 'High Performer'
when count(orderid) > 50 and count(orderid) < 74 then 'Mid Tier'
when count(orderid) < 50 then 'Low Performer' 
end as grade
from employees
join orders
on orders.employeeid = employees.employeeid
group by lastname, firstname
