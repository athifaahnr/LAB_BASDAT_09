SET search_path TO "classicmodels", public;

SELECT
	customerNumber,
	customerName,
	country,
	creditlimit
FROM customers
WHERE (country = 'USA' AND creditlimit BETWEEN 50000 AND 100000 OR country != 'USA' AND creditlimit BETWEEN 100000 AND 200000)
ORDER BY creditlimit DESC