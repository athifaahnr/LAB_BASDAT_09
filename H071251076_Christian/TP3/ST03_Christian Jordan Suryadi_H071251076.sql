SET search_path = classicmodels, public;

SELECT
	customerNumber,
	customerName,
	country
FROM customers
WHERE
	creditlimit BETWEEN 50000 AND 100000 AND country = 'USA'
	OR creditlimit BETWEEN 100000 AND 200000 AND country != 'USA'
ORDER BY creditlimit DESC;