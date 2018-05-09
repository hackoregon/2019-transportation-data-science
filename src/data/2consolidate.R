if (!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

load_csv <- function(path) {
  read_csv(
    path,
    col_types = cols(
      PATTERN_DISTANCE = col_double(),
      SERVICE_DATE = col_datetime(format = "%d%b%Y:%H:%M:%S")
    )
  ) %>%
    filter(!is.na(SERVICE_KEY)) %>%
    mutate(
      STOP_HOURS = STOP_TIME / 3600.0,
      ARRIVE_HOURS = ARRIVE_TIME / 3600.0,
      LEAVE_HOURS = LEAVE_TIME / 3600.0
    )
}

## Stack the files
bind_rows(
  load_csv("../../data/raw/trimet_stop_event 1-30SEP2017.csv"),
  load_csv("../../data/raw/trimet_stop_event 1-31OCT2017.csv"),
  load_csv("../../data/raw/trimet_stop_event 1-30NOV2017.csv")
) %>%
  write_csv(
    path = "../../data/interim/trimet_stop_events.csv",
    na = ""
  )
