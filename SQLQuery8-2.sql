SELECT   
	CustomerName, 
	PolnyAdress
FROM Sales.Customers
UNPIVOT		(PolnyAdress  FOR Adressa IN 
										(
										Sales.Customers.DeliveryAddressLine1,
										Sales.Customers.DeliveryAddressLine2,
										Sales.Customers.PostalAddressLine1,
										Sales.Customers.PostalAddressLine2
										)
			) as UNPVT
WHERE CustomerName LIKE ('%Tailspin Toys%');
