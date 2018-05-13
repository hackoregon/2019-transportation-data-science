# function definitions

## load a "trimet_stop_event" CSV file
#' load_csv
#'
#' @param path path to a TriMet "trimet_stop_event" CSV file
#'
#' @return a tibble with the data from the file
load_csv <- function(path) {
  temp <- read_csv(
    path,
    col_types = cols(
      SERVICE_DATE = col_date(format = "%d%b%Y:%H:%M:%S"),
      VEHICLE_NUMBER = col_integer(),
      MAXIMUM_SPEED = col_skip(),
      PATTERN_DISTANCE = col_skip(),
      LOCATION_DISTANCE = col_skip(),
      X_COORDINATE = col_skip(),
      Y_COORDINATE = col_skip(),
      DATA_SOURCE = col_skip(),
      SCHEDULE_STATUS = col_skip()
    )
  )
  temp$SERVICE_DATE <- as.character(temp$SERVICE_DATE)
  return(temp)
}

#' filter_unwanted_rows
#'
#' @param stop_events a stop_events tibble
#'
#' @return the tibble minus unwanted rows
filter_unwanted_rows <- function(stop_events) {
  temp <- stop_events %>% filter(
    LOCATION_ID > 0,
    ROUTE_NUMBER > 0,
    ROUTE_NUMBER <= 291,
    SERVICE_KEY == "W" |
      SERVICE_KEY == "S" |
      SERVICE_KEY == "U" |
      SERVICE_KEY == "X"
  )
  return(temp)
}

#' group_by_trips
#'
#' @param stop_events a "stop events" tibble
#'
#' @return the tibble grouped by trips
group_by_trips <- function(stop_events) {

  # sort first to get each trip in chronological order
  temp <- stop_events %>% arrange(
    VEHICLE_NUMBER,
    SERVICE_DATE,
    LEAVE_TIME) %>%
  group_by(
    SERVICE_DATE,
    VEHICLE_NUMBER,
    TRAIN,
    BADGE,
    ROUTE_NUMBER,
    DIRECTION,
    TRIP_NUMBER
  )
  return(temp)
}

#' compute_lagged_columns
#' Once we have the data grouped by trips, we add a column for the
#' previous location ID and the time the vehicle left there.
#' Then we compute the travel time.
#'
#' @param stop_events a stop_events tibble
#'
#' @return the tibble with the new columns
#'
compute_lagged_columns <- function(stop_events) {
  temp <- stop_events %>% mutate(
    SECONDS_LATE = ARRIVE_TIME - STOP_TIME,
    FROM_LOCATION = lag(LOCATION_ID),
    MILEAGE_THERE = lag(TRAIN_MILEAGE),
    LEFT_THERE = lag(LEAVE_TIME),
    TRAVEL_MILES = TRAIN_MILEAGE - MILEAGE_THERE,
    TRAVEL_SECONDS = ARRIVE_TIME - LEFT_THERE
   ) %>%
 filter(
   !is.na(TRAVEL_SECONDS),
   TRAVEL_SECONDS > 0
 )
  return(temp)
}

#' select_output_columns
#'
#' @param stop_events a stop_events tibble
#'
#' @return the selected columns
select_output_columns <- function(stop_events) {
  temp <- stop_events %>% select(
    SERVICE_DATE,
    VEHICLE_NUMBER,
    TRAIN,
    BADGE,
    ROUTE_NUMBER,
    DIRECTION,
    TRIP_NUMBER,
    SERVICE_KEY,
    STOP_TIME,
    ARRIVE_TIME,
    SECONDS_LATE,
    LEAVE_TIME,
    DWELL,
    LOCATION_ID,
    DOOR,
    LIFT,
    ONS,
    OFFS,
    ESTIMATED_LOAD,
    FROM_LOCATION,
    MILEAGE_THERE,
    LEFT_THERE,
    TRAVEL_MILES,
    TRAVEL_SECONDS
  ) %>%
  ungroup()
  return(temp)
}

## define the month table
month_table <- tibble::tribble(
  ~table_prefix, ~input_file,
  "m2017_09", "trimet_stop_event 1-30SEP2017.csv",
  "m2017_10", "trimet_stop_event 1-31OCT2017.csv",
  "m2017_11", "trimet_stop_event 1-30NOV2017.csv"
)
