-- create unique country trade table with its respective country name, elements, and the unit measure.
CREATE TABLE countrytrade (
	trade_id SERIAL PRIMARY KEY,
	country_name VARCHAR(100),
	element_name VARCHAR(20),
	unit_measure VARCHAR(10)
);

-- create table for products table
CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(20)
);

-- create table for flags table
CREATE TABLE flags (
	flag_id VARCHAR(3) PRIMARY KEY,
	flag_description VARCHAR(55)
);

-- creating main table, as a single standing and main table
CREATE TABLE CoffeeTrade (
	trade_id SERIAL PRIMARY KEY,
	country_name VARCHAR(100),
	element_name VARCHAR(20),
	product_name VARCHAR(50),
	year_trade INT,
	unit_measure VARCHAR(10),
	value_trade INT,
	flag_id VARCHAR(3),
	flag_description VARCHAR(55)
);

-- checking the constraint existing in the table 'countrytrade'
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'countrytrade';

-- deleting the existing constraint (primary key) from countrytrade_id column
ALTER TABLE countrytrade
DROP CONSTRAINT countrytrade_pkey;

-- adding foreign key on the main table
ALTER TABLE coffeetrade
ADD CONSTRAINT flag_id
	FOREIGN KEY (flag_id) REFERENCES flags(flag_id);

-- creating backup table for coffee trade
SELECT * INTO coffeetradebackup
FROM coffeetrade;

-- create table for importer only by countries
CREATE TABLE importercountry (
	importerid SERIAL PRIMARY KEY,
	trade_id INT,
	country_name VARCHAR(100),
	element_Name VARCHAR(20),
	value_trade INT,
	unit_measure VARCHAR(10),
	product_name VARCHAR(50),
	year_trade INT
);

-- assigning foreign key to trade_id column
ALTER TABLE importercountry
ADD FOREIGN KEY (trade_id)
REFERENCES coffeetrade(trade_id)
ON DELETE SET NULL;


-- populate importercountry table by pulling data from coffeetrade table
INSERT INTO importercountry 
	(trade_id, 
	country_name, 
	element_name, 
	value_trade, 
	unit_measure,
	product_name 
	year_trade)
SELECT
	trade_id,
	country_name,
	element_name,
	value_trade,
	unit_measure,
	product_name,
	year_trade
FROM
	coffeetrade
WHERE
	element_name = 'Import Value' OR element_name = 'Import Quantity';

-- create table for exporter only by countries
CREATE TABLE exportercountry (
	exporterid SERIAL PRIMARY KEY,
	trade_id INT,
	country_name VARCHAR(100),
	element_Name VARCHAR(20),
	value_trade INT,
	unit_measure VARCHAR(10),
	product_name VARCHAR(50),
	year_trade INT
);

-- assigning foreign key to trade_id column
ALTER TABLE exportercountry
ADD FOREIGN KEY (trade_id)
REFERENCES coffeetrade(trade_id)
ON DELETE SET NULL;

-- populate exportercountry table by pulling data from coffeetrade table
INSERT INTO exportercountry 
	(trade_id, 
	country_name, 
	element_name, 
	value_trade, 
	unit_measure,
	product_name 
	year_trade)
SELECT
	trade_id,
	country_name,
	element_name,
	value_trade,
	unit_measure,
	product_name,
	year_trade
FROM
	coffeetrade
WHERE
	element_name = 'Export Value' OR element_name = 'Export Quantity';

-- renaming columns in coffeetrade table
ALTER TABLE coffeetrade
RENAME COLUMN trade_id TO tradeid;

ALTER TABLE coffeetrade
RENAME COLUMN country_name TO countryname;

ALTER TABLE coffeetrade
RENAME COLUMN element_name TO elementname;

ALTER TABLE coffeetrade
RENAME COLUMN product_name TO productname;

ALTER TABLE coffeetrade
RENAME COLUMN year_trade TO yeartrade;

ALTER TABLE coffeetrade
RENAME COLUMN unit_measure TO unitmeasure;

ALTER TABLE coffeetrade
RENAME COLUMN value_trade TO valuetrade;

ALTER TABLE coffeetrade
RENAME COLUMN flag_id TO flagid;

ALTER TABLE coffeetrade
RENAME COLUMN flag_description TO flagdescription;

-- create backup table
CREATE TABLE coffeetrade_copy (LIKE coffeetrade INCLUDING ALL);

-- populating backup table by pulling data from original table
INSERT INTO coffeetrade_copy
SELECT * FROM coffeetrade;

-- changing the data type for yeartrade
ALTER TABLE coffeetrade
ALTER COLUMN yeartrade
SET DATA TYPE DATE
USING TO_DATE(yeartrade::TEXT || '-12-31', 'YYYY-MM-DD');






