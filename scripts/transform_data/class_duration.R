#### Preamble ####
# Purpose: Transform clean_data.csv to a usable csv file with variables illness_type and duration.  
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####

library(tidyverse)

# read the data
data <- read_csv("inputs/clean_data/clean_data.csv")

# create a dataframe looking at illness type and duration
data <- data |>
  subset(active == "N") |>
  mutate(
    duration = date_declared_over - date_outbreak_began,
    illness_type = type_of_outbreak
  ) |>
  select(duration, illness_type)

# create the csv file class_duration.csv
write_csv(data, "outputs/data/class_duration.csv")
