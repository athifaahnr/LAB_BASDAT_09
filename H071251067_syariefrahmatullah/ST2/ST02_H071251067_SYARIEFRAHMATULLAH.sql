set search_path to classicmodels;


SELECT
	status AS "status pesanan",
 	orderdate AS "Tanggal pesanan" 
FROM orders
WHERE status in ('In Process','On Hold')
     AND orderdate > '2003-01-01'
ORDER BY orderdate ASC
LIMIT 10;



