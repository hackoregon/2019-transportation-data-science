# function definitions

## load one of the trimet_stop_event CSV files
#' load_csv
#'
#' @param path path to a TriMet "trimet_stop_event" CSV file
#'
#' @return a tibble with the data from the file, with some added columns

load_csv <- function(path) {
  read_csv(
    path,
    col_types = cols(
      SERVICE_DATE = col_date(format = "%d%b%Y:%H:%M:%S"),
      PATTERN_DISTANCE = col_double()
    )
  )
}

## drop unusued columns
drop_unused_columns <- function(stop_events) {

  stop_events %>% select(
    -BADGE,
    -MAXIMUM_SPEED
    -TRAIN_MILEAGE
    -PATTERN_DISTANCE
    -LOCATION_DISTANCE
    -X_COORDINATE
    -Y_COORDINATE
    -DATA_SOURCE
    -SCHEDULE_STATUS
  )
}

## filter unwanted rows
filter_unwanted_rows <- function(stop_events) {
  stop_events %>% filter(
    LOCATION_ID > 0,
    ROUTE_NUMBER > 0,
    ROUTE_NUMBER <= 291,
    SERVICE_KEY == "W" |
      SERVICE_KEY == "S" |
      SERVICE_KEY == "U" |
      SERVICE_KEY == "X"
  )
}

## add conventiences for analysis
add_conveniences <- function(stop_events) {

  temp <- stop_events

  # convert the service data to a character string
  temp$SERVICE_DATE <- as.character(temp$SERVICE_DATE)

  temp <- temp %>% mutate(
    WEEKDAY = lubridate::wday(SERVICE_DATE),
    TRIP_KEY = paste(
      SERVICE_DATE,
      VEHICLE_NUMBER,
      ROUTE_NUMBER,
      DIRECTION,
      TRIP_NUMBER,
      sep = "_"
    )
  )
  return(temp)
}

#' Group by trips
#'
#' @param stop_events a "stop events" tibble
#'
#' @return the tibble grouped by trips
group_by_trips <- function(stop_events) {

  # sort first to get each trip in chronological order
  stop_events %>% arrange(
    VEHICLE_NUMBER,
    SERVICE_DATE,
    ARRIVE_TIME
  ) %>%
    group_by(TRIP_KEY)
}

#' Compute lagged columns
#' Omce we have the data grouped by trips, we want to add a column for the previous location ID and the time from when the vehicle left there to when it arrived here
#'
#' @param stop_events a stop_events tibble
#'
#' @return the tibble with the new columns
#'
compute_lagged_columns <- function(stop_events) {
  stop_events %>%
    mutate(
      SECONDS_LATE = ARRIVE_TIME - STOP_TIME,
      FROM_LOCATION = lag(LOCATION_ID),
      LEFT_THERE = lag(LEAVE_TIME),
      TRAVEL_SECONDS = ARRIVE_TIME - LEFT_THERE
   ) %>%
   filter(
     !is.na(TRAVEL_SECONDS),
     TRAVEL_SECONDS > 0
   )
}
