SET search_path = classicmodels, public;

--Soal 1
SELECT 
    customernumber,
    SUM(amount) AS total_akumulasi_dana,
    COUNT(DISTINCT checknumber) AS frekuensi_transaksi,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customernumber
HAVING 
    COUNT(DISTINCT checknumber) > 4 
    AND AVG(amount) > 20000;
	
--Soal 2
SELECT 
    customernumber,
    SUM(amount) AS total_akumulasi_setoran
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_akumulasi_setoran DESC;

--Soal 3
SELECT 
    productLine,
    COUNT(productCode) AS jumlah_ragam_produk,
    ROUND(AVG(MSRP), 2) AS rata_rata_harga_ritel,
    STRING_AGG(productName, ', ' ORDER BY productName) AS daftar_nama_produk
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;

-- Soal 4
SELECT DISTINCT reportsto AS employeenumber
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT employeenumber
FROM employees
WHERE jobtitle ILIKE '%VP%' OR jobtitle ILIKE '%President%'; 

--Soal 5
SELECT 
    productcode,
    SUM(quantityordered) AS total_unit_terjual,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga_penjualan
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_unit_terjual DESC;

--Soal 6
SELECT 
    productcode,
    SUM(quantityordered) AS total_unit_dipesan,
    SUM(quantityordered * priceeach) AS estimasi_pendapatan_kotor,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga_satuan,
    (MAX(priceeach) - MIN(priceeach)) AS rentang_volatilitas_harga
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY estimasi_pendapatan_kotor DESC;

--Soal 7
SELECT customernumber 
FROM customers 
WHERE creditlimit > 80000
    
INTERSECT
    
SELECT DISTINCT customernumber 
FROM orders 
WHERE status IN ('Cancelled', 'On Hold')

EXCEPT

SELECT customernumber 
FROM payments 
GROUP BY customernumber 
HAVING SUM(amount) > 100000;