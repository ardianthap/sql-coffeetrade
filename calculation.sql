-- Countries within the TOP 10 trade from every element within the Main Table - GENERAL
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

-- Countries within the TOP 10 trade from every element within the Main Table - DISTINCT
WITH top_10_countries AS (
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
		valuetrade DESC)
	
SELECT DISTINCT
	countryname
FROM top_10_countries
WHERE
	top_10 = 'Top 10';

-- TOP 10 countries from 'Export Value' element by AVG
WITH exporterbyvalue_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_valueexported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_valueexported
	FROM "Export Value"
  WHERE
	   valuetrade IS NOT NULL
  GROUP BY countryname
	)	

SELECT
    countryname,
    average_valueexported,
    rank_average_valueexported
FROM exporterbyvalue_avg_descriptives
WHERE rank_average_valueexported <= 10
ORDER BY rank_average_valueexported ASC;

-- TOP 10 countries from 'Export Value' element by SUM
WITH exporterbyvalue_sum_descriptives AS (
    SELECT
	countryname,
	SUM(valuetrade) AS total_thousanddollar_generated,
	RANK() OVER(ORDER BY SUM(valuetrade) DESC) AS rank_total_thousanddollar_generated
    FROM "Export Value"
    WHERE
        valuetrade IS NOT NULL
    GROUP BY countryname
		)
		
SELECT
    countryname,
    total_thousanddollar_generated,
    rank_thousanddollar_generated
FROM exporterbyvalue_sum_descriptives
WHERE rank_total_thousanddollar_generated <= 10
ORDER BY rank_total_thousanddollar_generated ASC;

-- TOP 10 countries from 'Import Value' element by AVG
WITH importerbyvalue_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_valueimported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_valueimported
	FROM "Import Value"
  WHERE
	   valuetrade IS NOT NULL
  GROUP BY countryname
	)	

SELECT
    countryname,
    average_valueimported,
    rank_average_valueimported
FROM importerbyvalue_avg_descriptives
WHERE rank_average_valueimported <= 10
ORDER BY rank_average_valueimported ASC;

-- TOP 10 countries from 'Import Value' element by SUM
WITH importerbyvalue_sum_descriptives AS (
    SELECT
	countryname,
	SUM(valuetrade) AS total_thousanddollar_spent,
	RANK() OVER(ORDER BY SUM(valuetrade) DESC) AS rank_total_thousanddollar_spent
    FROM "Import Value"
    WHERE
        valuetrade IS NOT NULL
    GROUP BY countryname
		)
		
SELECT
    countryname,
    total_thousanddollar_spent,
    rank_total_thousanddollar_spent
FROM importerbyvalue_sum_descriptives
WHERE rank_total_thousanddollar_spent <= 10
ORDER BY rank_total_thousanddollar_spent ASC;

-- TOP 10 countries from 'Export Quantity' element by AVG
WITH exporterbyquantity_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_quantityexported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_quantityexported
	FROM "Export Quantity"
	WHERE
		valuetrade IS NOT NULL
	GROUP BY countryname
	)	

SELECT
    countryname,
    average_quantityexported,
    rank_average_quantityexported
FROM exporterbyquantity_avg_descriptives
WHERE rank_average_quantityexported <= 10
ORDER BY rank_average_quantityexported ASC;

-- TOP 10 countries from 'Import Value' element by AVG
WITH importerbyvalue_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_valueimported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_valueimported
	FROM "Import Value"
	WHERE
	   valuetrade IS NOT NULL
  GROUP BY countryname
	)	

SELECT
    countryname,
    average_valueimported,
    rank_average_valueimported
FROM importerbyvalue_avg_descriptives
WHERE rank_average_valueimported <= 10
ORDER BY rank_average_valueimported ASC;

-- TOP 10 countries from 'Import Value' element by SUM
WITH importerbyvalue_sum_descriptives AS (
    SELECT
	countryname,
	SUM(valuetrade) AS total_thousanddollar_spent,
	RANK() OVER(ORDER BY SUM(valuetrade) DESC) AS rank_total_thousanddollar_spent
    FROM "Import Value"
    WHERE
        valuetrade IS NOT NULL
    GROUP BY countryname
		)
		
SELECT
    countryname,
    total_thousanddollar_spent,
    rank_total_thousanddollar_spent
