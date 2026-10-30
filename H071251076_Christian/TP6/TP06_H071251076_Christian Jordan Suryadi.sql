SET search_path TO classicmodels, public;

--soal 1
SELECT productcode, productname, msrp, quantityinstock,
	CASE
		WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		WHEN msrp > 100 THEN 'Harga Premium'
	END AS kategoriProduk
FROM products;

--soal 2
SELECT productCode, total_unit_terjual, jumlah_pesanan
FROM (
    SELECT productCode,
           SUM(quantityOrdered) AS total_unit_terjual,
           COUNT(DISTINCT orderNumber) AS jumlah_pesanan
    FROM orderdetails
    GROUP BY productCode
) AS penjualan_produk
WHERE total_unit_terjual > (SELECT AVG(quantityOrdered) FROM orderdetails)
  AND jumlah_pesanan > 10
ORDER BY total_unit_terjual DESC;

--soal 3
SELECT productCode, productName, quantityInStock, MSRP
FROM products
WHERE quantityInStock > (SELECT AVG(quantityInStock) FROM products)
  AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;

--soal 4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

--soal 5
CREATE DATABASE db_perpus;
SET search_path TO db_perpus, public;

CREATE TABLE anggota (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INT,
    id_buku INT,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0,

    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id),
    CONSTRAINT fk_peminjaman_buku FOREIGN KEY (id_buku) REFERENCES buku(id)
);

CREATE INDEX index_buku_genre
ON buku(genre);

CREATE INDEX index_anggota_kota_domisili
ON anggota(kota_domisili);


SELECT * from peminjaman;

--SC
SET search_path TO classicmodels, public;
BEGIN;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE customers
SET creditLimit = 10000
WHERE customernumber = '103';

SAVEPOINT sp_update_kredit;

UPDATE customers
SET city = 'Surabaya'
WHERE customernumber = '103';

ROLLBACK TO SAVEPOINT sp_update_kredit;

COMMIT;
SELECT * from customers WHERE customernumber = '103';
