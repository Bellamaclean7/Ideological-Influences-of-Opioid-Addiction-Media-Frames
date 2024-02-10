#### Preamble ####
# Purpose: Tests the data for accuracy and legitimacy 
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(dplyr)

# Read in cleaned data
cleaned_data <- read_csv("data/analysis_data/analysis_data.csv")

#### Test data ####
# Test for missing values
# Calculate the number of missing values per column
missing_values <- sapply(cleaned_data, function(x) sum(is.na(x)))

# Total number of missing values
total_missing_values <- sum(missing_values)

# Print the number of missing values per column
print("Missing values per column:")
print(missing_values)

# Print the total number of missing values
print(paste("Total number of missing values:", total_missing_values))

# Test for numbers of rows of data in dataset
# Expected number of rows
expected_rows <- 1517

# Actual number of rows
actual_rows <- nrow(cleaned_data)

# Check if the actual number of rows matches the expected number
if (actual_rows == expected_rows) {
  print("The number of rows matches the expected count.")
} else {
  print(paste("Expected rows:", expected_rows, "but found:", actual_rows))
}
