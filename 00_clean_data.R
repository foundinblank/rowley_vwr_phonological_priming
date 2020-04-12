## Create clean (but full) dataset from raw Excel file 

library(tidyverse)
library(janitor)
library(readxl)

# Load data and clean up column names
df <- read_xls("data/AllMatchedMLDTdata.xls", sheet = "Main Data") %>%
  clean_names()

