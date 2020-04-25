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
         -target_displayed_duration_error_trial)

# Load reading data
vw_rs <- read_xlsx("data/Participant Data Study 2.xlsx", sheet = "Matched") %>%
  clean_names() %>%
  filter(str_starts(code_1, '\\d'))

deaf_rs <- vw_rs %>%
  select(code_1, vw_rs_6) %>%
  rename(subject = code_1,
         vw_rs = vw_rs_6) %>%
  mutate_all(as.numeric)

hearing_rs <- vw_rs %>%
  select(code_10, vw_rs_15) %>%
  rename(subject = code_10,
         vw_rs = vw_rs_15) %>%
  mutate_all(as.numeric)

vw_rs <- bind_rows(deaf_rs, hearing_rs)


# Combine main data and reading score data
df <- df %>%
  left_join(vw_rs, by = 'subject')

# Save to new CSV file
write_csv(df, "data/cleaned_dataset.csv")
