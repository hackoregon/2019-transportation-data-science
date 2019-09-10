library(tidytransit)
trimet_gtfs <- read_gtfs("~/Downloads/Civic/gtfs.zip", local = TRUE, geometry = TRUE)
library(data.table)
data.table::fwrite(trimet_gtfs[["stops"]], file = "/Raw/trimet_gtfs_stops.csv")
library(readr)
trimet_gtfs_stops <- read_csv(
  "/Raw/trimet_gtfs_stops.csv", col_types = cols(
    .default = col_character(),
  stop_code = col_integer()
 )
)
View(trimet_gtfs_stops)
