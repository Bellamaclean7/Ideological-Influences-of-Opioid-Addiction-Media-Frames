#### Preamble ####
# Purpose: Downloads, saves, and reads data saved on my computer 
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(readr)

#### Download data ####
tessdata <- read_csv("data/raw_data/raw_data.csv")

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(tessdata, "data/raw_data/raw_data.csv")
         
