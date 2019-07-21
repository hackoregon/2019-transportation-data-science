#! /usr/bin/env Rscript

## Libraries
library(data.table)

## define function to transform a file
transform_file <- function(input_file, output_file) {

  ## Load stop events CSV
  ## Note: because this has to run in an 8GB laptop, we garbage-collect
  ##  frequently and avoid chaining / pipes.
  passenger_stop_events <- data.table::fread(input_file)
  invisible(gc())
  passenger_stop_events <- passenger_stop_events[
    VEHICLE_NUMBER > 0 & ROUTE_NUMBER > 0 & ROUTE_NUMBER <= 291 &
      TRIP_NUMBER > 0 & TRAIN > 0 & LOCATION_ID > 0
    ]
  invisible(gc())

  ## Standardize stop coordinates: There are some points with bogus coordinates,
  ## and there's quite a bit of variation on where a bus will actually stop.
  ## So we replace the coordinates with the medians over the whole month.

  ### make the stop location table
  stop_locations <- passenger_stop_events[, .(
    X_COORDINATE_2913 = median(X_COORDINATE),
    Y_COORDINATE_2913 = median(Y_COORDINATE)),
    by = "LOCATION_ID"
  ]
  invisible(gc())

  ### tag the stop event table
  passenger_stop_events <- merge(
    passenger_stop_events, stop_locations, by = "LOCATION_ID"
  )
  invisible(gc())
  passenger_stop_events <- passenger_stop_events[, !(X_COORDINATE:Y_COORDINATE)]
  invisible(gc())

  ## Convert date to ISO standard
  passenger_stop_events <- passenger_stop_events[
    , SERVICE_DATE := as.Date(lubridate::fast_strptime(
      SERVICE_DATE, format = "%d%b%Y:%H:%M:%S", tz = "PST8PDT", lt = FALSE
    ))
  ]
  invisible(gc())

  ## Compute lagged columns
  ### sort the stop events table by trips
  data.table::setkeyv(passenger_stop_events, c(
    "SERVICE_DATE", "VEHICLE_NUMBER", "TRAIN", "ROUTE_NUMBER", "DIRECTION",
    "SERVICE_KEY", "TRIP_NUMBER", "ARRIVE_TIME", "LEAVE_TIME"), verbose = TRUE)
  invisible(gc())
  passenger_stop_events <- passenger_stop_events[
    , `:=`(
      FROM_LOCATION_ID = shift(LOCATION_ID),
      FROM_LEAVE_TIME = shift(LEAVE_TIME),
      FROM_STOP_TIME = shift(STOP_TIME),
      FROM_ARRIVE_TIME = shift(ARRIVE_TIME),
      FROM_ONS = shift(ONS),
      FROM_OFFS = shift(OFFS),
      FROM_ESTIMATED_LOAD = shift(ESTIMATED_LOAD),
      FROM_TRAIN_MILEAGE = shift(TRAIN_MILEAGE)
    ),
    by = c("SERVICE_DATE", "VEHICLE_NUMBER", "TRAIN", "ROUTE_NUMBER", "DIRECTION",
           "SERVICE_KEY", "TRIP_NUMBER")
    ]
  invisible(gc())

  ## Save output CSV file
  data.table::fwrite(passenger_stop_events, file = output_file)
  invisible(gc())

}

## Create to-do list
todo <- tibble::tribble(
  ~input_file, ~output_file,
  "/csvs/raw_stop_event_2017_09.csv", "/csvs/passenger_stop_events_2017_09.csv",
  "/csvs/raw_stop_event_2017_10.csv", "/csvs/passenger_stop_events_2017_10.csv",
  "/csvs/raw_stop_event_2017_11.csv", "/csvs/passenger_stop_events_2017_11.csv",
  "/csvs/raw_stop_event_2018_09.csv", "/csvs/passenger_stop_events_2018_09.csv",
  "/csvs/raw_stop_event_2018_10.csv", "/csvs/passenger_stop_events_2018_10.csv",
  "/csvs/raw_stop_event_2018_11.csv", "/csvs/passenger_stop_events_2018_11.csv"
)

## Run the conversions
for (month in 1:nrow(todo)) {
  transform_file(
    input_file = todo$input_file[month], output_file = todo$output_file[month]
  )

  ## visibly collect garbage
  gc(verbose = TRUE)
}