FROM importerbyvalue_sum_descriptives
WHERE rank_total_thousanddollar_spent <= 10
ORDER BY rank_total_thousanddollar_spent ASC;

-- TOP 10 countries from 'Export Quantity' element by AVG
WITH exporterbyquantity_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_quantityexported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_quantityexported
	FROM "Export Quantity"
	WHERE
		valuetrade IS NOT NULL
	GROUP BY countryname
	)	

SELECT
    countryname,
    average_quantityexported,
    rank_average_quantityexported
FROM exporterbyquantity_avg_descriptives
WHERE rank_average_quantityexported <= 10
ORDER BY rank_average_quantityexported ASC;

-- TOP 10 countries from 'Export Quantity' element by SUM
WITH exporterbyquantity_sum_descriptives AS (
    SELECT
	countryname,
	SUM(valuetrade) AS total_tonnageexported,
	RANK() OVER(ORDER BY SUM(valuetrade) DESC) AS rank_total_tonnageexported
    FROM "Export Quantity"
    WHERE
	    valuetrade IS NOT NULL
    GROUP BY countryname,
		)
		
SELECT
    countryname,
    total_tonnageexported,
    rank_total_tonnageexported
FROM exporterbyquantity_sum_descriptives
WHERE rank_total_tonnageexported <= 10
ORDER BY rank_total_tonnageexported ASC;

-- TOP 10 countries from 'Import Quantity' element by AVG
WITH importerbyquantity_avg_descriptives AS (
	SELECT
		countryname,
		ROUND (AVG(valuetrade), 2) AS average_quantityimported,
		RANK() OVER(ORDER BY ROUND (AVG(valuetrade), 2) DESC) AS rank_average_quantityimported
	FROM "Import Quantity"
  WHERE
	   valuetrade IS NOT NULL
  GROUP BY countryname
	)	

SELECT
    countryname,
    average_valueimported,
    rank_average_valueimported
FROM importerbyquantity_avg_descriptives
WHERE rank_average_valueimported <= 10
ORDER BY rank_average_valueimported ASC;

-- TOP 10 countries from 'Import Quantity' element by SUM
WITH importerbyquantity_sum_descriptives AS (
    SELECT
	countryname,
	SUM(valuetrade) AS total_tonnageimported,
	RANK() OVER(ORDER BY SUM(valuetrade) DESC) AS rank_total_tonnageimported
    FROM "Import Quantity"
    WHERE
        valuetrade IS NOT NULL
    GROUP BY countryname
		)
		
SELECT
    countryname,
    total_tonnageimported,
    rank_total_tonnageimported
FROM importerbyquantity_sum_descriptives
WHERE rank_total_tonnageimported <= 10
ORDER BY rank_total_tonnageimported ASC;

-- PARTITION BY country name and element name
SELECT
	countryname,
	elementname,
	unitmeasure,
	valuetrade,
	yeartrade,
	AVG(valuetrade) OVER (PARTITION BY countryname, elementname) AS averagevalue,
	MAX(valuetrade) OVER (PARTITION BY countryname, elementname) AS highestvalue,
	ROUND(
        	valuetrade / NULLIF(AVG(valuetrade) 
		OVER (PARTITION BY countryname, elementname), 0), 4
		) AS relativecontribution
FROM
	coffeetrade
WHERE
	valuetrade IS NOT NULL
ORDER BY
	valuetrade DESC;

-- creating a view to process exporter countries, in terms of tonnage (quantity) exported 
CREATE VIEW "Export Quantity" AS 
SELECT 
	countryname, 
	productname, 
	valuetrade, 
	unitmeasure, 
	yeartrade
FROM coffeetrade
WHERE elementname = 'Export Quantity';

-- checking Export Quantity View
SELECT * FROM "Export Quantity";

-- creating a view to process exporter countries, in terms of $ value exported
CREATE VIEW "Export Value" AS 
SELECT 
	countryname,  
	productname, 
	valuetrade, 
	unitmeasure, 
	yeartrade
FROM coffeetrade
WHERE elementname = 'Export Value';
	
-- checking Export Value view
SELECT * FROM "Export Value"

