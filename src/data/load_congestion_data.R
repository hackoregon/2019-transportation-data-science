## load libraries
if (!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)
setwd("/d/Projects/transportation-congestion-analysis/src/data")
source("function_definitions.R")

## define the month table
month_table <- tribble(
  ~table_prefix, ~input_file,
  "m2017_09", "trimet_stop_event 1-30SEP2017.csv",
  "m2017_10", "trimet_stop_event 1-31OCT2017.csv",
  "m2017_11", "trimet_stop_event 1-30NOV2017.csv"
)

## loop over months
#for (i in 1:nrow(month_table)) {
for (i in 1) {

  gc(full = TRUE, verbose = TRUE)
  trimet_stop_events <- load_csv(
    paste("../../data/raw", month_table$input_file[i], sep = "/")
  )
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    drop_unused_columns()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    filter_unwanted_rows()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    add_conveniences()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    group_by_trips()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    compute_lagged_columns()
  gc(full = TRUE, verbose = TRUE)

  edge_data <- trimet_stop_events %>% select(
    SERVICE_DATE,
    ROUTE_NUMBER,
    DIRECTION,
    SERVICE_KEY,
    FROM_LOCATION,
    LOCATION_ID,
    WEEKDAY,
    ARRIVE_HOURS,
    SECONDS_LATE,
    TRAVEL_SECONDS,
    TRIP_KEY
  ) %>%
  ungroup()

  gc(full = TRUE, verbose = TRUE)
  colnames(edge_data) <- tolower(colnames(edge_data))
  write_csv(paste(
    "../data/interim",
    month_table$table_prefix[i],
    edge_data.csv,
    sep = "/"
  ))
}
