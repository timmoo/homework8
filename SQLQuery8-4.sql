SELECT 
C.CustomerID, 
C.CustomerName, 
O.*
FROM Sales.Customers AS C
CROSS APPLY (SELECT 
			DISTINCT TOP 2 IL1.UnitPrice AS [UnitPrice],  
			IL1.StockItemID AS StockID, 
			I.InvoiceDate AS [DATE]
			FROM Sales.InvoiceLines  AS IL1
			INNER JOIN Sales.Invoices AS I ON IL1.InvoiceID=I.InvoiceID
			GROUP BY IL1.UnitPrice , IL1.StockItemID, I.InvoiceDate
			ORDER BY IL1.UnitPrice DESC
               ) AS O
ORDER BY C.CustomerID;
