SELECT productname AS "Nama Produk", buyprice AS "Harga Beli", msrp AS "Harga Jual", (msrp - buyprice) AS "Potensi Keuntungan" FROM products
WHERE buyprice > 50 AND (msrp - buyprice) > 30
ORDER BY (msrp - buyprice) DESC;