-- creating a view to process importer countries, in terms of tonnage exported (quantity)
CREATE VIEW "Import Quantity" AS 
SELECT 
	countryname, 
	productname, 
	valuetrade, 
	unitmeasure, 
	yeartrade
FROM coffeetrade
WHERE elementname = 'Import Quantity';

-- checking Import Quantity View
SELECT * FROM "Import Quantity";

-- creating a view to process Import countries, in terms of $ value imported
CREATE VIEW "Import Value" AS 
SELECT 
	countryname, 
	productname, 
	valuetrade, 
	unitmeasure, 
	yeartrade
FROM coffeetrade
WHERE elementname = 'Import Value';
	
-- checking Export Value view
SELECT * FROM "Import Value"

--  creating a numerical view to notice Export $ value relative to every tonnage
SELECT
	ev.countryname,
	ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 2) AS exportmarginratio,
	ev.productname,
	ev.yeartrade
FROM
	"Export Value" AS ev
INNER JOIN
	"Export Quantity" AS eq
ON
	ev.countryname = eq.countryname
	AND ev.productname = eq.productname
	AND ev.yeartrade = eq.yeartrade
WHERE
	ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 4) != '0'
ORDER BY exportmarginratio DESC;

--  creating a numerical view to notice Export $ value relative to every tonnage
SELECT
	iv.countryname,
	ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 4) AS importmarginratio,
	iv.productname,
	iv.yeartrade
FROM
	"Import Value" AS iv
INNER JOIN
	"Import Quantity" AS iq
ON
	iv.countryname = iq.countryname
	AND iv.productname = iq.productname
	AND iv.yeartrade = iq.yeartrade
WHERE
	ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 4) != '0'
ORDER BY importmarginratio DESC;

--  creating a numerical view to notice Export $ value relative to every tonnage
SELECT
	ev.countryname,
	ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 2) AS exportmarginratio,
	ev.productname,
	ev.yeartrade
FROM
	"Export Value" AS ev
INNER JOIN
	"Export Quantity" AS eq
ON
	ev.countryname = eq.countryname
	AND ev.productname = eq.productname
	AND ev.yeartrade = eq.yeartrade
WHERE
	ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 4) != '0'
ORDER BY exportmarginratio DESC;


--  creating a numerical view to notice Import $ value relative to every tonnage
SELECT
	iv.countryname,
	ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 4) AS importmarginratio,
	iv.productname,
	iv.yeartrade
FROM
	"Import Value" AS iv
INNER JOIN
	"Import Quantity" AS iq
ON
	iv.countryname = iq.countryname
	AND iv.productname = iq.productname
	AND iv.yeartrade = iq.yeartrade
WHERE
	ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 4) != '0'
ORDER BY importmarginratio DESC;


--  RANKing the margin ratio from Top 10 Exporter in terms of $ generated.
WITH country_exportmarginratio AS
	(SELECT
		ev.countryname,
		ev.valuetrade AS thousanddollar_generated,
		eq.valuetrade AS tonnage_sold,
		ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0),2) AS exportmarginratio,
		ev.productname,
		ev.yeartrade
	FROM
		"Export Value" AS ev
	INNER JOIN
		"Export Quantity" AS eq
	ON
		ev.countryname = eq.countryname
		AND ev.productname = eq.productname
		AND ev.yeartrade = eq.yeartrade
	WHERE
		ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 2) != '0'
	),
	ranked_exportmarginratio AS
	(SELECT
	 	countryname,
	 	productname,
	 	thousanddollar_generated,
	 	tonnage_sold,
	 	exportmarginratio,
	 	yeartrade,
	 	DENSE_RANK() OVER(ORDER BY exportmarginratio DESC) AS rank_exportmarginratio
	FROM 
	 	country_exportmarginratio
	)


SELECT
	countryname,
	productname,
	thousanddollar_generated,
	tonnage_sold,
	exportmarginratio,
	rank_exportmarginratio,
	yeartrade
