#! /usr/bin/env Rscript

## Functions
connect_toad_database <- function(
  host, port, user, password, dbname, tries = 5, wait = 5) {
  for (attempt in 1:tries) {
    db_ready <- DBI::dbCanConnect(
      RPostgres::Postgres(),
      host = host,
      port = port,
      user = user,
      password = password,
      dbname = dbname
    )

    if (db_ready) { # return connection if it's ready
      return(DBI::dbConnect(
        RPostgres::Postgres(),
        host = host,
        port = port,
        user = user,
        password = password,
        dbname = dbname
      ))
    }

    # database isn't ready - sleep and retry
    Sys.sleep(wait)
  }

  # couldn't connect - throw an error
  stop(paste("Database is not ready - reason:", attr(db_ready, "reason")))

}

load_csv_file <- function(work_path, file_type, month_code) {
  filename <- paste0(
    work_path, "/", file_type, "_", month_code, ".csv")
  return(data.table::fread(file = filename, showProgress = FALSE))
}

read_tripsh <- function(work_path, month_code) {
  tripsh <- load_csv_file(work_path, file_type = "raw_tripsh", month_code)
  invisible(gc(reset = TRUE))
  tripsh <- tripsh[NOM_END_TIME > 0 & !is.na(ACT_END_TIME) & PATTERN_DIRECTION != ""]
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

read_veh_stoph <- function(work_path, month_code) {
  veh_stoph <- load_csv_file(work_path, file_type = "raw_veh_stoph", month_code)
  invisible(gc(reset = TRUE))
  veh_stoph <- veh_stoph[EVENT_NO_TRIP > 0 & !is.na(NOM_ARR_TIME)]
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

date_convert <- function(trimet_coded_date) {
  lubridate::fast_strptime(
    trimet_coded_date, format = "%d%b%Y:%H:%M:%S", tz = "PST8PDT", lt = FALSE
  )
}

seconds_of_day_convert <- function(date, seconds_of_day) {
  date + seconds_of_day
}

qhod <- function(tstamp) {
  0.25 * trunc(4 * hour(tstamp) + minute(tstamp) / 15)
}
