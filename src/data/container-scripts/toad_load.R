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
  return(data.table::fread(filename))
}
