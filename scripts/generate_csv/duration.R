#### Preamble ####
# Purpose: Transform clean_data.csv into a smaller csv file with the columns: duration, outbreak_type, and causative_agent
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####

library(tidyverse)

# read the data
data <- read_csv("outputs/clean_data/clean_data.csv")

# omit active outbreaks so each observation is a completed outbreak
# create a dataframe 
data <- data |>
  na.omit() |>
  select(causative_agent, outbreak_type, duration)

# create duration.csv
write_csv(data, "outputs/transformed_data/duration.csv")