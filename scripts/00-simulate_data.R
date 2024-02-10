#### Preamble ####
# Purpose: simulates the two models I plan to create and anaylze (ideology and media frames, education and media frames)
# Author: Bella MacLean
# Date: 10 February 2024
# Contact: bella.maclean@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(ggplot2)

#### Simulate data ####
# Set seed for reproducibility
set.seed(123)  

# Number of observations
n <- 500

# Simulate data
sim_data <- data.frame(
  Policy = rbinom(n, 1, 0.5),  # Binary outcome (favoring treatment = 1)
  conservative = rbinom(n, 1, 0.5),
  liberal = rbinom(n, 1, 0.5),
  hsgrad = rbinom(n, 1, 0.3),
  somecollege = rbinom(n, 1, 0.3),
  collegegrad = rbinom(n, 1, 0.2),
  postgrad = rbinom(n, 1, 0.2),
  sw = rbinom(n, 1, 0.25),
  sb = rbinom(n, 1, 0.25),
  uw = rbinom(n, 1, 0.25),
  ub = rbinom(n, 1, 0.25)
)

# Here I am confirming each row has only one level of education and one frame
sim_data$moderate <- 1 - (sim_data$conservative + sim_data$liberal) # moderate as reference (not shown)
sim_data$ns <- 1 - (sim_data$sw + sim_data$sb + sim_data$uw + sim_data$ub)  # ns as reference (not shown)

# Basic model without interactions for simplicity of simulation (for ideology)
model_ideology_frame <- glm(Policy ~ conservative + liberal + sw + sb + uw + ub, data = sim_data, family = binomial(link = "logit"))

# Predict and add to sim_data
sim_data$predicted_ideology_frame <- predict(model_ideology_frame, type = "response")

# (for education)
model_education_frame <- glm(Policy ~ hsgrad + somecollege + collegegrad + postgrad + sw + sb + uw + ub, data = sim_data, family = binomial(link = "logit"))

# Predict and add to sim_data
sim_data$predicted_education_frame <- predict(model_education_frame, type = "response")

# Simulated visualization for Ideology and Frame Model
ggplot(sim_data, aes(x = conservative, y = predicted_ideology_frame)) +
  geom_boxplot(aes(group = conservative, fill = factor(conservative))) +
  labs(x = "Conservative (0 = No, 1 = Yes)", y = "Predicted Probability of Favoring Treatment",
       title = "Predicted Probability by Ideology") +
  scale_fill_discrete(name = "Conservative") +
  theme_minimal()
