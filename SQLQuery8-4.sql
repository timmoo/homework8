SELECT 
C.CustomerName, 
O.*
FROM Sales.Customers AS C
CROSS APPLY (SELECT 
			DISTINCT TOP 2 I.CustomerID, IL1.UnitPrice AS [UnitPrice],  
			IL1.StockItemID AS StockID, 
			I.InvoiceDate
			FROM Sales.InvoiceLines  AS IL1
			INNER JOIN Sales.Invoices AS I ON IL1.InvoiceID=I.InvoiceID
			WHERE I.CustomerID = C.CustomerID
			GROUP BY IL1.UnitPrice , IL1.StockItemID, I.InvoiceDate, I.CustomerID
			ORDER BY  I.CustomerID, IL1.UnitPrice DESC, I.InvoiceDate
		
               ) AS O
ORDER BY  O.CustomerID, O.UnitPrice DESC, O.InvoiceDate;
