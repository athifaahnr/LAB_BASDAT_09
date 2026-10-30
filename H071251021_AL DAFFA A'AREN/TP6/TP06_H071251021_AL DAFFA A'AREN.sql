-- TP 06

-- Nomor 1
SELECT productCode, 
       productName, 
       MSRP, 
       quantityInStock,
       CASE
           WHEN MSRP < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
           WHEN MSRP < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
           WHEN MSRP BETWEEN 50 AND 100 THEN 'Harga Menengah'
           WHEN MSRP > 100 THEN 'Harga Premium'
       END AS kategori
FROM products
ORDER BY MSRP DESC;

-- Nomor 2
SELECT productCode,
       SUM(quantityOrdered) AS total_unit_terjual,
       COUNT(DISTINCT orderNumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (
	SELECT AVG(quantityOrdered)       
	FROM orderdetails
	)
   AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- Nomor 3
SELECT productCode, productName, quantityInStock, MSRP
FROM products
WHERE quantityInStock > (SELECT AVG(quantityInStock) FROM products)
  AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;

-- Nomor 4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE orderNumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- Nomor 5
CREATE TABLE anggota (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER,
    id_buku INTEGER,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0,
    FOREIGN KEY (id_anggota) REFERENCES anggota(id),
    FOREIGN KEY (id_buku) REFERENCES buku(id)
);

CREATE INDEX idx_buku_genre ON buku(genre);
CREATE INDEX idx_anggota_kota ON anggota(kota_domisili);

-- SC 06
SELECT productcode, productname, productline, buyprice
FROM products
WHERE productline = 'Classic Cars' AND buyprice > ALL (
	SELECT buyprice
	FROM products
	WHERE productline = 'Vintage Cars'
)
ORDER BY buyprice DESC;
