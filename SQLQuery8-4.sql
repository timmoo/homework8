WITH CTE AS 
	( 
	SELECT C.CustomerID, 
		C.CustomerName,  
		IL1.UnitPrice AS [UnitPrice],  
		IL1.StockItemID AS StockID, 
		I.InvoiceDate AS [DATE], 
		ROW_NUMBER()  OVER(PARTITION BY I.CustomerID ORDER BY IL1.UnitPrice desc) AS NUMBER FROM Sales.InvoiceLines  AS IL1
		INNER JOIN Sales.Invoices AS I ON IL1.InvoiceID=I.InvoiceID
		INNER JOIN Sales.Customers AS C ON I.CustomerID=C.CustomerID
)
 Select
	 DISTINCT CTE.CustomerID, 
 	CTE.CustomerName, 
 	CTE.StockID, 
 	CTE.UnitPrice, 
 	CTE.DATE, CTE.NUMBER FROM CTE 
  where CTE.NUMBER<=2
  ORDER BY CTE.CustomerID;

SELECT C.CustomerID, C.CustomerName, O.*
FROM Sales.Customers C
CROSS APPLY (SELECT DISTINCT TOP 2 
			IL1.UnitPrice AS [UnitPrice],  
		IL1.StockItemID AS StockID, 
		I.InvoiceDate AS [DATE]
		FROM Sales.InvoiceLines  AS IL1
		INNER JOIN Sales.Invoices AS I ON IL1.InvoiceID=I.InvoiceID
		INNER JOIN Sales.Customers AS C ON I.CustomerID=C.CustomerID
		GROUP BY IL1.UnitPrice , IL1.StockItemID, I.InvoiceDate
		ORDER BY IL1.UnitPrice DESC
               ) AS O
ORDER BY C.CustomerID;
