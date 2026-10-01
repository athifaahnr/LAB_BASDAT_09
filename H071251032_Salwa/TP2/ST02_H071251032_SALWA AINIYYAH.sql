SET search_path TO "classicmodels", public;

SELECT
	ordernumber,
	orderdate AS "Tanggal Pesanan",
	status 
FROM orders
WHERE status = 'In Process' OR status = 'On Hold'  AND orderdate > '2003-01-01'
ORDER BY orderdate ASC 
LIMIT 10;


