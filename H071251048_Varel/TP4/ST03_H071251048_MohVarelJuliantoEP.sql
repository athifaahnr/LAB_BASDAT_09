-- Tim manajemen pengiriman ingin mengevaluasi pesanan yang statusnya sudah selesai atau dibatalkan untuk periode tertentu. Buatlah query SQL dari tabel orders dengan ketentuan berikut:
-- Tampilkan nomor pesanan (ordernumber), tanggal pesanan dengan alias Tanggal Pesanan, status pesanan, dan nomor pelanggan (customernumber).
-- Saring data agar hanya menampilkan pesanan yang memiliki status 'Shipped' atau 'Cancelled'.
-- Saring juga agar hanya mencakup pesanan yang dilakukan setelah tanggal 1 Jnuari 2004 ('2004-01-01').
-- Urutkan hasil laporan berdasarkan tanggal pesanan secara menaik (dari tanggal tertua ke terbaru).

SELECT ordernumber, orderdate AS "TANGGAL PESANAN", status, customernumber FROM orders
WHERE status ILIKE '%Shipped%' OR '%Cancelled%', EXTRACT(date '2004-01-01') 
ORDER BY orderdate DESC;
