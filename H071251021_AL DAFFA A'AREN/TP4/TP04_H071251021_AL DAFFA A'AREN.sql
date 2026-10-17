-- Nomor 1
SELECT customernumber AS nomor_identifikasi_pelanggan, SUM(amount) AS total_setoran, COUNT(checknumber) AS frekuensi_setoran, MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customernumber
HAVING COUNT(customernumber) > 4 AND AVG(amount) > 20000;

-- Nomor 2
SELECT customernumber AS nomor_identifikasi_pelanggan, SUM(amount) AS total_setoran
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran ASC;

-- Nomor 3
SELECT DISTINCT productline AS kategori,
	COUNT(productline) AS jumlah_ragam_produk,
	ROUND(AVG(msrp), 2) AS rata_rata,
	STRING_AGG(productname, ', ' ORDER BY productname) AS daftar_nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productline) > 10;

-- Nomor 4
SELECT DISTINCT reportsto AS nomor_identifikasi
FROM employees 
WHERE reportsto IS NOT NULL AND reportsto NOT IN (
	SELECT employeenumber 
	FROM employees
	WHERE jobtitle
	ILIKE '%VP%'
    OR jobtitle ILIKE '%President%'
	);

SELECT DISTINCT reportsto AS nomor_identifikasi
FROM employees 
WHERE reportsto IS NOT NULL

EXCEPT

SELECT employeenumber FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

-- Nomor 5
SELECT * FROM orderdetails;
SELECT productcode AS kode_identifikasi_barang, SUM(quantityordered) AS unit_terjual, ROUND(AVG(priceeach), 2) AS rata_rata
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY SUM(quantityordered) DESC;

-- Nomor 6
SELECT productcode, COUNT(quantityordered), SUM(quantityordered * priceeach) AS pendapatan_kotor, ROUND(AVG(priceeach), 2), (MAX(priceeach) - MIN(priceeach)) AS rentang
FROM orderdetails
WHERE quantityordered > 20 
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY rentang DESC;

-- Nomor 7
SELECT * FROM payments;

(SELECT customernumber FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber FROM orders
WHERE status IN ('Cancelled', 'On hold'))

EXCEPT

SELECT customernumber FROM payments
GROUP BY customernumber
HAVING SUM(amount) >= 100000;