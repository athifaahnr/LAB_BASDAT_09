-- LIVECODING
SELECT productcode, COUNT(quantityordered), SUM(quantityordered * priceeach) AS pendapatan_kotor, ROUND(AVG(priceeach), 2), (MAX(priceeach) - MIN(priceeach)) AS rentang
FROM orderdetails
WHERE quantityordered > 20 
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY rentang DESC;

-- STUDY CASE
SELECT * FROM orderdetails;

SELECT productcode AS kode_produk, COUNT(ordernumber) AS jumlah_transaksi, SUM(quantityordered) AS total_unit_terjual, SUM(priceeach * quantityordered) AS total_pendapatan, AVG(priceeach) AS rata_rata
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > 500
ORDER BY total_pendapatan DESC;
