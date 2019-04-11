SELECT 
CONVERT(varchar(10),SalesOrderMonth,104) AS [Date], 
[Peeples Valley, AZ],
[Medicine Lodge, KS],
[Gasport, NY], 
[Sylvanite, MT],
[Jessie, ND] 
FROM 
		(SELECT DISTINCT 
		CA.SalesOrderMonth,
		CustomerName.SpecName,
		COUNT(I.InvoiceID) OVER (PARTITION BY  C.CustomerName, YEAR(I.InvoiceDate), MONTH(I.InvoiceDate))	AS [SalesCount] 
		FROM Sales.Customers AS C
		JOIN Sales.Invoices AS I
		ON C.CustomerID=I.CustomerID
		CROSS APPLY (SELECT CAST(DATEADD(mm,DATEDIFF(mm,0,I.InvoiceDate),0) AS DATE) AS SalesOrderMonth) AS CA
		CROSS APPLY (SELECT LeftBracket=CHARINDEX('(', C.CustomerName)) AS LeftBracket
		CROSS APPLY (SELECT RightBracket=CHARINDEX(')', C.CustomerName, LeftBracket+ 1)) AS RightBracket
		CROSS APPLY (SELECT SpecName=SUBSTRING(C.CustomerName, LeftBracket+ 1, RightBracket- LeftBracket- 1)) AS CustomerName
		WHERE C.CustomerID BETWEEN 2 AND 6 
		)AS Sales1
PIVOT (SUM(SalesCount) FOR SpecName IN ([Peeples Valley, AZ],[Medicine Lodge, KS],[Gasport, NY], [Sylvanite, MT],[Jessie, ND]))
as PVT

