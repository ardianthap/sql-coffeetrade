-- sorting from the highest value exporter in terms of Q and $
SELECT 
	trade_id, 
	country_name, 
	element_name, 
	value_trade, 
	unit_measure,
	year_trade
FROM coffeetrade
WHERE element_name IN ('Export Value', 'Export Quantity')
	AND value_trade IS NOT NULL
	AND value_trade > 0
ORDER BY value_trade DESC;

-- sorting from the highest value importer in terms of Q and $
SELECT 
	trade_id, 
	country_name, 
	element_name, 
	value_trade, 
	unit_measure,
	year_trade
FROM coffeetrade
WHERE element_name IN ('Import Value', 'Import Quantity')
	AND value_trade IS NOT NULL
	AND value_trade > 0
ORDER BY value_trade DESC;

-- finding if there exists countries that have trade value > 10000. 
SELECT 
	country_name,
	element_name,
	value_trade
FROM
	coffeetrade
WHERE 
	value_trade > 10000;

-- create a view for highest importer > 10000 value trade in tonnes and ($000)
CREATE VIEW "Highest Importer" AS
SELECT country_name, element_name, product_name, value_trade, unit_measure
FROM coffeetrade
WHERE 
	(element_name = 'Import Quantity' OR element_name = 'Import Value')
	AND
	value_trade > 10000;

-- overall valuetrade ROW_NUMBER
SELECT
	tradeid,
	countryname,
	productname,
	valuetrade,
	unitmeasure,
	elementname,
	yeartrade,
	ROW_NUMBER() OVER(ORDER BY valuetrade DESC) AS overall_valuetrade_rownumber
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL;

-- PARTITIONed overall valuetrade ROW_NUMBER
SELECT
	tradeid,
	countryname,
	productname,
	valuetrade,
	unitmeasure,
	elementname,
	yeartrade,
	ROW_NUMBER() OVER(ORDER BY valuetrade DESC) AS overall_valuetrade_rownumber,
	ROW_NUMBER() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS element_valuetrade_rownumber
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL;

-- ROW_NUMBER each element for the highest value
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS averagevalue,
	ROW_NUMBER() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS productvaluerank
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
ORDER BY
	valuetrade DESC;

-- DENSE_RANK Import Value for the highest value
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS import_averagevalue_rownumber,
	DENSE_RANK() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS import_productvaluerank
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
	AND
	elementname = 'Import Value'
ORDER BY
	valuetrade DESC;

-- DENSE_RANK Export Value for the highest value
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS export_averagevalue_rownumber,
	DENSE_RANK() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS export_productvalue_rownumber
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
	AND
	elementname = 'Export Value'
ORDER BY
	valuetrade DESC;

-- DENSE_RANK Import Quantity for the highest value
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS import_averagequantity_rownumber,
	DENSE_RANK() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS import_productquantity_rownumber
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
	AND
	elementname = 'Import Quantity'
ORDER BY
	valuetrade DESC;

-- DENSE_RANK Export Quantity for the highest value
SELECT
	countryname,
	elementname,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS export_averagequantity_rownumber,
	DENSE_RANK() OVER(PARTITION BY elementname ORDER BY valuetrade DESC) AS export_productquantity_rownumber
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
	AND
	elementname = 'Import Quantity'
ORDER BY
	valuetrade DESC;

-- RANKING Import Value for the highest value, noticing the last year's valuetrade
SELECT
	countryname,
	elementname,
	valuetrade,
	productname,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname, productname) AS import_countryaveragevalue_rownumber,
	DENSE_RANK() OVER(PARTITION BY elementname, productname ORDER BY valuetrade DESC) AS import_productvaluerank_rank,
	LAG(valuetrade) OVER(PARTITION BY countryname, elementname, productname ORDER BY yeartrade) AS import_countrypreviousyeartrade
FROM coffeetrade
WHERE
	valuetrade IS NOT NULL
	AND
	elementname = 'Import Value'
ORDER BY
	valuetrade DESC;

-- TOP 10 countries from every element across the database
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
