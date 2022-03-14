# Lecture 6 - Linear regression
# Load these packages
library(tidyverse)
library(broom)
library(performance)
library(sjPlot)

# Read the cocktails dataset
cocktails <- read_tsv("https://raw.github.com/nthun/cocktail-balance/master/cocktail_data.tsv")
cocktails <- read_tsv("http://bit.ly/2zbj7kA") # Same stuff, but shortened url

# To be able to use catagorical variables in statistical models, we may need to convert the categories to dummy variables. This means that the variable name will be the category name, and if this category is true for the observation, the value of the variable will be 1, or otherwise 0.
# Task: create dummy coded variables in the cocktail dataset  from the type variable
cocktails %>% distinct(type)

dummy_cocktails <-
    cocktails %>% 
    mutate(value = 1) %>% # This defines what will be the spread across variables
    pivot_wider(names_from = type, 
                values_from = value, 
                values_fill = 0) #%>% # Add fill for binary coding, otherwise it will be NA
# select(name, blended:stirred) # Just to show the important variables, otherwise, don't use this


# Create simple linear regression of cocktail acidity on alcohol content
# This only returns intercept and slope
lm(abv ~ acid, data = cocktails)

# Store the model in a variable to be able to get details, predictions, etc.
acid_lm <- lm(abv ~ acid, data = cocktails)
summary(acid_lm)

# This also works without storing the results. However when you use pipes, mind that in lm(), data is not the first parameter
cocktails %>% 
    lm(abv ~ acid, data = .) %>% 
    summary()

# Plot the linear regression
cocktails %>% 
    ggplot() +
    aes(y = abv, x = acid) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) 

# To get clean results, use the broom package.
# tidy() puts returns the model summary in a neat data frame format
tidy(acid_lm)
# Augments adds important new columns to your data frames, such as the residuals (.resid), and predicted values corresponding your independent variables. These can be useful for residual diagnostics.
augment(acid_lm, cocktails)
# Glimpse returns important model performance metrics.
glance(acid_lm)

# To get the standardized coefficients (scale free), you need to standardize the output and predictor variables. Use the scale() function on all variables in the model
acid_lm_std <- lm(scale(abv) ~ scale(acid), data = cocktails)
summary(acid_lm_std)
# You can check that the slope of acid now matches the correlation between abv and acid
cor(cocktails$abv, cocktails$acid)

## Predicting values based on the model
# Create data with new 
newdata <- tibble(acid = c(0.2, 0.3, 0.4))
# predict returns a vector of predictions
predict(acid_lm, newdata)
# modelr::add_predictions() returns a data frame. This one is the preferable.
modelr::add_predictions(newdata, acid_lm)

# Add more predictors using the update function

new_mod <- update(acid_lm, . ~ . + sugar)

## Checking the assumptions for linear regression
# Measure multicollinearity using the variance inflaction factor (VIF)
# Values for any varible should not be larger than 10
car::vif(new_mod)

# If the average VIF is larger than 5, it means that multicollineratity is biasing our model
mean(car::vif(new_mod))


# Measuring the independence of residuals
car::dwt(new_mod)

# It seems like model has some significant autocorrelation, so the residuals are not independent

# To check heteroscetasticity inspect the residual diagnostic plots

## Residual diagnostics
# The residuals should not have an underlying pattern: they should have a normal distribution

augment(new_mod) %>% 
    ggplot() +
    aes(.resid) +
    geom_histogram(bins = 10)

# We can also do a normality test on the residuals
# The Shapiro-Wilks test shows that the residuals are normally distributed
augment(new_mod) %>% 
    pull(.resid) %>% 
    shapiro.test()

# To explore the residuals we are actually better off to use the performance package to make us diagnostic plots, using the check_model() function
library(performance)
# This will plot 5 different diagnostic plots that are all useful to tell if the prediction is reliable
# See explanation on the slides
check_model(new_mod)

# See how to interpret diagnostic plots in slides
# Let's store the diagnostic values in a variable
acid_lm_diag <- augment(new_mod)

# We can single out observations with the slice() function
cocktails %>% 
    slice(c(9, 41, 42, 44, 45))

# We can rerun the lm without cases that have zero acid
acid_lm_clean <-
    cocktails %>% 
    filter(acid != 0) %>% 
    update(new_mod, data = .)

summary(acid_lm_clean)
# We can check the diagnostics without the influential cases.
# Remember, that you can only remove cases from the dataset, when you are perfectly sure that the data was not recorded correctly. You cannot simply remove outliers because they don't fit your model.

check_model(acid_lm_clean)

# We can see that the residuals are still not perfect, which makes the reliability of the model shaky
# Dealing with diagnostics is often an iterative process, where problematic values are investigated recursively

