#### Preamble ####
# Purpose: Transform clean_data.csv to a usable csv file with the variables duration and causative_agent. 
# Author: Tara Chakkithara
# Date: 20 January 2024
# Contact: tara.chakkithara@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package tidyverse and clean_data.csv

#### Workspace Setup ####

library(tidyverse)

# read the data
data <- read_csv("inputs/clean_data/clean_data.csv")

# find the duration of each non active outbreak
data <- data |>
  subset(active == "N") |>
  mutate(
    duration = date_declared_over - date_outbreak_began
  ) |>
  select(duration, causative_agent_1) |>
  rename(causative_agent = causative_agent_1)

# group different strains of causative agents together
data <- data |>
  mutate(
    causative_agent = case_when(
      str_detect(causative_agent, "influenza") ~ "Influenza",
      str_detect(causative_agent, "Influenza") ~ "Influenza",
      str_detect(causative_agent, "CPE") ~ "CPE",
      str_detect(causative_agent, "Enterovirus") ~ "Rhinovirus",
      str_detect(causative_agent, "Strep") ~ "Streptococcus",
      str_detect(causative_agent, "Campylobacter") ~ "Campylobacter",
      str_detect(causative_agent, "Clostridium") ~ "Clostridium difficile",
      causative_agent == "Pending" ~ "Unknown",
      causative_agent == "Unable to identify" ~ "Unknown",
      causative_agent == "Norovirus-like" ~ "Unknown",
      causative_agent == "COVID-19" ~ "Coronavirus",
      causative_agent == "Coronavirus*" ~ "Coronavirus",
      causative_agent == "Respiratory syncytial virus" ~ "RSV",
      TRUE ~ causative_agent
    )
  )

# create mean_duration.csv
write_csv(data, "outputs/data/duration.csv")