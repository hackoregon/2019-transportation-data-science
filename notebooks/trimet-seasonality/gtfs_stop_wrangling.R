library(tidytransit)
library(data.table)
library(dplyr)
trimet_gtfs <- read_gtfs("https://developer.trimet.org/schedule/gtfs.zip", local = FALSE, geometry = TRUE)
work <- trimet_gtfs[["stops"]] %>% dplyr::filter(!is.na(stop_code))
data.table::fwrite(work, file = "/Raw/trimet_gtfs_stops.csv")
library(readr)
trimet_gtfs_stops <- read_csv(
  "/Raw/trimet_gtfs_stops.csv", col_types = cols(
    .default = col_character(),
  stop_code = col_integer()
 )
)
View(trimet_gtfs_stops)
