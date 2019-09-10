library(tidytransit)
trimet_gtfs <- read_gtfs("~/Downloads/Civic/gtfs.zip", local = TRUE, geometry = TRUE)
View(trimet_gtfs)
View(trimet_gtfs[["stops"]])
library(data.table)
data.table::fwrite(trimet_gtfs[["stops"]], file = "/Raw/trimet_gtfs_stops.csv")
load("/Raw/trimet_gtfs_stops.csv")
library(readr)
trimet_gtfs_stops <- read_csv("/Raw/trimet_gtfs_stops.csv",
col_types = cols(stop_code = col_character(),
stop_id = col_character()))
View(trimet_gtfs_stops)
savehistory("~/Projects/2019-transportation-data-science/notebooks/trimet-seasonality/gtfs_stop_wrangling.R")
