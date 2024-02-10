#### Preamble ####
# Purpose: Cleans the raw data to include only variables of interest and prepare for analysis
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(tidyverse)
library(readr)
library(dplyr)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

print(raw_data)

# Filter the dataset to include only the required variables
cleaned_data <- raw_data |>
  select(sw, sb, ns, uw, ub, 
         policy, 
         conservative, moderate, liberal, 
         hsgrad, somecollege, collegegrad, postgrad) |>
  rename(sympathetic_white = sw, 
         sympathetic_black = sb, 
         no_story = ns, 
         unsympathetic_white = uw, 
         unsympathetic_black = ub, 
         policy = policy, 
         high_school_grad = hsgrad, 
         some_college = somecollege, 
         college_grad = collegegrad, 
         post_graduate = postgrad)

# Optionally, view the first few rows of the filtered dataset
head(cleaned_data)

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
