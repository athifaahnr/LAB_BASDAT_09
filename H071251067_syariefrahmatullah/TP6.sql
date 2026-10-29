set search_path to classicmodels;
-- nomor 1
SELECT
    productCode AS kode_produk,
    productName AS nama_produk,
    MSRP AS harga_jual,
    quantityInStock AS jumlah_stok,
    CASE
        WHEN MSRP < 50 AND quantityInStock > 500
            THEN 'Ekonomis - Stok Tinggi'
        WHEN MSRP < 50 AND quantityInStock <= 500
            THEN 'Ekonomis - Stok Rendah'
        WHEN MSRP BETWEEN 50 AND 100
            THEN 'Harga Menengah'
        WHEN MSRP > 100
            THEN 'Harga Premium'
    END AS kategori
FROM classicmodels.products
ORDER BY MSRP DESC;

-- nomor 2
SELECT
    productCode AS kode_produk,
    SUM(quantityOrdered) AS total_unit_terjual,
    COUNT(DISTINCT orderNumber) AS jumlah_pesanan_berbeda
FROM classicmodels.orderdetails
GROUP BY productCode
HAVING
    SUM(quantityOrdered) > (
        SELECT AVG(quantityOrdered)
        FROM classicmodels.orderdetails
    )
    AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- nomor 3
SELECT
    productCode AS kode_produk,
    productName AS nama_produk,
    quantityInStock AS jumlah_stok,
    MSRP AS harga_jual
FROM classicmodels.products
WHERE
    quantityInStock > (
        SELECT AVG(quantityInStock)
        FROM classicmodels.products
    )
    AND MSRP > (
        SELECT AVG(MSRP)
        FROM classicmodels.products
    )
ORDER BY quantityInStock DESC;

-- nomor 4
BEGIN;
UPDATE classicmodels.orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;
SAVEPOINT status_pengiriman;
UPDATE classicmodels.orders
SET status = 'Batal'
WHERE orderNumber = 10100;
ROLLBACK TO SAVEPOINT status_pengiriman;
COMMIT;

-- nomor 5

-- 1. Membuat tabel anggota
CREATE TABLE anggota (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

-- 2. Membuat tabel buku
CREATE TABLE buku (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

-- 3. Membuat tabel peminjaman
CREATE TABLE peminjaman (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER REFERENCES anggota(id),
    id_buku INTEGER REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0
);

-- 4. Membuat index pada kolom genre tabel buku
CREATE INDEX idx_buku_genre
ON buku(genre);

-- 5. Membuat index pada kolom kota_domisili tabel anggota
CREATE INDEX idx_anggota_kota_domisili
ON anggota(kota_domisili);

-- soal tambahan
SELECT
    c.customerNumber,
    c.customerName,
    c.city,
    (
        SELECT COUNT(*)
        FROM orders o
        WHERE o.customerNumber = c.customerNumber
    ) AS total_pesanan,
    CASE
        WHEN (
            SELECT COUNT(*)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) > 5 THEN 'Pelanggan Loyal'

        WHEN (
            SELECT COUNT(*)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) BETWEEN 2 AND 5 THEN 'Pelanggan Aktif'

        WHEN (
            SELECT COUNT(*)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) = 1 THEN 'Pelanggan Baru'
		ELSE 'Pelanggan Pasif'
    END AS status_loyalitas
FROM customers c
ORDER BY
    total_pesanan DESC,
    c.customername ASC;
