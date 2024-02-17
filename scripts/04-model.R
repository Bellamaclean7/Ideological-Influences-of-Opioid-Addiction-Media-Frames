#### Preamble ####
# Purpose: Create my two models and share them to their respective locations
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
# Ideology Model
# Convert ideology and education variables to numeric
ideology_vars <- c('conservative', 'liberal') # 'moderate' is excluded as it is the reference category
frame_vars <- c('sympathetic_white', 'sympathetic_black', 'unsympathetic_white', 'unsympathetic_black')  # 'ns' is excluded as it is the reference category

# Create interaction terms for political ideology and media framing conditions
for (ideology in ideology_vars) {
  for (frame in frame_vars) {
    interaction_name <- paste(ideology, frame, sep = "_")
    analysis_data[[interaction_name]] <- analysis_data[[ideology]] * analysis_data[[frame]]
  }
}

# Define the model formula for ideology and frame interactions
formula_ideology_frame <- reformulate(c(ideology_vars, frame_vars,
                                        paste0(rep(ideology_vars, each = length(frame_vars)), '_', rep(frame_vars, times = length(ideology_vars)))), 
                                      response = "policy")

# Run the logistic regression model for ideology and frame
model_ideology_frame <- glm(formula_ideology_frame, family = binomial(link = "logit"), data = analysis_data)

# Summary of the model for ideology and frame
summary(model_ideology_frame)


#### Save model ####
saveRDS(
  model_ideology_frame,
  file = "models/ideology_model.rds"
)