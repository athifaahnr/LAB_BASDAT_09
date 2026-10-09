SELECT customerNumber AS "Nomor Pelanggan", customerName AS "Nama Pelanggan", phone AS "Telepon", country AS "Negara" FROM customers;

SELECT productCode, productName, buyPrice FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
OFFSET 5
LIMIT 5;

