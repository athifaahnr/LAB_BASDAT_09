SET search_path TO classicmodels, public;

SELECT * FROM customers;

SELECT 
	productName AS "Nama Produk",
	buyPrice AS "Harga Beli",
	MSRP AS "Harga Jual",
	MSRP - buyPrice AS "Potensi Keuntungan"
FROM products
WHERE buyPrice > 50 AND MSRP - buyPrice > 30
ORDER BY MSRP - buyPrice DESC;