FROM ranked_exportmarginratio
WHERE
	countryname IN ('Brazil', 'Viet Nam', 'Germany', 'Colombia', 'Switzerland', 'Italy', 'Indonesia', 'Belgium', 'United States of America
', 'Guatemala')
ORDER BY rank_exportmarginratio ASC;
	
	

--  RANKing the margin ratio from Top 10 Exporter in terms of Quantity Exported.
WITH country_exportmarginratio AS
	(SELECT
		ev.countryname,
		ev.valuetrade AS thousanddollar_generated,
		eq.valuetrade AS tonnage_sold,
		ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0),2) AS exportmarginratio,
		ev.productname,
		ev.yeartrade
	FROM
		"Export Value" AS ev
	INNER JOIN
		"Export Quantity" AS eq
	ON
		ev.countryname = eq.countryname
		AND ev.productname = eq.productname
		AND ev.yeartrade = eq.yeartrade
	WHERE
		ROUND(ev.valuetrade / NULLIF(eq.valuetrade, 0), 2) != '0'
	),
	ranked_exportmarginratio AS
	(SELECT
	 	countryname,
	 	productname,
	 	thousanddollar_generated,
	 	tonnage_sold,
	 	exportmarginratio,
	 	yeartrade,
	 	DENSE_RANK() OVER(ORDER BY exportmarginratio DESC) AS rank_exportmarginratio
	FROM 
	 	country_exportmarginratio
	)


SELECT
	countryname,
	productname,
	thousanddollar_generated,
	tonnage_sold,
	exportmarginratio,
	rank_exportmarginratio,
	yeartrade
FROM ranked_exportmarginratio
WHERE
	countryname IN ('Viet Nam', 'Brazil', 'Colombia', 'Germany', 'Indonesia', 'Guatemala', 'Honduras', 'Peru', 'India', 'Ethiopia')
ORDER BY rank_exportmarginratio ASC;
	
	

--  RANKing the margin ratio from Top 10 Importer in terms of $ Spent.
WITH country_importmarginratio AS
	(SELECT
		iv.countryname,
		iv.valuetrade AS thousanddollar_spent,
		iq.valuetrade AS tonnage_bought,
		ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0),2) AS importmarginratio,
		iv.productname,
		iv.yeartrade
	FROM
		"Import Value" AS iv
	INNER JOIN
		"Import Quantity" AS iq
	ON
		iv.countryname = iq.countryname
		AND iv.productname = iq.productname
		AND iv.yeartrade = iq.yeartrade
	WHERE
		ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 2) != '0'
	),
	ranked_importmarginratio AS
	(SELECT
	 	countryname,
	 	productname,
	 	thousanddollar_spent,
	 	tonnage_bought,
	 	importmarginratio,
	 	yeartrade,
	 	DENSE_RANK() OVER(ORDER BY importmarginratio DESC) AS rank_importmarginratio
	FROM 
	 	country_importmarginratio
	)


SELECT
	countryname,
	productname,
	thousanddollar_spent,
	tonnage_bought,
	importmarginratio,
	rank_importmarginratio,
	yeartrade
FROM ranked_importmarginratio
WHERE
	countryname IN ('United States of America', 'Germany', 'France', 'Japan', 'Italy', 'Canada', 'Belgium', 'United Kingdom of Great Britain and Northern Ireland', 'Spain', 'Netherlands')
ORDER BY rank_importmarginratio ASC;



--  RANKing the margin ratio from Top 10 Importer in terms of Tonnage Bought.
WITH country_importmarginratio AS
	(SELECT
		iv.countryname,
		iv.valuetrade AS thousanddollar_spent,
		iq.valuetrade AS tonnage_bought,
		ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0),2) AS importmarginratio,
		iv.productname,
		iv.yeartrade
	FROM
		"Import Value" AS iv
	INNER JOIN
		"Import Quantity" AS iq
	ON
		iv.countryname = iq.countryname
		AND iv.productname = iq.productname
		AND iv.yeartrade = iq.yeartrade
	WHERE
		ROUND(iv.valuetrade / NULLIF(iq.valuetrade, 0), 2) != '0'
	),
	ranked_importmarginratio AS
	(SELECT
	 	countryname,
	 	productname,
	 	thousanddollar_spent,
	 	tonnage_bought,
	 	importmarginratio,
	 	yeartrade,
	 	DENSE_RANK() OVER(ORDER BY importmarginratio DESC) AS rank_importmarginratio
	FROM 
	 	country_importmarginratio
	)


SELECT
	countryname,
	productname,
	thousanddollar_spent,
	tonnage_bought,
	importmarginratio,
	rank_importmarginratio,
	yeartrade
