if (!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)
library(magrittr)

trimet_stop_event <- read_csv(
  "../../data/interim/trimet_stop_event.csv",
  col_types = cols(
    pattern_distance = col_double(),
    service_date = col_datetime(format = "%d%b%Y:%H:%M:%S")
  )
) %>% filter(!is.na(service_key))
gc()

trimet_stop_event %<>%
  mutate(
    stop_hours = stop_time / 3600.0,
    arrive_hours = arrive_time / 3600.0,
    leave_hours = leave_time / 3600.0
  )
gc()

trimet_stop_event %<>%
  arrange(
    route_number,
    service_date,
    arrive_time
  )
gc()

trimet_stop_event %>%
  write_csv(path = "../../data/interim/tidy_trimet_stop_event.csv")
