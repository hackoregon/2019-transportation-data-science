select * from "trimet_stop_event 1-31OCT2017" 
	inner join "init_veh_stoph 1-31OCT2017" on 
		("trimet_stop_event 1-31OCT2017".SERVICE_DATE = "init_veh_stoph 1-31OCT2017".OPD_Date) and 
		("init_veh_stoph 1-31OCT2017".POINT_ID = "trimet_stop_event 1-31OCT2017".LOCATION_ID) and
		("init_veh_stoph 1-31OCT2017".NOM_ARR_TIME = "trimet_stop_event 1-31OCT2017".STOP_TIME) and
		("init_veh_stoph 1-31OCT2017".ACT_ARR_TIME = "trimet_stop_event 1-31OCT2017".ARRIVE_TIME) and
		(1*"init_veh_stoph 1-31OCT2017".VEHICLE_ID = 1*"trimet_stop_event 1-31OCT2017".VEHICLE_NUMBER)
	where "trimet_stop_event 1-31OCT2017".ROUTE_NUMBER in ("4", "10", "14") AND
		"init_veh_stoph 1-31OCT2017".NOM_ARR_TIME is not '' AND 
		"trimet_stop_event 1-31OCT2017".LOCATION_ID in ("3637", "3641", "3633", "2642", "7856") AND
		"trimet_stop_event 1-31OCT2017".SERVICE_KEY is "W" AND
		1*"trimet_stop_event 1-31OCT2017".ARRIVE_TIME between 18000 AND 43200