SELECT * FROM 
(
	SELECT 
	C.CustomerName AS [Name], 
	(C.DeliveryAddressLine1) AS Adress1,
	(C.DeliveryAddressLine2) AS Adress2,
	(C.PostalAddressLine1) AS Adress3,
	(C.PostalAddressLine2) AS Adress4
	FROM Sales.Customers AS C
	WHERE C.CustomerName LIKE ('%Tailspin Toys%')
) AS Adress
UNPIVOT  (ADRESS_TOTAL  FOR ADRESS_ IN 
										(
										[Adress1], [Adress2], [Adress3], [Adress4]
										)
		) as UNPVT;
