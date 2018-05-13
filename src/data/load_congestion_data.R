## load libraries
if (!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)
setwd("/d/Projects/transportation-congestion-analysis")
source("src/data/function_definitions.R")

## loop over months
# for (i in 1:nrow(month_table)) {
for (i in 1) {

  cat(paste(
    "\nLoading",
    month_table$input_file[i]
  ))
  gc(full = TRUE, verbose = TRUE)
  trimet_stop_events <- load_csv(
    paste("data/raw", month_table$input_file[i], sep = "/")
  )
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    drop_unused_columns()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    filter_unwanted_rows()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    group_by_trips()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    compute_lagged_columns()
  gc(full = TRUE, verbose = TRUE)

  trimet_stop_events <- trimet_stop_events %>%
    select_output_columns()
  gc(full = TRUE, verbose = TRUE)

  cat(paste(
    "\nSaving",
    month_table$table_prefix[i]
  ))
  colnames(trimet_stop_events) <- tolower(colnames(trimet_stop_events))
  trimet_stop_events %>% write_csv(path = paste(
    "data/interim",
    paste(
      month_table$table_prefix[i],
      "trimet_stop_events.csv",
      sep = "_"
    ),
    sep = "/"
  ))
  gc(full = TRUE, verbose = TRUE)
  rm(trimet_stop_events)
  gc(full = TRUE, verbose = TRUE)
}
