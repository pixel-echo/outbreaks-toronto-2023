#### Preamble ####
# Purpose: Create a csv file using clean_data.csv with the columns: year, month, causative_agent, and institution
# where institution is the type of institution where the causative_agent caused an outbreak.
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####
library(tidyverse)

# read data 
data <- read_csv("outputs/clean_data/clean_data.csv")

# select and create the appropriate columns 
data <- data |>
  mutate(
    year = str_sub(start, 1, 4),
    month = str_sub(start, 6, 7)
  ) |>
  select(year, month, institution, causative_agent)

# create infection.csv
write_csv(data, "outputs/transformed_data/infection.csv")