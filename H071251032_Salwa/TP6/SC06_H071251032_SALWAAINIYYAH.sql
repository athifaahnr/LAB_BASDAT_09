-- SC Kak Ananta
SELECT
	employeenumber AS "nomor karyawan",
	CONCAT(firstname, ' ', lastname) AS "nama lengkap karyawan",
	email,
	officecode AS "kode kantor"
FROM employees
WHERE jobtitle = 'Sales Rep' 
AND NOT EXISTS (
	SELECT 1
	FROM customers
	WHERE customers.salesrepemployeenumber = employees.employeenumber AND EXISTS (
		SELECT 1 customernumber
		FROM orders
		WHERE orders.customernumber = customers.customernumber AND status = 'Shipped'
	)
)
ORDER BY employeenumber ASC;