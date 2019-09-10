source('~/Projects/2019-transportation-data-science/notebooks/trimet-seasonality/gtfs_stop_wrangling.R')
library(dplyr)
trimet_gtfs_stops %>% filter(is.na(stop_code))
trimet_gtfs_stops %>% filter(is.na(stop_code))
trimet_gtfs_stops %>% filter(is.na(stop_desc))
work <- trimet_gtfs[["stops"]] %>% dplyr::filter(!is,na(stop_code))
work <- trimet_gtfs[["stops"]] %>% dplyr::filter(!is.na(stop_code))
View(work)
work %>% filter(as.numeric(stop_id) != stop_code)
source('~/Projects/2019-transportation-data-science/notebooks/trimet-seasonality/gtfs_stop_wrangling.R')
source('~/Projects/2019-transportation-data-science/notebooks/trimet-seasonality/gtfs_stop_wrangling.R')
library(readr)
bus_am_rush_summary <- read_csv("~/Downloads/Civic/bus_am_rush_summary.csv")
View(bus_am_rush_summary)
install.packages("sm", dependencies = TRUE)
sm::sm.density(bus_am_rush_summary$samples)
fivenum(bus_am_rush_summary$samples)
boxplot(bus_am_rush_summary$samples)$stats
library(dplyr)
bus_am_rush_summary %>% dplyr::filter(samples < 1269)
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
bus_am_rush_summary %>% bus_am_rush_summary %>% dplyr::filter(samples > 1300)
bus_am_rush_summary <- bus_am_rush_summary %>% dplyr::filter(samples > 1300)
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
bus_am_rush_summary <- bus_am_rush_summary %>% dplyr::filter(samples > 2000)
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
bus_am_rush_summary <- bus_am_rush_summary %>% dplyr::filter(p95_seconds_late < 3600)
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
bus_am_rush_summary <- read_csv("~/Downloads/Civic/bus_am_rush_summary.csv")
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
763.5/60
bus_am_rush_summary <- bus_am_rush_summary %>% dplyr::filter(p95_seconds_late < 3600)
boxplot(bus_am_rush_summary$p95_seconds_late)$stats
boxplot(bus_am_rush_summary$samples)$stats
savehistory("~/Projects/2019-transportation-data-science/notebooks/trimet-seasonality/outlier_removal.R")
