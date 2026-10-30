set search_path to classicmodels;

-- SOAL 1
SELECT p.productCode AS "Kode Produk", 
		p.productName AS "Nama Produk", 
		p.msrp AS "Harga Eceran",
		p.quantityinstock AS "Jumlah Stok",
CASE
	WHEN p.msrp < 50 AND p.quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
	WHEN p.msrp < 50 AND p.quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
	WHEN p.msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
	WHEN p.msrp > 100 THEN 'Harga Premium'
END AS "Kategori Produk"
FROM products p
ORDER BY p.msrp DESC;

-- SOAL 2
SELECT productCode AS "Kode Produk",
		SUM(quantityOrdered) AS "Total Unit Terjual",
		COUNT(orderNumber) AS "Jumlah Pesanan"
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityOrdered) >(
	SELECT AVG(quantityOrdered)
	FROM orderdetails
	)
	AND COUNT(DISTINCT ordernumber) > 10
ORDER BY "Total Unit Terjual" DESC;

-- SOAL 3
SELECT productcode AS "Kode Produk",
		productname AS "Nama Produk",
		quantityinStock AS "Jumlah Stok",
		msrp AS "Harga Eceran"
FROM products
WHERE quantityinstock > (
		SELECT AVG(quantityinstock)
		FROM products
)
AND msrp > (
	SELECT AVG(msrp)
	FROM products
)
ORDER BY quantityinstock DESC;

-- SOAL 4
BEGIN;

UPDATE orders
SET status = 'Shipped'
WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Cancelled'
WHERE orderNumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- SOAL 5 
CREATE TABLE anggota (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL, 
	kota_domisili VARCHAR(20) NOT NULL
);
CREATE TABLE buku (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR (100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INT,
		CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
	id_buku INT,
		CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INT DEFAULT 0	
);
CREATE INDEX pencarian_genre ON buku(genre);
CREATE INDEX kota_domisili ON anggota(kota_domisili);


