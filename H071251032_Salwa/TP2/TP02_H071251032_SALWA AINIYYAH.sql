CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3,2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);

SELECT * FROM MAHASISWA;
SELECT * FROM prodi;

insert into prodi (nama_prodi) values ('Sistem Informasi');

-- NOMOR 1 --------------------------------------------------------------------------


INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
('H071251020', 'Wawa', 'kutanganda@gmail.com', 1),
('H071251022', 'Yufan', NULL, 1),
('H071251028', 'Martin', 'gentong@gmail.com', 1)
returning *;



-- NOMOR 2 ---------------------------------------------------------------------------

INSERT INTO mahasiswa (nim, nama, ipk, email, id_prodi) 
VALUES 
	('H071251109', 'chao Yufan', 3.50, 'yuhalal@gmail.com', 1),
	('H071251110', 'Martin Edward', 3.50, 'kimstella@gmail.com', 1),
	('H071251111', 'Kim Juhoon', 3.50, 'kimjuun@gmail.com', 1),
	('H071251112', 'Keonho', 3.50, 'einaa@gmail.com', 1),
	('H071251113', 'Seonghyong', 3.50, 'iansopian@gmail.com', 1)
RETURNING *;

update mahasiswa
set ipk = 3.50
where ipk = 0.00;

delete from mahasiswa
where email is null
returning *;

DELETE FROM MAHASISWA;

---------------------------------------------------------------------------------------

SET search_path TO "classicmodels", public;

--- NOMOR 3 ---------------------------------------------------------------------------

SELECT
	customernumber AS "Nomor Pelanggan",
	customername AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM customers;

--- NOMOR 4 ---------------------------------------------------------------------------

SELECT
	productcode,
	productname,
	buyprice
FROM products
WHERE buyprice >= 50
ORDER BY buyprice DESC
LIMIT 7;

--- NOMOR 5 ---------------------------------------------------------------------------

SELECT 	DISTINCT
	country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;



