set search_path to classicmodels;

select ordernumber, upper(productcode) as "Kode Produk", quantityordered, priceeach from orderdetails
where (quantityordered between 20 and 50 or priceeach < 30) and (left(productcode, 3) like 'S18%') order by quantityordered desc;

select customernumber, customername, country, concat(contactfirstname,' ',contactlastname) as "Nama Kontak", creditlimit, (creditlimit - 10000) as "Selisih Kredit" from customers
where (country ilike 'usa' or country ilike 'france' or country ilike 'canada') and creditlimit > 30000 order by creditlimit desc;
select * from products;

select productcode, productname, buyprice, msrp, greatest(buyprice, msrp) as "Harga Tertinggi", least(buyprice, msrp) as "Harga Terendah" from products
where productname ilike '%car%'

select ordernumber, orderdate, shippeddate, extract(year from orderdate) as "Tahun", extract(month from orderdate) as "Bulan",
age(shippeddate, orderdate) as "Selisih Hari", (shippeddate - orderdate) as "Interval Hari", current_date as "Tanggal laporan", current_time as "Waktu Laporan" from orders
where shippeddate is not null;

select ordernumber, orderdate, shippeddate, (orderdate + interval '10 days') as "Estimasi Kirim", coalesce(shippeddate, (orderdate + interval '10 days')) as "Tanggal Aktual",
age(shippeddate, orderdate) as "Selisih Waktu" from orders
where (comments ilike '%customer%') and (extract(month from orderdate) between 10 and 12) and (ordernumber % 2 = 1) order by orderdate desc;