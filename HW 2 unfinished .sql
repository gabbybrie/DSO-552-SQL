--Question 1
select * from entertainers
select entstagename, entphonenumber, entcity from entertainers
where (entcity = 'Bellevue' or entcity = 'Redmond' or entcity = 'Woodinville')
and entemailaddress is null 

--Question 2
select * from engagements
select engagementnumber, startdate, enddate from engagements
where (enddate - startdate = 3)
and startdate > '2017-08-31' and startdate <= '2017-09-30'

--Question 3
select * from entertainers
select * from customers
select * from engagements

select distinct(entstagename) from entertainers
join engagements
on entertainers.entertainerid=engagements.entertainerid
join customers
on engagements.customerid=customers.customerid
where custlastname='Berg' or custlastname='Hallmark'
order by entstagename 

--Question 4
select * from entertainers
select * from engagements

select distinct(entertainers.entertainerid), entstagename from entertainers
left join engagements
on entertainers.entertainerid=engagements.entertainerid
where entwebpage is null or entemailaddress is null or engagementnumber is null
order by entertainers.entertainerid 

--Question 5

