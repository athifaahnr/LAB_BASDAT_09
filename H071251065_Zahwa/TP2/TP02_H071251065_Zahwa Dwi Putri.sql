-- Soal 1

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 	('H071251065', 'Zahwa', 'zahwa@gmail.com', 1),
		('H071251000', 'Dwi', NULL, 1),
		('1234567890', 'Putri', 'putri@gmail.com', 1)
RETURNING *;

ALTER TABLE mahasiswa
DROP COLUMN tentang_saya;

-- SOAL 2

UPDATE mahasiswa
SET ipk = 3.50
WHERE ipk=0.00;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING*;

SELECT * FROM mahasiswa;


DELETE FROM mahasiswa
WHERE email is NULL
RETURNING email;

-- soal 3
SELECT 
		customerNumber AS "Nomor Pelanggan", 
		customerName AS "Nama Pelanggan",
		phone AS "Telepon",
		country AS "Negara" 
FROM customers;

-- soal 4

SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > 50 AND buyPrice < 100
ORDER BY buyPrice DESC
LIMIT 7;

-- soal 5

SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;