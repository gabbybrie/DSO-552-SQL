--Question 7
select * from orders

select employees.firstname, count(employees.lastname) as totallateorders from employees
join orders
on employees.employeeid = orders.employeeid
where requireddate <= shippeddate 
group by employees.firstname
having count(employees.lastname) >= 5