set search_path to classicmodels;
-- Nomor 1
SELECT
    c.contactFirstName,
    c.customerName,
    o.city,
    CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
INNER JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices o
    ON e.officeCode = o.officeCode
WHERE c.contactFirstName ILIKE 'A%'
  AND o.city NOT LIKE  'NYC'
ORDER BY c.customerName ASC;

-- Nomor 2

SELECT
    c.customerName,
    SUM(p.amount) AS total_payment,
    MAX(p.amount) AS max_single_payment
FROM classicmodels.customers c
INNER JOIN classicmodels.payments p
    ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- Nomor 3

SELECT
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS total_order,
    ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM classicmodels.customers c
INNER JOIN classicmodels.orders o
    ON c.customerNumber = o.customerNumber
INNER JOIN classicmodels.orderdetails od
    ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3
   AND AVG(od.quantityOrdered) > 35
ORDER BY total_order DESC,
         avg_quantity_per_order DESC;

-- Nomor 4

SELECT
    pl.productLine,
    SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(
        AVG((p.MSRP - od.priceEach) / p.MSRP * 100),
	2) AS avg_discount_percentage
FROM classicmodels.productlines pl
INNER JOIN classicmodels.products p
    ON pl.productLine = p.productLine
INNER JOIN classicmodels.orderdetails od
    ON p.productCode = od.productCode
GROUP BY pl.productLine
HAVING SUM(od.quantityOrdered) > 3000
   AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

-- nomor 5

SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT o.orderNumber) AS total_shipped_orders,
    ROUND(
        SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber),2) AS avg_transaction_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderDetails od
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- nomor 6

SELECT
    c.customerName,
    c.city AS customer_city,
    o2.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o2
    ON e.officeCode = o2.officeCode
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderDetails od
    ON o.orderNumber = od.orderNumber
WHERE o2.territory = 'EMEA'
GROUP BY c.customerNumber, c.customerName, c.city, o2.city
HAVING
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
    AND SUM(od.quantityOrdered) > 1000
    AND (SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber)) > 10000
ORDER BY avg_nilai_per_order DESC;






























