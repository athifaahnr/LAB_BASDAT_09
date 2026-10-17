set search_path to classicmodels;

SELECT productcode AS kode_produk,
		COUNT (*) AS jumlah_transaksi,
		SUM(quantityordered) AS total_unit_terjual,
		SUM (quantityordered * priceeach) AS total_pendapatan,
		AVG (priceeach) AS rata_rata_harga_jual
FROM orderdetails
GROUP BY productcode
ORDER BY total_pendapatan DESC;