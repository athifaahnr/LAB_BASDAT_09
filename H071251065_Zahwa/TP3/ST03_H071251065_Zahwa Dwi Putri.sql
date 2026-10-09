SET search_path TO classicmodels, public;

SELECT productCode, productName, quantityInstock, buyPrice
FROM products
WHERE quantityInstock BETWEEN 1000 AND 2000 AND buyPrice < 50 OR buyPrice > 150 AND productName != 'Vintage';