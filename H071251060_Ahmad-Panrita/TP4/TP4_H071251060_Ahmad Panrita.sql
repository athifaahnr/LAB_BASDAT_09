set search_path to classicmodels;

select * from payments;
-- 1

select customernumber, sum(amount) as jumlah_transaksi, count(checknumber), max(amount) from payments
group by customernumber
having count(checknumber) > 4 and avg(amount) > 20000

-- 2
select customernumber, sum(amount) as total_setoran
from payments 
group by customernumber
having sum(amount) > 80000
order by total_setoran desc


-- 3
select * from products;

select productline as kategori, count(productvendor) as ragam_produk, round(avg(buyprice), 2) as rerata, string_agg(productname, ' - ') as semua_produl
from products
group by productline
having count(productvendor) > 10

-- 4


select * from employees;

select distinct(reportsto) from employees 
where reportsto is not null
except
select employeenumber from employees
where jobtitle ilike '%VP%' or jobtitle ilike '%President%'

-- 5

select productcode, sum(quantityordered) as total, round(avg(priceeach), 2)
from orderdetails 
where priceeach > 100
group by productcode
having sum(quantityordered) > 50
order by total desc


-- 6

select productcode, sum(quantityordered) as total_pesan, sum(priceeach*quantityordered) as pendapatan_kotor, round(avg(priceeach), 2), ((max(priceeach)) - (min(priceeach))) as volatilitas
from orderdetails
where quantityordered > 20
group by productcode
having sum(quantityordered* priceeach) > 50000
order by pendapatan_kotor desc;

-- 7
select * from customers

select customernumber 
from customers
where creditlimit > 80000
intersect 
select customernumber
from orders 
where status = 'Cancelled' or status = 'On Hold'
except
select customernumber
from payments
group by customernumber
having sum(amount) > 100