FROM ranked_importmarginratio
WHERE
	countryname IN ('United States of America', 'Germany', 'Italy', 'Japan', 'France', 'Belgium', 'Spain', 'Canada', 'United Kingdom of Great Britain and Northern Ireland', 'Netherlands')
ORDER BY rank_importmarginratio ASC;


-- RANK SUM
SELECT 
	ev.countryname AS countryname, 
	ev.productname AS productname, 
	SUM(ev.valuetrade) AS totaldollargenerated, 
	SUM(eq.valuetrade AS totaltonnagesold,
    ev.yeartrade AS yeartrade	
FROM 
	"Export Value" AS ev
INNER JOIN
	"Export Quantity" AS eq
ON
	ev.countryname = eq.countryname
	AND ev.productname = ev.productname
	AND ev.yeartrade = eq.yeartrade
WHERE
	ev.countryname IN ('Brazil', 'Viet Nam', 'Germany', 'Colombia', 'Switzerland', 'Italy', 'Indonesia', 'Belgium', 'United States of America
	', 'Guatemala')


-- TOP 10 countries from 'Import Value' element by STDDEV
SELECT
	countryname,
	ROUND(STDDEV(valuetrade), 2) AS stddev_valueimported,
	RANK() OVER(ORDER BY ROUND(STDDEV(valuetrade), 2) DESC) AS rank_stddev_valueimported
FROM "Import Value"
WHERE
	countryname IN ('United States of America', 'Germany', 'France', 'Japan', 'Italy', 'Canada', 'Belgium', 'United Kingdom of Great Britain and Northern Ireland', 'Spain', 'Netherlands')
	AND 
	valuetrade IS NOT NULL
GROUP BY countryname
ORDER BY rank_stddev_valueimported ASC;


-- TOP 10 countries from 'Import Quantity' element by STDDEV
SELECT
	countryname,
	ROUND(STDDEV(valuetrade), 2) AS stddev_quantityimported,
	RANK() OVER(ORDER BY ROUND(STDDEV(valuetrade), 2) DESC) AS rank_stddev_quantityimported
FROM "Import Quantity"
WHERE
	countryname IN ('United States of America', 'Germany', 'Italy', 'Japan', 'France', 'Belgium', 'Spain', 'Canada', 'United Kingdom of Great Britain and Northern Ireland', 'Netherlands')
	AND 
	valuetrade IS NOT NULL
GROUP BY countryname
ORDER BY rank_stddev_quantityimported ASC;


-- TOP 10 countries from 'Export Value' element by STDDEV
SELECT
	countryname,
	ROUND(STDDEV(valuetrade), 2) AS stddev_valueexported,
	RANK() OVER(ORDER BY ROUND(STDDEV(valuetrade), 2) DESC) AS rank_stddev_valueexported
FROM "Export Value"
WHERE
	countryname IN ('Brazil', 'Viet Nam', 'Germany', 'Colombia', 'Switzerland', 'Italy', 'Indonesia', 'Belgium', 'United States of America', 'Guatemala')
	AND 
	valuetrade IS NOT NULL
GROUP BY countryname
ORDER BY rank_stddev_valueexported ASC;


-- TOP 10 countries from 'Export Quantity' element by STDDEV
SELECT
	countryname,
	ROUND(STDDEV(valuetrade), 2) AS stddev_quantityexported,
	RANK() OVER(ORDER BY ROUND(STDDEV(valuetrade), 2) DESC) AS rank_stddev_quantityexported
FROM "Export Quantity"
WHERE
	countryname IN ('Viet Nam', 'Brazil', 'Colombia', 'Germany', 'Indonesia', 'Guatemala', 'Honduras', 'Peru', 'India', 'Ethiopia')
	AND 
	valuetrade IS NOT NULL
GROUP BY countryname
ORDER BY rank_stddev_quantityexported ASC;


-- Yearly growth in percentage with LAG for "Import Value"
WITH lag_operation AS (
	SELECT
		countryname,
		productname,
		valuetrade:: NUMERIC AS valuetrade,
		LAG(valuetrade, 1) 
			OVER(PARTITION BY countryname, productname ORDER BY yeartrade) 
			AS valuetrade_lag,
		yeartrade
	FROM
		"Import Value"
	WHERE
		countryname IN ('United States of America', 'Germany', 'France', 'Japan', 'Italy', 'Canada', 'Belgium', 'United Kingdom of Great Britain and Northern Ireland', 'Spain', 'Netherlands')
	)
		

SELECT
	countryname,
	productname,
	valuetrade AS dollartrade,
	valuetrade_lag AS dollartrade_lag,
	ROUND 
		((valuetrade - valuetrade_lag)
		/NULLIF (valuetrade_lag, 0)*100, 2) AS dollarspent_yearlygrowth,
	yeartrade
FROM	
	lag_operation;


-- TOP 10 countries from 'Export Quantity' element by STDDEV
SELECT
	countryname,
	ROUND(STDDEV(valuetrade), 2) AS stddev_quantityexported,
	RANK() OVER(ORDER BY ROUND(STDDEV(valuetrade), 2) DESC) AS rank_stddev_quantityexported
FROM "Export Quantity"
WHERE
	countryname IN ('Viet Nam', 'Brazil', 'Colombia', 'Germany', 'Indonesia', 'Guatemala', 'Honduras', 'Peru', 'India', 'Ethiopia')
	AND 
	valuetrade IS NOT NULL
GROUP BY countryname
ORDER BY rank_stddev_quantityexported ASC;



-- Yearly growth in percentage with LAG for "Import Quantity"
WITH lag_operation AS (
	SELECT
		countryname,
		productname,
		valuetrade:: NUMERIC AS valuetrade,
		LAG(valuetrade, 1) 
			OVER(PARTITION BY countryname, productname ORDER BY yeartrade) 
			AS valuetrade_lag,
		yeartrade
	FROM
		"Import Quantity"
	WHERE
		countryname IN ('United States of America', 'Germany', 'Italy', 'Japan', 'France', 'Belgium', 'Spain', 'Canada', 'United Kingdom of Great Britain and Northern Ireland', 'Netherlands')
	)
		

SELECT
	countryname,
	productname,
	valuetrade AS tonnagebought,
	valuetrade_lag AS tonnagebought_lag,
	ROUND 
		((valuetrade - valuetrade_lag)
		/NULLIF (valuetrade_lag, 0)*100, 2) AS tonnagebought_yearlygrowth,
	yeartrade
FROM	
	lag_operation;


-- Yearly growth in percentage with LAG for "Export Value"
WITH lag_operation AS (
	SELECT
		countryname,
		productname,
		valuetrade:: NUMERIC AS valuetrade,
		LAG(valuetrade, 1) 
			OVER(PARTITION BY countryname, productname ORDER BY yeartrade) 
			AS valuetrade_lag,
		yeartrade
	FROM
		"Export Value"
	WHERE
		countryname IN ('Brazil', 'Viet Nam', 'Germany', 'Colombia', 'Switzerland', 'Italy', 'Indonesia', 'Belgium', 'United States of America', 'Guatemala')
		)
		

SELECT
	countryname,
	productname,
	valuetrade AS dollargained,
	valuetrade_lag AS dollargained_lag,
	ROUND 
		((valuetrade - valuetrade_lag)
		/NULLIF (valuetrade_lag, 0)*100, 2) AS dollargained_yearlygrowth,
	yeartrade
FROM	
	lag_operation;


-- Yearly growth in percentage with LAG for "Export Quantity"
WITH lag_operation AS (
	SELECT
		countryname,
		productname,
		valuetrade:: NUMERIC AS valuetrade,
		LAG(valuetrade, 1) 
			OVER(PARTITION BY countryname, productname ORDER BY yeartrade) 
			AS valuetrade_lag,
		yeartrade
	FROM
		"Export Quantity"
	WHERE
		countryname IN ('Viet Nam', 'Brazil', 'Colombia', 'Germany', 'Indonesia', 'Guatemala', 'Honduras', 'Peru', 'India', 'Ethiopia')
	)
		

SELECT
	countryname,
	productname,
	valuetrade AS tonnagesold,
	valuetrade_lag AS tonnagesold_lag,
	ROUND 
		((valuetrade - valuetrade_lag)
		/NULLIF (valuetrade_lag, 0)*100, 2) AS tonnagesold_yearlygrowth,
	yeartrade
FROM	
	lag_operation;









