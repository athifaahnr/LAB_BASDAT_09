
-- Zahwa Dwi Putri H071251065
SELECT DISTINCT status, orderdate AS "Tanggal Pesanan" FROM orders
WHERE status = 'In Process' OR status ='On Hold' AND orderdate > '2003-01-01'
ORDER BY orderdate ASC
LIMIT 10;

