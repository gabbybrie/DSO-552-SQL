--Question 1
select * from shippers
select shipperid from shippers
select distinct companyname from shippers
select distinct shipperid, companyname from shippers
order by shipperid asc 
--Question 2
select * from employees
select firstname, lastname, hiredate from employees 
where title = 'Sales Representative' or title = 'Inside Sales Coordinator' 
--Question 3
select firstname, lastname, country from employees
where country != 'USA'
order by lastname asc
--Question 4
select firstname, lastname, hiredate from employees
where hiredate < '1994-1-1'
order by hiredate desc -- Steven Buchanan
--Question 5
select * from orders
where shipcity = 'Madrid' and orderdate >= '1996-1-1' and orderdate < '1997-1-1'
--Question 6
select * from products
select productid, productname from products
where productname ilike '%queso%' and unitprice > 30
--Question 7
select * from orders
select orderid, customerid, shipcountry from orders
where shipcountry = 'Brazil' or shipcountry = 'Mexico' or shipcountry = 'Venezuela' or shipcountry = 'Argentina'
order by freight desc
limit 10
--Question 8
select * from customers
select companyname, contacttitle, city, country from customers
where country = 'Brazil' or country = 'Mexico' or country = 'Spain' and city != 'Madrid'
--Question 9
select * from products
where discontinued = 1 and unitsinstock > 0
order by unitprice desc
--Question 10
select * from orderdetails
alter table orderdetails add totalvalue int
select * from orderdetails
update orderdetails set totalvalue = unitprice*quantity*(1-discount)
select * from orderdetails
order by totalvalue desc
limit 1