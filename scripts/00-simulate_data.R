#### Preamble ####
# Purpose: simulates the model I plan to create and anaylze (ideology and media frames)
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(broom)
library(ggplot2)
library(dplyr)

# Simulating a dataset
# Set Seed
set.seed(123)  # For reproducibility
n <- 500  # Number of observations
analysis_data <- data.frame(
  policy = sample(0:1, n, replace = TRUE),
  conservative = sample(0:1, n, replace = TRUE),
  liberal = sample(0:1, n, replace = TRUE),
  sympathetic_white = sample(0:1, n, replace = TRUE),
  sympathetic_black = sample(0:1, n, replace = TRUE),
  unsympathetic_white = sample(0:1, n, replace = TRUE),
  unsympathetic_black = sample(0:1, n, replace = TRUE)
)

# Define the model formula
model_formula <- policy ~ conservative + liberal + 
  sympathetic_white + sympathetic_black + 
  unsympathetic_white + unsympathetic_black + 
  conservative:sympathetic_white + conservative:sympathetic_black + 
  conservative:unsympathetic_white + conservative:unsympathetic_black + 
  liberal:sympathetic_white + liberal:sympathetic_black + 
  liberal:unsympathetic_white + liberal:unsympathetic_black

# Fit the logistic regression model
model_ideology_frame <- glm(formula = model_formula, family = binomial(link = "logit"), data = analysis_data)

# Create a tidy dataframe from your model
tidy_model <- broom::tidy(model_ideology_frame) |>
  filter(term %in% c("liberal:unsympathetic_white", 
                     "liberal:unsympathetic_black", 
                     "liberal:sympathetic_white", 
                     "liberal:sympathetic_black", 
                     "conservative:unsympathetic_white", 
                     "conservative:unsympathetic_black", 
                     "conservative:sympathetic_white", 
                     "conservative:sympathetic_black"))

# Create the Forest Plot
ggplot(tidy_model, aes(x = estimate, y = reorder(term, estimate))) +
  geom_point() +
  geom_errorbarh(aes(xmin = estimate - std.error, xmax = estimate + std.error), height = 0.2) +
  theme_minimal() +
  labs(x = "Estimate", y = "Variable", title = "Ideology Model Estimates") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "red")
