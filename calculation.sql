-- Countries within the TOP 10 trade from every element within the Main Table Ñ GENERAL
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS averagevalue,
	ROW_NUMBER() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS productvaluerank,

CASE
	WHEN ROW_NUMBER() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) <= 10 THEN 'Top 10'
	ELSE 'Not'
	END AS Top_10

FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
ORDER BY
	valuetrade DESC;

