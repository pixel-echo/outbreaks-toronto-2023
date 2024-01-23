#### Preamble ####
# Purpose: Cleans raw outbreak data from opendatatoronto. 
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install R packages tidyverse and janitor.

#### Workspace Setup ####
library(tidyverse)
library(janitor)

# read in data
raw_data_2023 <- read_csv("inputs/raw_data/raw_data_2023.csv")
raw_data_2022 <- read_csv("inputs/raw_data/raw_data_2022.csv")
raw_data_2021 <- read_csv("inputs/raw_data/raw_data_2021.csv")
raw_data_2020 <- read_csv("inputs/raw_data/raw_data_2020.csv")
raw_data_2019 <- read_csv("inputs/raw_data/raw_data_2019.csv")
raw_data_2018 <- read_csv("inputs/raw_data/raw_data_2018.csv")
raw_data_2017 <- read_csv("inputs/raw_data/raw_data_2017.csv")

# clean variable names
clean_data_2023 <- clean_names(raw_data_2023)
clean_data_2022 <- clean_names(raw_data_2022)
clean_data_2021 <- clean_names(raw_data_2021)
clean_data_2020 <- clean_names(raw_data_2020)
clean_data_2019 <- clean_names(raw_data_2019)
clean_data_2018 <- clean_names(raw_data_2018)
clean_data_2017 <- clean_names(raw_data_2017)

# merge data frames
clean_data <- rbind(clean_data_2023, clean_data_2022, clean_data_2021, clean_data_2020,
                  clean_data_2019, clean_data_2018, clean_data_2017)


# create a csv of cleaned data. 
write_csv(clean_data, "outputs/clean_data/clean_data.csv")
