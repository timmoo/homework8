SELECT 
ID,
Name, 
PolnyCod 
FROM 
	(
	SELECT 
	C.CountryID AS [ID], 
	C.CountryName AS [Name], 
	C.IsoAlpha3Code AS [WordCode], 
	CONVERT(nvarchar(3),C.IsoNumericCode) AS [NumberCode]
	FROM Application.Countries AS C
	)
AS Country
UNPIVOT  (PolnyCod  FOR Cody IN 
								(
								[WordCode],
								[NumberCode]
								)
) as UNPVT;
