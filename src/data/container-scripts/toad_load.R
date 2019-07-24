#! /usr/bin/env Rscript

## Functions
#' @title Connect to the TOAD database
#' @name connect_toad_database
#'
#' @param host character the host name
#' @param port integer the port
#' @param user character the user name to connect as
#' @param password character the password
#' @param dbname character the database name
#' @param tries integer number of time to attempt connecting (default 5)
#' @param wait numeric number of seconds to wait between tries (default 5)
#'
#' @return a `connection` object if successful. Otherwise, aborts with the
#' failure message from `dbCanConnect`
#'
#' @examples
#' \dontrun{
#' conn <- connect_toad_database(
#'   "localhost",
#'   5439
#'   "transportation2019",
#'   "sit-down-c0mic",
#'   "transit_operations_analytics_database"
#' )
#' DBI::dbListTables(conn)
#' DBI::dbListFields(conn, "bus_all_stops")
#' }
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
