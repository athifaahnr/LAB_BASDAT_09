

-- ### 1. Ringkasan Riwayat Pembayaran Pelanggan

SELECT
    customerNumber,
    SUM(amount) AS total_setoran,
    COUNT(DISTINCT checkNumber) AS frekuensi_setoran,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4
   AND AVG(amount) > 20000;

-- ### 2. Pelanggan dengan Total Setoran Lebih dari $80.000


SELECT
    customerNumber,
    SUM(amount) AS total_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

-- ### 3. Ringkasan Produk Berdasarkan Kategori

SELECT
    productLine,
    COUNT(*) AS jumlah_produk,
    ROUND(AVG(MSRP), 2) AS rata_rata_harga,
    STRING_AGG(
        productName,
        ', ' ORDER BY productName
    ) AS daftar_produk
FROM products
GROUP BY productLine
HAVING COUNT(*) > 10;

-- ### 4. Daftar Atasan yang Bukan Eksekutif Puncak

SELECT reportsTo AS employeeNumber
FROM employees
WHERE reportsTo IS NOT NULL

EXCEPT

SELECT employeeNumber
FROM employees
WHERE jobTitle LIKE '%VP%'
   OR jobTitle LIKE '%President%';

-- ### 5. Evaluasi Penjualan Produk dengan Harga Satuan di Atas $100

SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

-- ### 6. Analisis Pendapatan Kotor dan Rentang Harga Produk

SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_dipesan,
    SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga,
    MAX(priceEach) - MIN(priceEach) AS rentang_harga
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;

-- ### 7. Pelanggan Bermodal Besar yang Memiliki Masalah Pesanan


    SELECT customerNumber
    FROM customers
    WHERE creditLimit > 80000

INTERSECT


    SELECT customerNumber
    FROM orders
    WHERE status IN ('Cancelled', 'On Hold')


EXCEPT


    SELECT customerNumber
    FROM payments
    GROUP BY customerNumber
    HAVING SUM(amount) > 100000

