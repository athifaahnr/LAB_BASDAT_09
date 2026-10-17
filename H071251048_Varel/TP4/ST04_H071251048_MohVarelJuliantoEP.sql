SELECT productcode AS kode_produk,
COUNT(ordernumber) AS Jumlah_transaksi,
SUM(quantityordered) AS total_unit_terjual ,
SUM(priceeach * quantityordered) AS total_keuntungan,
SUM(priceeach) AS rata_rataa 
FROM orderdetails 
GROUP BY productcode
HAVING SUM(quantityordered) > 500
ORDER BY total_keuntungan DESC;