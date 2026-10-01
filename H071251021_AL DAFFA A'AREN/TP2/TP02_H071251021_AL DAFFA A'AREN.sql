INSERT INTO prodi (nama_prodi) VALUES ('Sistem Informasi'), ('Matematika');

-- Nomor 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi) 
VALUES
('H071251021', 'Pong Mentong', 'apaya@gmail.com', 1),
('H071251022', 'Syahda', 'syahda@gmail.com', 1),
('H071251045', 'Kasman', NULL, 2)
returning *;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

-- Nomor 2
DELETE FROM mahasiswa
WHERE email IS NULL
returning *;

-- Nomor 3
SELECT customernumber AS "Nomor Pelanggan",
customername AS "Nama Pelanggan",
phone AS "Telepon", country AS "Negara"
FROM classicmodels.customers;

-- Nomor 4
SELECT productcode, productname,buyprice FROM classicmodels.products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- Nomor 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM classicmodels.customers ORDER BY country ASC LIMIT 5 OFFSET 5;