set search_path to classicmodels, public;

--no 1
SELECT 
    customernumber AS "Nomor Pelanggan",
    SUM(amount) AS "Total Setoran",
    COUNT(DISTINCT checknumber) AS "Frekuensi Transaksi",
    MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;

--no 2
SELECT 
    customernumber,
    SUM(amount) AS "Total Setoran"
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY "Total Setoran" DESC;

-- no 3
SELECT
    productLine AS "Kategori Barang",
    COUNT(productline) AS "Jumlah Ragam Produk",
    ROUND(AVG(msrp), 2) AS "Rata-Rata MSRP",
    STRING_AGG(productname, ', ' ORDER BY productname ASC) AS "Daftar Produk"
FROM products
GROUP BY productline
HAVING COUNT(productline) > 10;

--no 4
SELECT DISTINCT reportsto AS "Nomor Karyawan"
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT employeenumber
FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

--no 5
SELECT 
    productcode,
    SUM(quantityordered) AS "Total Unit Terjual",
    ROUND(AVG(priceeach), 2) AS "Rata Rata Harga Riil"
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY "Total Unit Terjual" DESC;

--no 6
SELECT 
    productcode,
    SUM(quantityordered) AS "Total Unit Dipesan",
    SUM(quantityordered * priceeach) AS "Pendapatan Kotor",
    ROUND(AVG(priceeach), 2) AS "Rata-rata Harga Satuan",
    (MAX(priceeach) - MIN(priceeach)) AS "Volatilitas Harga"
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY "Pendapatan Kotor" DESC;

--no 7
SELECT customernumber 
FROM customers 
WHERE creditlimit > 80000

INTERSECT

SELECT customernumber 
FROM orders 
WHERE status = 'Cancelled' OR status = 'On Hold'

EXCEPT

SELECT customernumber 
FROM payments 
GROUP BY customernumber 
HAVING SUM(amount) > 100000;
