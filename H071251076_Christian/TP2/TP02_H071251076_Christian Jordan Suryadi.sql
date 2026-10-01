-- praktikum_db
SELECT * FROM mahasiswa;
-- no 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
    ('H07125100', 'Amiya', 'amiya@gmail.com', 1),
    ('H07125200', 'Beatrice Mellanine', NULL, 1),
    ('H07125300', 'Caelus', 'caelus@gmail.com', 1)
RETURNING *;

UPDATE mahasiswa
SET ipk = 3.50
WHERE ipk = 0
RETURNING *;
-- no 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING *;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *;

DELETE FROM mahasiswa
WHERE ipk = 3.75
RETURNING *;

-- classicmodels
SELECT customername FROM customers;
SET search_path TO classicmodels, public;

SELECT customernumber, customername, phone, country FROM customers;

SELECT * FROM customers;
-- no 3
SELECT 
    customerNumber AS "Nomor Pelanggan",
    customerName AS "Nama Pelanggan",
    phone AS "Telepon",
    country AS "Negara"
FROM customers;
-- no 4
SELECT productCode, productName, buyPrice j
FROM products 
WHERE buyPrice > 50 
ORDER BY 
    buyPrice DESC 
LIMIT 7;
-- no 5
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers;
ORDER BY country ASC
LIMIT 5 OFFSET 5;

