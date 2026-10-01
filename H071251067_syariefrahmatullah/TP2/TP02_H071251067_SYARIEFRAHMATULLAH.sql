SET search_path TO classicmodels, public;
-- nomor 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
	('H07125','ronaldo','ronaldowati@gmail.com',2),
	('H07126','messi','messigacor@gmail.com',1),
	('H07127','neymar',NULL,2) 
RETURNING *;
SELECT * FROM mahasiswa;
DELETE FROM mahasiswa
WHERE ipk = 0;


-- nomor 2 
UPDATE mahasiswa
SET ipk = 3.50 WHERE ipk = 0.00;
SELECT * FROM mahasiswa;
UPDATE mahasiswa
SET ipk = 3.75 WHERE ipk = 3.50
RETURNING nim, ipk ;

DELETE FROM mahasiswa 
WHERE email IS NULL;


-- nomor 3
SELECT
    customerNumber AS "Nomor Pelanggan",
    customerName AS "Nama Pelanggan",
    phone AS "Telepon",
    country AS "Negara"
FROM customers;

-- nomor 4

SELECT
    productCode,
    productName,
    buyPrice
FROM products
WHERE buyPrice > 50 AND buyPrice < 100;
ORDER BY buyPrice DESC
LIMIT 7;

-- nomor 5

SELECT DISTINCT
    country AS "Negara Pelanggan"
FROM customers;
ORDER BY country ASC
OFFSET 5
LIMIT 5;

