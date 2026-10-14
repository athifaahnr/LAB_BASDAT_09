SET search_path = classicmodels, public;


-- Nomor 1
SELECT
	ordernumber,
	UPPER(productCode) AS "Kode Produk",
	quantityOrdered,
	priceEach
FROM orderdetails
WHERE
	quantityOrdered BETWEEN 20 AND 50 AND LEFT(productCode, 3) = 'S18'
ORDER BY quantityOrdered DESC;

-- Nomor 2
SELECT
	customernumber,
	customername,
	country,
	CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
	creditlimit,
	creditlimit-10000 AS "Selisih Kredit"
FROM customers
WHERE creditlimit > 30000 AND country IN ('USA', 'France', 'Canada')
ORDER BY creditLimit DESC;
	
	
-- Nomor 3
SELECT
	productCode,
	productName,
	buyPrice,
	msrp,
	GREATEST(buyPrice, msrp) AS "Harga Tertinggi",
	LEAST(buyPrice, msrp) AS "Harga Terendah"
FROM products
WHERE productName ILIKE '%car%';

-- Nomor 4
SELECT
	orderNumber,
	orderDate,
	shippedDate,
	DATE_PART('year', orderDate) AS "Tahun",
	DATE_PART('month', orderDate) AS "Bulan",
	shippedDate-orderDate AS "Lama Pengiriman",
	AGE(shippedDate, orderDate) AS "Interval Pengiriman",
	CURRENT_DATE AS "Tanggal Laporan",
	CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

-- Nomor 5
SELECT
	orderNumber,
	orderDate,
	shippedDate,
	orderDate+INTERVAL '10 days' AS "Estimasi Kirim",
	COALESCE(shippedDate,(orderDate+INTERVAL '10 days')) AS "Tanggal Aktual",
	shippedDate-orderDate AS "Selisih Waktu"
FROM orders
WHERE
	comments ILIKE '%customer%'
	AND EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12
	AND orderNumber % 2 != 0
ORDER BY orderDate DESC;