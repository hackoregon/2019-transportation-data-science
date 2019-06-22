SELECT COUNT(*) FROM (
	SELECT "disturbance_stops"."id" AS Col1 
	FROM "disturbance_stops" 
	WHERE (
		EXTRACT('month' FROM "disturbance_stops"."opd_date") >= 9 
		AND EXTRACT('month' FROM "disturbance_stops"."opd_date") <= 9 
		AND "disturbance_stops"."line_id" IN (10) 
		AND "disturbance_stops"."pattern_direction" = 'I' 
		AND "disturbance_stops"."start_quarter_hour" >= 6.0 
		AND "disturbance_stops"."end_quarter_hour" <= 7.0
	)
) AS harry_the_subquery;
