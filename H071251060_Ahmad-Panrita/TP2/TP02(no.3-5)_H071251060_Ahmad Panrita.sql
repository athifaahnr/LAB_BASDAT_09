set search_path to classicmodels, public;

select * from customers;

select customernumber as "Nomor Pelanggan", customername as "Nama Pelanggan", phone as "telepon", country as "Negara" from customers;

select productcode, productname, buyprice from products where buyprice > 50 & buyprice  order by buyprice desc;

select distinct country as "Negara Pelanggan" from customers order by country asc offset 5 limit 5;


