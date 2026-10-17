SET search_path = classicmodels, public;

--studycase no1
SELECT
	productcode,
	COUNT(*) AS jumlah_transaksi,
	SUM(quantityordered) AS total_unit_terjual,
	SUM(quantityordered * priceeach) AS total_pendapatan,
	AVG(priceeach) AS rata_rata_harga_jual
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > 500
ORDER BY SUM(quantityordered * priceeach) DESC;

--NO3
SELECT
	country,
	COUNT(customernumber) AS jumlah_pelanggan
FROM customers
GROUP BY country
HAVING COUNT(customernumber) >= 5
ORDER BY COUNT(customernumber) DESC;