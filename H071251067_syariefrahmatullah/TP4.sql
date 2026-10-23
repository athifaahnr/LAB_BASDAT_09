set search_path to classicmodels;
-- nomor 1
SELECT
    customerNumber,
    SUM(amount) AS total_pembayaran,
    COUNT(*) AS frekuensi_transaksi,
    MAX(amount) AS pembayaran_terbesar,
    AVG(amount) AS rata_rata_pembayaran
FROM classicmodels.payments
GROUP BY customerNumber
HAVING COUNT(*) > 4
   AND AVG(amount) > 20000
ORDER BY customerNumber;

-- nomor 2

SELECT
    customerNumber,
    SUM(amount) AS total_setoran
FROM classicmodels.payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

-- nomor 3

SELECT
    p.productLine AS nama_kategori,
    COUNT(*) AS jumlah_produk,
    ROUND(AVG(p.MSRP), 2) AS rata_rata_harga_ritel,
    STRING_AGG(p.productName, ', ' ORDER BY p.productName) AS daftar_produk
FROM classicmodels.products p
GROUP BY p.productLine
HAVING COUNT(*) > 10
ORDER BY p.productLine;

-- nomor 4

SELECT DISTINCT reportsTo AS employeeNumber
FROM classicmodels.employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM classicmodels.employees
WHERE jobTitle ILIKE '%VP%'
   OR jobTitle ILIKE '%President%'
ORDER BY employeeNumber;

-- nomor 5
SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_jual
FROM classicmodels.orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

-- nomor 6

SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_dipesan,
    SUM(quantityOrdered * priceEach) AS total_pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_jual,
    MAX(priceEach) - MIN(priceEach) AS rentang_harga
FROM classicmodels.orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY total_pendapatan_kotor DESC;

-- nomor 7

SELECT customerNumber
FROM classicmodels.customers
WHERE creditLimit > 80000
INTERSECT
SELECT DISTINCT c.customerNumber
FROM classicmodels.customers c
JOIN classicmodels.orders o
    ON c.customerNumber = o.customerNumber
WHERE o.status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber
FROM classicmodels.payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000
ORDER BY customerNumber;

























