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


# remove unnecessary columns 
clean_data <- clean_data |>
  select(!c(id, institution_name, institution_address, active))

# make the column outbreak_setting more readable
clean_data <- clean_data |>
  mutate(
    institution = case_when(
      outbreak_setting == "Shelter" ~ "Homeless Shelter",
      str_detect(outbreak_setting, "Hospital") ~ substring(outbreak_setting, 10),
      TRUE ~ outbreak_setting
    )
  ) |>
  select(!outbreak_setting)

# some outbreaks have multiple causative agents. 
# we can consider each case as a separate outbreak. 
# create an observation for each causative agent.
clean_data <- clean_data |>
  separate_longer_delim(causative_agent_1, ",") |>
  separate_longer_delim(causative_agent_2, ",") |>
  mutate(
    causative_agent_1 = str_trim(causative_agent_1),
    causative_agent_2 = str_trim(causative_agent_2)
  )

data_a <- clean_data |>
  select(!causative_agent_2) |>
  rename(causative_agent = causative_agent_1)
data_b <- clean_data |>
  filter(!is.na(causative_agent_2)) |>
  select(!causative_agent_1) |>
  rename(causative_agent = causative_agent_2)

clean_data <- rbind(data_a, data_b)

# group different strains of infection together.
# considering norovirus-like causative agents to be unknown agents. 
clean_data <- clean_data |>
  mutate(
    causative_agent = case_when(
      causative_agent == "COVID-19" ~ "Coronavirus",
      causative_agent == "Coronavirus*" ~ "Coronavirus",
      causative_agent == "Respiratory syncytial virus" ~ "RSV",
      causative_agent == "Pending" ~ "Unknown",
      causative_agent == "Unable to identify" ~ "Unknown",
      str_detect(causative_agent, "Strep") ~ "Streptococcus",
      str_detect(causative_agent, "CPE") ~ "CPE",
      str_detect(causative_agent, "influenza") ~ "Influenza",
      str_detect(causative_agent, "Influenza") ~ "Influenza",
      str_detect(causative_agent, "Clostridium") ~ "Clostridium Difficile",
      str_detect(causative_agent, "Enterovirus") ~ "Rhinovirus",
      str_detect(causative_agent, "Campylobacter") ~ "Campylobacter",
      str_detect(causative_agent, "Norovirus-like") ~ "Unknown",
      TRUE ~ causative_agent
    )
  )

# creating a column to keep track of the duration of an outbreak
clean_data <- clean_data |>
  mutate(
    duration = date_declared_over - date_outbreak_began
  )

# renaming more columns for readability
clean_data <- clean_data |>
  rename(
    outbreak_type = type_of_outbreak,
    start = date_outbreak_began,
    end = date_declared_over
  )



# create a csv of cleaned data. 
write_csv(clean_data, "outputs/clean_data/clean_data.csv")
