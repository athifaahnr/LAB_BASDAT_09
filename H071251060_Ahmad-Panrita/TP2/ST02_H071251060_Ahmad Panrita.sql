set search_path to classicmodels;

select productname, buyprice, msrp, (msrp-buyprice) as potensiKeuntungan from products
where buyprice > 50 and (msrp-buyprice) > 30 order by (msrp-buyprice) desc;


select * from products;

