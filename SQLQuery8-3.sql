SELECT * FROM 
(
	SELECT 
	C.CountryID AS [ID], 
	C.CountryName AS [Name], 
	C.IsoAlpha3Code AS [Code], 
	CONVERT(nvarchar(3),C.IsoNumericCode) AS [NCode]
	FROM Application.Countries AS C
  )
AS Country
UNPIVOT  (AllCode  FOR Code_N IN 
										(
										[Code],
										[NCode]
										)
		) as UNPVT;
