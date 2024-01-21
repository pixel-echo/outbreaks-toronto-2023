#### Preamble ####
# Purpose: Transform cleaned data to a usable csv file with the variables year and causative_agent. 
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install R packages tidyverse and janitor.

data <- read_csv("inputs/clean_data/clean_data.csv")

# create a dataframe with the variables date_outbreak_began and causative_agent_1
years <- raw_data |>
  select(date_outbreak_began, causative_agent_1)

# group all strains of a causative agent together
years <- years |>
  mutate(
    causative_agent_1 = case_when(
      str_detect(causative_agent_1, "influenza") ~ "Influenza",
      str_detect(causative_agent_1, "Influenza") ~ "Influenza",
      str_detect(causative_agent_1, "CPE") ~ "CPE",
      str_detect(causative_agent_1, "Enterovirus") ~ "Rhinovirus",
      str_detect(causative_agent_1, "Strep") ~ "Streptococcus",
      str_detect(causative_agent_1, "Campylobacter") ~ "Campylobacter",
      str_detect(causative_agent_1, "Clostridium") ~ "Clostridium difficile",
      causative_agent_1 == "Pending" ~ "Unknown",
      causative_agent_1 == "Unable to identify" ~ "Unknown",
      causative_agent_1 == "Norovirus-like" ~ "Unknown",
      causative_agent_1 == "COVID-19" ~ "Coronavirus",
      causative_agent_1 == "Coronavirus*" ~ "Coronavirus",
      causative_agent_1 == "Respiratory syncytial virus" ~ "RSV",
      TRUE ~ causative_agent_1
    )
  )

# multiple causative agents at one time will be considered as two outbreaks at once.
years <- years |>
  separate_longer_delim(causative_agent_1, ",") |>
  mutate(
    causative_agent_1 = str_trim(causative_agent_1)
  )

# find the year each outbreak began 
years <- years |> 
  mutate(
    date_outbreak_began = substr(date_outbreak_began, 1, 4)
  )

# rename variables
years <- years |>
  rename(year = date_outbreak_began, causative_agent = causative_agent_1)

# create a csv of the dataframe years
write_csv(years, "outputs/data/years.csv")