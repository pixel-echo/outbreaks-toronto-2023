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

# create relevant dataframe
data <- data |>
  mutate( year = str_sub(start, 1, 4)) |>
  select(outbreak_type, year, institution)

# create csv file
write_csv(data, "outputs/transformed_data/infection_class.csv")