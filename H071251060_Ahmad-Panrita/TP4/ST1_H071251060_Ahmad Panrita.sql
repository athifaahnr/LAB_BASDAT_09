set search_path to classicmodels

select * from payments;

select customernumber
from customers
where creditlimit > 80000
intersect
select customernumber
from orders
where status ='Cancelled' or status ='On Hold'
except
select customernumber
from payments
group by customernumber
having sum(amount) > 100000


select * from orderdetails;
select * from products

select ordernumber, count(distinct(productcode)),  string_agg(productcode, ', ')
from orderdetails
group by ordernumber
having count(distinct(productcode)) >= 3
order by ordernumber asc
	



