# We can also check the dfbeta and DFFit values to see how much the model changes when we remove a case
dfbeta(acid_lm) # Change in model parameters
dffits(acid_lm) # Change in residual

## MULTIPLE REGRESSION
# Syntax for interactions
# Add multiple predictors: <outcome variable> ~ <predictor 1> + <predictor 2>
# You can choose to get a more verbose output using the summary() function.

lm1 <- lm(abv ~ acid + sugar, data = cocktails)
summary(lm1)
tidy(lm1)
# Add multiple predictors AND their interactions: <outcome variable> ~ <predictor 1> * <predictor 2>
lm2 <- lm(abv ~ acid * sugar, data = cocktails)
summary(lm2)
tidy(lm2)
# Add ONLY the interaction of predictors: <outcome variable> ~ <predictor 1> : <predictor 2>
lm3 <- lm(abv ~ acid : sugar, data = cocktails)
summary(lm3)
tidy(lm3)

# Get the confidence intervals for parameters
confint(lm1, level = 0.95)

# Preferably, you can also get the confint using broom::tidy
tidy(lm1, conf.int = TRUE, conf.level = .95)

# You can combine these
# R can also deal with categorical variables, as they are automatically dummied, and the first level is taken as baseline
lm_cat <- lm(abv ~ acid : sugar + type, data = cocktails)
# To change the baseline, convert it to random, and use the levels to set the baseline to carbonated
# Use the forcats::fct_relevel() function
lm4 <- 
  cocktails %>% 
  mutate(type = fct_relevel(type, "carbonated")) %>% 
  lm(abv ~ acid : sugar + type, data = .)

tidy(lm4)

## Model selection
# You can compare models if you use the same data, and the same approach to get the regression line
# There are 3 widely-used metrics, all provided in broom::glance()
# All of them have the similar underlying principle? 
# You should go for the smallest logLik, AIC, and BIC with the same df

glance(lm1)
glance(lm2)
glance(lm3)
glance(lm4)

# You can also compare the logLik models using the anova() function. It returns an F value, which is significant if difference.
anova(lm1, lm3)
# This tells us that the more complicated model is not significantly better, so we should not use it

# You can have more then 2 models, and the comparison refers to the _PREVIOUS_ model (so not the baseline). Pair-wise comparisons are thus preferable
anova(lm1, lm2, lm3)

# Based on the comparisons, there is no significant diffference. So we should choose the simplest model, that has the smallest df! It is model number 3!

# To report the results of regression, you have to use a table, according to APA6. To create such a table, the easiest is to use the sjPlot package, that collects all information from the models, and creates a nice table.
install.packages("sjPlot")
library(sjPlot)

# To get the table in the console, use the type = "text" argument.
tab_model(lm1, lm2, title = "Results")


# You can also have the table in different formats, e.g. html. If you do this, you can save the object and view the results using your web browser. We will later learn a way to include those tables to your manuscripts.

# Let's also add standardized coefficients

results_table_html <-
    tab_model(lm1,lm2,lm3,lm4, 
              show.std = TRUE, 
              show.est = FALSE
)

# You can save the results using the write_lines() function, and open the html in the browser
write_lines(results_table_html, "results_table.html")

# Plots for the slides --------------------------------------------------------------
## Model fit measures
# See model fitting "game" at http://www.dangoldstein.com/regression.html

# Plot the residuals (error term from the model prediction)
# This plot shows the unexplained variance of the model (summary of the red lines)
 augment(lm1) %>% 
  ggplot() +
  aes(y = abv, x = acid) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5, color = "black") +
  geom_segment(aes(xend = acid, yend = .fitted), linetype = "dashed", color = "red", size = 1.2) +
  geom_point(size = 3)

# All variability in the outcome variable (variance)
# This plots shows the total variance of the outcome variable (summary of the blue lines)
cocktails %>% 
  mutate(mean_abv = mean(abv)) %>% 
  ggplot() +
  aes(y = abv, x = acid) +
  geom_hline(aes(yintercept = mean_abv), size = 1.5) +
  geom_segment(aes(xend = acid, yend = mean_abv), linetype = "dashed", color = "blue", size = 1.2) +
  geom_point(size = 3)

# Improvement of the fit by using the model, compared to only using the mean
# This plots shows the total variance of the outcome variable (summary of the blue lines)
cocktails %>% 
  augment(lm(abv ~ acid, data = .), .) %>% 
  mutate(mean_abv = mean(abv)) %>% 
  ggplot() +
  aes(y = abv, x = acid) +
  geom_hline(aes(yintercept = mean_abv), size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5, color = "black") +
  geom_segment(aes(xend = acid, yend = mean_abv, y = .fitted), linetype = "dashed", color = "purple", size = 1.2) +
  geom_point(size = 2)


