SET search_path TO classicmodels, public;
--SOAL 1 
SELECT 
    c.contactFirstName,
    c.customerName,
    o.city AS office_city,
    CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
INNER JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices o ON e.officeCode = o.officeCode
WHERE LOWER(c.contactFirstName) LIKE 'a%'
  AND o.city != 'NYC'
ORDER BY c.customerName ASC; 

--SOAL 2
SELECT
    c.customername,
    SUM(p.amount) AS total_payment,
    MAX(p.amount) AS max_single_payment
FROM customers c
INNER JOIN payments p ON c.customernumber = p.customernumber
GROUP BY c.customernumber, c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

--SOAL 3
SELECT
    c.customername,
    COUNT(DISTINCT o.ordernumber) AS total_order,
    ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
INNER JOIN orders o ON c.customernumber = o.customernumber
INNER JOIN orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT o.ordernumber) > 3
   AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;



--SOAL 4
SELECT
    p.productline,
    SUM(od.quantityordered) AS total_terjual,
    ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
    ROUND(AVG((p.msrp - od.priceeach) / p.msrp * 100), 2) AS avg_discount_percentage
FROM products p
INNER JOIN orderdetails od ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000
   AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

--SOAL 5
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT o.ordernumber) FILTER(WHERE o.status='Shipped') AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber),2) AS avg_transaction_per_order
FROM customers AS c
INNER JOIN orders AS o ON c.customernumber = o.customernumber
INNER JOIN orderdetails AS od ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

--SOAL 6
SELECT
    c.customername,
    c.city AS customer_city,
    off.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber),2) AS avg_nilai_per_order
FROM customers AS c
INNER JOIN employees AS e ON c.salesrepemployeenumber = e.employeenumber
INNER JOIN offices AS off ON e.officecode = off.officecode
INNER JOIN orders AS o ON c.customernumber = o.customernumber
INNER JOIN orderdetails AS od ON o.ordernumber = od.ordernumber
WHERE off.territory = 'EMEA'
GROUP BY c.customernumber, c.customername, c.city, off.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2
   AND SUM(od.quantityordered) > 1000
   AND SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;
