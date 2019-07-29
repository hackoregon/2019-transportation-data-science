#! /usr/bin/env Rscript

## Environment variables
PGHOST <- "localhost"
PGPORT <- 5439
PGUSER <- "transportation2019"
PGPASSWORD <- "sit-down-c0mic"
PGDATABASE <- "transit_operations_analytics_data"
WORK_PATH <- "/home/container-csvs/"

## Functions
### PostgreSQL
connect_toad_database <- function(tries = 5, wait = 5) {
  for (attempt in 1:tries) {
    db_ready <- DBI::dbCanConnect(
      RPostgres::Postgres(),
      host = PGHOST,
      port = PGPORT,
      user = PGUSER,
      password = PGPASSWORD,
      dbname = PGDATABASE
    )

    if (db_ready) { # return connection if it's ready
      return(DBI::dbConnect(
        RPostgres::Postgres(),
        host = PGHOST,
        port = PGPORT,
        user = PGUSER,
        password = PGPASSWORD,
        dbname = PGDATABASE
      ))
    }

    # database isn't ready - sleep and retry
    Sys.sleep(wait)
  }

  # couldn't connect - throw an error
  stop(paste("Database is not ready - reason:", attr(db_ready, "reason")))

}

make_partition_sql <- function(table_name, start_year, start_month) {
  start_date <- lubridate::ymd(sprintf("%4d-%02d-01", start_year, start_month))
  end_date <- start_date + months(1)
  month_code <- sprintf("%4d_%02d", start_year, start_month)
  sql <- paste0(
    "CREATE TABLE ", table_name, "_", month_code,
    " PARTITION OF ", table_name,
    " FOR VALUES FROM ('", start_date, "') TO ('", end_date, "');"
  )
  return(sql)
}

### data.table file input
load_csv_file <- function(file_type, month_code) {
  filename <- paste0(
    WORK_PATH, "/", file_type, "_", month_code, ".csv")
  return(data.table::fread(file = filename, showProgress = FALSE))
}

date_convert <- function(trimet_coded_date) {
  as.POSIXct(strptime(trimet_coded_date, format = "%d%b%Y:%H:%M:%S", tz = "PST8PDT"))
}

read_trips_history <- function(month_code) {
  trips_history <- load_csv_file(file_type = "raw_tripsh", month_code)
  invisible(gc(reset = TRUE))
  trips_history <- trips_history[
    NOM_END_TIME > 0 &
    !is.na(ACT_END_TIME) &
    !is.na(LINE_ID) &
    !is.na(PATTERN_DIRECTION) &
    LINE_ID <= 291 &
    LINE_ID > 0 &
    PATTERN_DIRECTION != ""
  ]
  invisible(gc(reset = TRUE))
  trips_history <- trips_history[, `:=`(OPD_DATE = date_convert(OPD_DATE))]
  invisible(gc(reset = TRUE))
  trips_history <- trips_history[, `:=`(
    NOM_DEP_TIME = NOM_DEP_TIME + OPD_DATE,
    ACT_DEP_TIME = ACT_DEP_TIME + OPD_DATE,
    NOM_END_TIME = NOM_END_TIME + OPD_DATE,
    ACT_END_TIME = ACT_END_TIME + OPD_DATE
  )]
  invisible(gc(reset = TRUE))
  names(trips_history) <- tolower(names(trips_history))
  return(trips_history)
}

