set search_path TO classicmodels;

-- soal 1
SELECT customerNumber AS "Nomor Pelanggan", 
		SUM(amount) AS "Total Akumulasi Dana Riil", 
		COUNT (*) AS "Frekuensi Transaksi",
		MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) > 4 AND ROUND(AVG(amount),2) > 20000;

-- soal 2
SELECT customerNumber AS "Nomor Pelanggan", SUM(amount) AS "Total Keseluruhan Dana"
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC;

-- soal 3
SELECT productLine AS "Nama Kategori Barang",
		COUNT (DISTINCT productCode) AS "Jumlah Ragam Produk",
		ROUND (AVG(msrp), 2) AS "Rata-rata",
		STRING_AGG (productName, ',' ORDER BY productName) AS "Daftar Nama Produk" 
FROM products
GROUP BY productLine
HAVING COUNT(DISTINCT productCode) > 10;

-- soal 4
SELECT DISTINCT reportsTo FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber FROM employees
WHERE jobTitle ILIKE '%VP%' OR jobTitle ILIKE '%President%';

SELECT * FROM 

-- SOAL 5
SELECT
    productCode AS "Kode Barang",
    SUM(quantityOrdered) AS "Total Unit Terjual",
    ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Riil"
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY SUM(quantityOrdered) DESC;

-- SOAL 6
SELECT productCode AS "Kode Barang",
    SUM(quantityOrdered) AS "Total Unit Dipesan",
    SUM(quantityOrdered * priceEach) AS "Pendapatan Kotor",
    ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Riil",
    MAX(priceEach) - MIN(priceEach) AS "Rentang Volatilitas Harga"
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY SUM(quantityOrdered * priceEach) DESC;

-- sOAL 7
SELECT customerNumber FROM customers
WHERE creditLimit > 80000
INTERSECT 
SELECT customerNumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')

EXCEPT

SELECT customerNumber FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;
