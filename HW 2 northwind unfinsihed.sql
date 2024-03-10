--Question 5
select * from products
select * from orderdetails
select * from orders

select distinct(products.productid), products.productname from products
left join orderdetails
on products.productid = orderdetails.productid
where unitsinstock + unitsonorder <= reorderlevel and discontinued = 0 

--Question 6
select * from orders

select shipcountry, avg(freight) as avg_freight from orders
where orderdate < '1997-01-01' and orderdate >= '1996-01-01'
group by shipcountry
order by avg_freight desc
limit 3

--Question 7
select * from orders
select lastname, firstname,  requireddate-shippeddate >5 as totalorders from orders
group by lastname


--Question 8
select * from orderdetails
select * from orders
Select * from customers

select orderdetails.orderid, customers.companyname, unitprice*quantity as totalorderamount from orderdetails
left join orders
on orderdetails.orderid = orders.orderid
join customers
on orders.customerid = customers.customerid
where unitprice*quantity >= 10000 and orderdate >= '1996-01-01' and orderdate < '1997-01-01'

--Question 9
select companyname from customers
left join orders
on orders.customerid = customers.customerid
where orderid is null

--Question 10
select distinct(companyname) from shippers
left join orders
on shippers.shipperid = orders.shipvia
where shipvia is not null


--Question 11
select * from shippers

select distinct(companyname) from shippers
left join orders
on shippers.shipperid = orders.shipvia
where shipvia is null

--Question 12
select * from employees
select * from employeeterritories
select * from territories

select lastname, firstname, territorydescription from employees
left join employeeterritories
on employees.employeeid = employeeterritories.employeeid
right join territories
on territories.territoryid = employeeterritories.territoryid
where employeeterritories.employeeid is null or employeeterritories.territoryid is null