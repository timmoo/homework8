SELECT * FROM 
	(
		SELECT DISTINCT
		SUBSTRING(CONVERT(varchar(10),I.InvoiceDate,104),4,8) AS [Date],
		SUBSTRING(C.CustomerName,14,25) AS [ShortName], 
		COUNT(I.InvoiceID) OVER (PARTITION BY  C.CustomerName, YEAR(I.InvoiceDate), MONTH(I.InvoiceDate))	AS [SalesCount] 
		FROM Sales.Customers AS C
		JOIN Sales.Invoices AS I
		ON C.CustomerID=I.CustomerID
		WHERE C.CustomerID>=2 AND C.CustomerID<=6 
		) AS Sales
PIVOT (SUM(SalesCount)
FOR ShortName IN ([ (Peeples Valley, AZ)],[ (Medicine Lodge, KS)],[ (Gasport, NY)], [ (Sylvanite, MT)],[ (Jessie, ND)]))
as PVT
ORDER BY [Date];

