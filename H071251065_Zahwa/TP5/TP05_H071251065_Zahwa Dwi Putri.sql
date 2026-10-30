set search_path to classicmodels;

-- SOAL 1
SELECT c.contactFirstname AS "Nama Depan Kontak",
		c.customerName AS "Nama Pelanggan", 
		o.city AS "Kota Kantor Cabang",
		CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c 
JOIN employees e ON c.salesrepemployeeNumber = e.employeenumber
JOIN offices o ON e.officeCode = o.officecode
WHERE c.contactFirstname ILIKE 'A%' AND o.city NOT LIKE 'NYC'
ORDER BY c.customerName ASC;

-- SOAL 2
SELECT c.customerName AS "Nama Pelanggan",
		SUM(p.amount) AS total_payment,
		MAX(p.amount) AS max_single_paymnet
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber;
GROUP BY c.customerNumber
HAVING SUM (p.amount) > 50000
ORDER BY total_payment DESC;

-- SOAL 3
SELECT c.customerName AS "Nama Pelanggan",
		COUNT(DISTINCT o.ordernumber)AS total_order,
		ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY c.customerNumber
HAVING COUNT(DISTINCT o.orderNumber) > 3 AND AVG(od.quantityOrdered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- SOAL 4
SELECT p.productline AS "Lini Produk", 
		SUM(od.quantityOrdered) AS total_terjual, 
		ROUND(AVG(od.priceEach),2) AS rata_rata_harga,
		ROUND(AVG((p.msrp-od.priceEach) / p.msrp * 100),2) AS avg_discount_percentage
FROM products p
JOIN orderDetails od ON p.productCode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityOrdered) > 3000 AND ROUND(AVG(od.priceEach),2) > 80
ORDER BY total_terjual DESC;

-- soal 5
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT os.ordernumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
INNER JOIN orders AS o
    ON c.customernumber = o.customernumber
INNER JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
LEFT JOIN orders AS os
    ON os.ordernumber = o.ordernumber
    AND os.status = 'Shipped'
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;
		
-- SOAL 6
SELECT c.customerName,
		c.city AS customer_city,
		oc.city AS office_city,
		SUM(od.quantityOrdered) AS total_unit_terjual,
		ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices oc ON oc.officeCode = e.officeCode
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
WHERE oc.territory = 'EMEA'
GROUP BY c.customerNumber, oc.officecode
HAVING COUNT(DISTINCT EXTRACT (YEAR FROM o.orderDate)) > 2 AND SUM(od.quantityOrdered) > 1000 AND ROUND(SUM(od.quantityOrdered * priceEach) / COUNT(DISTINCT o.orderNumber), 2) > 10000
ORDER BY avg_nilai_per_order DESC;