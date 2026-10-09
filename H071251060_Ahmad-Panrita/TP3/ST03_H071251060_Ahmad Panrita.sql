set search_path to classicmodels

select * from orders;

select ordernumber as "Nomor Pesanan", orderdate as "Tanggal Pesanan", status as "Status Pesanan", customernumber as "Nomor Pelanggan" from orders
where (status in ('Shipped','Cancelled')) and (extract(year from orderdate) >= 2004) and ((extract(month from orderdate) >= 1) and (extract(day from orderdate) > 1))
order by orderdate asc;