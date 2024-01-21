#### Preamble ####
# Purpose: Downloads and saves raw data about outbreaks in Toronto
# health care facilities from opendatatoronto using the CKAN API.
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install the R packages tidyverse and opendatatoronto.

#### Workspace Setup ####
library(opendatatoronto)
library(tidyverse)

i <- 2
year <- 2023

# get raw outbreak data from 2017 to 2023

while (i <= 8) {
  package <- show_package("80ce0bd7-adb2-4568-b9d7-712f6ba38e4e")
  resources <- list_package_resources("80ce0bd7-adb2-4568-b9d7-712f6ba38e4e")
  
  datastore_resources <- filter(resources, tolower(format) %in% 'csv')
  data <- filter(datastore_resources, row_number()==i) %>% get_resource()
  
  file_name <- sprintf("inputs/raw_data/raw_data_%d.csv", year)
  write_csv(data, file_name)
  year <- year - 1
  i <- i + 1
}


