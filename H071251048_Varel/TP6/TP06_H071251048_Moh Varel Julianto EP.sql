
-- NOMOR 1

SELECT
    productCode,
    productName,
    MSRP,
    quantityInStock,
    CASE
        WHEN MSRP < 50 AND quantityInStock > 500
            THEN 'Ekonomis - Stok Tinggi'
        WHEN MSRP < 50 AND quantityInStock <= 500
            THEN 'Ekonomis - Stok Rendah'
        WHEN MSRP >= 50 AND MSRP <= 100
            THEN 'Harga Menengah'
        WHEN MSRP > 100
            THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY MSRP DESC;


-- NOMOR 2

SELECT
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productCode
HAVING
    SUM(quantityOrdered) > (
        SELECT AVG(quantityOrdered)
        FROM orderdetails
    )
    AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;


-- NOMOR 3

SELECT
    productCode,
    productName,
    quantityInStock,
    MSRP
FROM products
WHERE quantityInStock > (
    SELECT AVG(quantityInStock)
    FROM products
)
AND MSRP > (
    SELECT AVG(MSRP)
    FROM products
)
ORDER BY quantityInStock DESC;


-- NOMOR 4

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


-- NOMOR 5

CREATE TABLE anggota (
    id SERIAL PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id SERIAL PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
    id SERIAL PRIMARY KEY,
    id_anggota INTEGER REFERENCES anggota(id),
    id_buku INTEGER REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0
);




CREATE INDEX index_buku_genre
ON buku(genre);

CREATE INDEX index_anggota_kota_domisili
ON anggota(kota_domisili);

select * from anggota;

-- STADIKES
SELECT
    customerNumber,
    customerName,
    ROUND(total, 2) AS total_belanja
FROM (
    SELECT
        c.customerNumber,
        c.customerName,
        SUM(od.quantityOrdered * od.priceEach) AS total
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY c.customerNumber, c.customerName
) 
WHERE total > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS total
        FROM orders o
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        GROUP BY o.customerNumber
    )
)
ORDER BY total_belanja DESC;
