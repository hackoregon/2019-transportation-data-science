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
  start_date <- lubridate::ymd(sprintf("%4d-%2d-01", start_year, start_month))
  end_date <- start_date %m+% months(1)
  sql <- paste0(
    "CREATE TABLE ", table_name, "_y", start_year, "m", start_month,
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

read_tripsh <- function(month_code) {
  tripsh <- load_csv_file(file_type = "raw_tripsh", month_code)
  invisible(gc(reset = TRUE))
  tripsh <- tripsh[
    NOM_END_TIME > 0 &
    !is.na(ACT_END_TIME) &
    !is.na(LINE_ID) &
    !is.na(PATTERN_DIRECTION) &
    LINE_ID <= 291 &
    LINE_ID > 0 &
    PATTERN_DIRECTION != ""
  ]
  invisible(gc(reset = TRUE))
  tripsh <- tripsh[, `:=`(OPD_DATE = date_convert(OPD_DATE))]
  invisible(gc(reset = TRUE))
  tripsh <- tripsh[, `:=`(
    NOM_DEP_TIME = NOM_DEP_TIME + OPD_DATE,
    ACT_DEP_TIME = ACT_DEP_TIME + OPD_DATE,
    NOM_END_TIME = NOM_END_TIME + OPD_DATE,
    ACT_END_TIME = ACT_END_TIME + OPD_DATE
  )]
  invisible(gc(reset = TRUE))
  return(tripsh)
}

read_veh_stoph <- function(month_code) {
  veh_stoph <- load_csv_file(file_type = "raw_veh_stoph", month_code)
  invisible(gc(reset = TRUE))
  veh_stoph <- veh_stoph[
    EVENT_NO_TRIP > 0 &
    !is.na(NOM_ARR_TIME) &
    !is.na(GPS_LONGITUDE) &
    !is.na(GPS_LATITUDE)
  ]
  invisible(gc(reset = TRUE))
  veh_stoph <- veh_stoph[, `:=`(OPD_DATE = date_convert(OPD_DATE))]
  invisible(gc(reset = TRUE))
  veh_stoph <- veh_stoph[, `:=`(
    NOM_DEP_TIME = NOM_DEP_TIME + OPD_DATE,
    ACT_DEP_TIME = ACT_DEP_TIME + OPD_DATE,
    NOM_ARR_TIME = NOM_ARR_TIME + OPD_DATE,
    ACT_ARR_TIME = ACT_ARR_TIME + OPD_DATE
  )]
  invisible(gc(reset = TRUE))
  return(veh_stoph)
}

read_stop_event <- function(month_code) {
  stop_event <- load_csv_file(file_type = "raw_stop_event", month_code)
  invisible(gc(reset = TRUE))
  stop_event <- stop_event[
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
  stop_event <- stop_event[, `:=`(SERVICE_DATE = date_convert(SERVICE_DATE))]
  invisible(gc(reset = TRUE))
  stop_event <- stop_event[, `:=`(
    LEAVE_TIME = LEAVE_TIME + SERVICE_DATE,
    STOP_TIME = STOP_TIME + SERVICE_DATE,
    ARRIVE_TIME = ARRIVE_TIME + SERVICE_DATE
  )]
  invisible(gc(reset = TRUE))
  return(stop_event)
}

qhod <- function(tstamp) {
  0.25 * trunc(4 * hour(tstamp) + minute(tstamp) / 15)
}

## Test database
conn <- connect_toad_database()
DBI::dbListTables(conn)
DBI::dbListFields(conn, "trips_history")
DBI::dbListFields(conn, "passenger_stops")
DBI::dbListFields(conn, "bus_all_stops")
DBI::dbListFields(conn, "disturbance_stops")

## Test readers
tripsh <- read_tripsh("2018_09")
print(tripsh)
veh_stoph <- read_veh_stoph("2018_09")
print(veh_stoph)
stop_event <- read_stop_event("2018_09")
print(stop_event)

