
-- NOMOR 1
SELECT
    c.contactFirstName,
    c.customerName,
    o.city,
    CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o
    ON e.officeCode = o.officeCode
WHERE c.contactFirstName LIKE 'A%'
    AND o.city <> 'NYC'
ORDER BY c.customerName ASC;


-- NOMOR 2
SELECT
    c.customerName,
    SUM(p.amount) AS total_payment,
    MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p
    ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;


-- NOMOR 3
SELECT
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS total_order,
    ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3
    AND AVG(od.quantityOrdered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;


-- NOMOR 4
SELECT
    p.productLine,
    SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(
        AVG((p.MSRP - od.priceEach) / p.MSRP * 100),
        2
    ) AS avg_discount_percentage
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000
    AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;


-- NOMOR 5

SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    (
        SELECT COUNT(*)
        FROM orders o2
        WHERE o2.customerNumber = c.customerNumber
        AND o2.status = 'Shipped'
    ) AS total_shipped_orders,
    ROUND(
        SUM(od.quantityOrdered * od.priceEach)
        / COUNT(DISTINCT o.orderNumber),
        2
    ) AS avg_transaction_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;



-- NOMOR 6
SELECT
    c.customerName,
    c.city AS customer_city,
    o.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(
        SUM(od.quantityOrdered * od.priceEach)
        / COUNT(DISTINCT ord.orderNumber),
        2
    ) AS avg_nilai_per_order
FROM customers c
JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o
    ON e.officeCode = o.officeCode
JOIN orders ord
    ON c.customerNumber = ord.customerNumber
JOIN orderdetails od
    ON ord.orderNumber = od.orderNumber
WHERE o.territory = 'EMEA'
GROUP BY
    c.customerNumber,
    c.customerName,
    c.city,
    o.city
HAVING COUNT(
    DISTINCT EXTRACT(YEAR FROM ord.orderDate)
) > 2
    AND SUM(od.quantityOrdered) > 1000
    AND (
        SUM(od.quantityOrdered * od.priceEach)
        / COUNT(DISTINCT ord.orderNumber)
    ) > 10000
ORDER BY avg_nilai_per_order DESC;



