## Create clean dataset from raw Excel file 

library(tidyverse)
library(janitor)
library(readxl)

# Load data and clean up column names
df <- read_xls("data/AllMatchedMLDTdata.xls", sheet = "Main Data") %>%
  clean_names() %>%
  select(-experiment_name,
         -session,
         -clock_information,
         -display_refresh_rate,
         -experiment_version,
         -random_seed,
         -runtime_version,
         -runtime_version_expected,
         -session_time,
         -studio_version,
         -target_displayed_duration_error_trial,
         -exclude_too_fast_slow)

# Save to new CSV file
write_csv(df, "data/cleaned_dataset.csv")
