set search_path to classicmodels;

SELECT c.customerNumber AS "Nomor Pelanggan",
    	c.customerName AS "Nama Pelanggan",
    	c.city AS "Kota Domisili",
    	(SELECT COUNT(o.orderNumber)
        FROM orders o
        WHERE o.customerNumber = c.customerNumber
    ) AS "Total Pesanan",
    CASE
        WHEN(
            SELECT COUNT(o.orderNumber)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) > 5 THEN 'Pelanggan Loyal'
        WHEN (
            SELECT COUNT(o.orderNumber)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) BETWEEN 2 AND 5 THEN 'Pelanggan Aktif'
        WHEN (
            SELECT COUNT(o.orderNumber)
            FROM orders o
            WHERE o.customerNumber = c.customerNumber
        ) = 1 THEN 'Pelanggan Baru'
        ELSE 'Pelanggan Pasif'
    END AS "Kategori"
FROM customers c
ORDER BY "Total Pesanan" DESC, c.customerName ASC;