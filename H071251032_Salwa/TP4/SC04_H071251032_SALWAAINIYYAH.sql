SELECT * FROM customers

SELECT 
	customers.country AS nama_negara,
	COUNT(*) AS jumlah_pelanggan
FROM customers
GROUP BY country
HAVING COUNT(country) >= 5
ORDER BY jumlah_pelanggan DESC