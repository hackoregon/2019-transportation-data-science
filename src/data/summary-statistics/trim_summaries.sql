DELETE FROM bus_am_rush_summary
WHERE p95_seconds_late > 1800
OR samples < 30;

DELETE FROM bus_pm_rush_summary
WHERE p95_seconds_late > 1800
OR samples < 30;

DELETE FROM bus_by_stop_summary
WHERE p95_seconds_late > 1800
OR samples < 30;

DELETE FROM rail_am_rush_summary
WHERE p95_seconds_late > 1800
OR samples < 30;

DELETE FROM rail_pm_rush_summary
WHERE p95_seconds_late > 1800
OR samples < 30;

DELETE FROM rail_by_stop_summary
WHERE p95_seconds_late > 1800
OR samples < 30;
