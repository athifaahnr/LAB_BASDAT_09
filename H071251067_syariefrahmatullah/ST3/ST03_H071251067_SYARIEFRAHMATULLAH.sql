-- 1
SELECT 
	ordernumber, 
	orderdate,
	status,
	customernumber
FROM orders
WHERE 
	ordernumber > 10250 AND
	status NOT IN ('shipped' , 'Cancalled') 
	AND orderdate
	BETWEEN '2004-01-01' AND '2005-12-31';
-- 2

SELECT
	customernumber,
	customername,
	country
FROM customers
WHERE(country= 'USA' AND creditlimit > 50000 AND creditlimit < 10000)
	OR (country != 'USA' AND creditlimit BETWEEN 100000 AND 200000)
ORDER BY creditlimit DESC;

-- 3
SELECT
	productcode,
	productname,
	MSRP,
	productline
FROM products
WHERE 
	productline ILIKE '%Classic%' AND buyprice > 50;
	
	
	
	
