#### Preamble ####
# Purpose: Transform clean_data.csv to a usable csv file with columns
# that look at the type of illness and year of the outbreak 
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####
library(tidyverse)

# read the data
data <- read_csv("inputs/clean_data/clean_data.csv")

# create a data frame with the variables illness_type and year. 
data <- data |>
  select(date_outbreak_began, type_of_outbreak) |>
  mutate(
    date_outbreak_began = substr(date_outbreak_began, 1, 4),
    type_of_outbreak = type_of_outbreak
  ) |>
  rename(year = date_outbreak_began, illness_type = type_of_outbreak)

# create the csv file class_year.csv
write_csv(data, "outputs/data/class_year.csv")

