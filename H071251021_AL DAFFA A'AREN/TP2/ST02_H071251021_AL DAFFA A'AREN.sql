SELECT productname AS nama_produk, buyprice as harga_beli, msrp as harga_jual, (msrp - buyprice) AS potensiKeuntungan from classicmodels.products 
WHERE buyprice > 50 AND msrp - buyprice > 30
ORDER BY potensiKeuntungan DESC;