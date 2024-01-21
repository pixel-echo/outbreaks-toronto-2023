#### Preamble ####
# Purpose: Transform clean_data.csv to a usable csv file with the variables outbreak_type and institution_type
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####
library(tidyverse)

# read in data
data <- read_csv("inputs/clean_data/clean_data.csv")

# create a data frame with the variables outbreak_type and institution_type
data <- data |>
  select(outbreak_setting, type_of_outbreak) |>
  rename(outbreak_type = type_of_outbreak, institution_type = outbreak_setting)

# rename institution types to be more readable
data <- data |>
  mutate(
    institution_type = case_when(
      institution_type == "Shelter" ~ "Homeless Shelter",
      str_detect(institution_type, "Hospital") ~ substring(institution_type, 10),
      TRUE ~ institution_type
    )
  )

# create a csv file called outbreak_type.csv
write_csv(data, "outputs/data/outbreak_type.csv")