read_bus_all_stops <- function(month_code, trips_history) {
  bus_all_stops <- load_csv_file(file_type = "raw_veh_stoph", month_code)
  invisible(gc(reset = TRUE))
  bus_all_stops <- bus_all_stops[
    EVENT_NO_TRIP > 0 &
    !is.na(NOM_ARR_TIME) &
    !is.na(GPS_LONGITUDE) &
    !is.na(GPS_LATITUDE)
  ]
  invisible(gc(reset = TRUE))
  bus_all_stops <- bus_all_stops[, `:=`(OPD_DATE = date_convert(OPD_DATE))]
  invisible(gc(reset = TRUE))
  bus_all_stops <- bus_all_stops[, `:=`(
    NOM_DEP_TIME = NOM_DEP_TIME + OPD_DATE,
    ACT_DEP_TIME = ACT_DEP_TIME + OPD_DATE,
    NOM_ARR_TIME = NOM_ARR_TIME + OPD_DATE,
    ACT_ARR_TIME = ACT_ARR_TIME + OPD_DATE
  )]
  invisible(gc(reset = TRUE))
  names(bus_all_stops) <- tolower(names(bus_all_stops))
  bus_all_stops <- merge(
    bus_all_stops,
    trips_history[, .(event_no, line_id, pattern_direction)],
    by.x = "event_no_trip", by.y = "event_no"
  )
  invisible(gc(reset = TRUE))
  bus_all_stops <- bus_all_stops[
    , `:=`(
      year = year(act_arr_time),
      month = month(act_arr_time),
      day = mday(act_arr_time),
      day_of_week = wday(act_arr_time),
      arrive_quarter_hour = qhod(act_arr_time)
    )
  ]
  return(bus_all_stops)
}

read_passenger_stops <- function(month_code) {
  passenger_stops <- load_csv_file(file_type = "raw_stop_event", month_code)
  invisible(gc(reset = TRUE))
  passenger_stops <- passenger_stops[
    ROUTE_NUMBER > 0 &
    ROUTE_NUMBER <= 291 &
    TRIP_NUMBER > 0 &
    LOCATION_ID > 0 &
    !is.na(X_COORDINATE) &
    !is.na(Y_COORDINATE) &
    X_COORDINATE > 0 &
    Y_COORDINATE > 0
  ]
  invisible(gc(reset = TRUE))
  passenger_stops <- passenger_stops[, `:=`(SERVICE_DATE = date_convert(SERVICE_DATE))]
  invisible(gc(reset = TRUE))
  passenger_stops <- passenger_stops[, `:=`(
    LEAVE_TIME = LEAVE_TIME + SERVICE_DATE,
    STOP_TIME = STOP_TIME + SERVICE_DATE,
    ARRIVE_TIME = ARRIVE_TIME + SERVICE_DATE
  )]
  invisible(gc(reset = TRUE))
  names(passenger_stops) <- tolower(names(passenger_stops))
  return(passenger_stops)
}

qhod <- function(tstamp) {
  0.25 * trunc(4 * hour(tstamp) + minute(tstamp) / 15)
}

# month outline
## read trips_history
## save to database
## read vehicle stop history
## join with trips history
## save to database
## compute disturbance stops
## save to database
## read stop event
## save to database


## Test database
conn <- connect_toad_database()
print(DBI::dbListTables(conn))
print(DBI::dbListFields(conn, "trips_history"))
print(DBI::dbListFields(conn, "passenger_stops"))
print(DBI::dbListFields(conn, "bus_all_stops"))
print(DBI::dbListFields(conn, "disturbance_stops"))

## Test readers
trips_history <- read_trips_history("2018_09")
print(trips_history)
print(partition_sql <- make_partition_sql(
  "trips_history", start_year = 2018, start_month = 9
))
DBI::dbExecute(conn, partition_sql)
DBI::dbWriteTable(conn, "trips_history", trips_history, append = TRUE)

bus_all_stops <- read_bus_all_stops("2018_09", trips_history)
print(bus_all_stops)
print(partition_sql <- make_partition_sql(
  "bus_all_stops", start_year = 2018, start_month = 9
))
DBI::dbExecute(conn, partition_sql)
DBI::dbWriteTable(conn, "bus_all_stops", bus_all_stops, append = TRUE)

stop()

passenger_stops <- read_passenger_stops("2018_09")
print(passenger_stops)
