#### Preamble ####
# Purpose: Write a script to generate a csv file with the columns year and outbreak_count.
# Want to see the general trend of outbreaks in Toronto's healthcare institutions.
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####
library(tidyverse)

# read clean_data.csv
data <- read_csv("outputs/data/clean_data.csv")

# transform dataframe to the desired one
data <- data |>
  mutate(
    month = str_sub(date_outbreak_began, 6, 7)
  ) |>
  select(month)

# create csv file
write_csv(data, "outputs/data/months.csv")