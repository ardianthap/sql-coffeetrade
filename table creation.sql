-- create unique country trade table with its respective country name, elements, and the unit measure.

CREATE TABLE countrytrade (
	trade_id SERIAL PRIMARY KEY,
	country_name VARCHAR(100),
	element_name VARCHAR(20),
	unit_measure VARCHAR(10)
);








