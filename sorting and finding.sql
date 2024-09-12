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