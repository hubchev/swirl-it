# Plotting assignment

library(tidyverse)

# Task 1: Climbing expeditions

# The 2020-09-22 TidyTueday datasets are about climbing expeditions. From the three datasets, use the "expeditions". 
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-09-22/
#     
# - Use the "datasets/expedition" dataset, which is a summarized version of the above mentioned dataset. `expedition <- read_csv("datasets/expeditions.csv")`
# - The bar colors use the viridis palette and the light theme.

expedition <- read_csv("datasets/expeditions.csv")




# Task 2: PhDs awarded

# The 2019-02-19 TidyTueday dataset is about phd-s awarded by year and field. 
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-02-19
# 
# - Use the "datasets/phd" dataset, which is a summarized version of the above mentioned dataset. `phd <- read_csv("datasets/phd.csv")`
# - To make the x axis breaks pretty, use `scales::pretty_breaks()`, to make the y axis labels comma formatted, use `scales::comma_format()`.
# - The line size is 1.2, the colors are from the brewer "Dark2" palette. The theme is set to minimal.

phd <- read_csv("datasets/phd.csv")




# Task 3: Commute in the US

# The 2019-11-05 TidyTueday dataset is about commuting to work in each city in the US by bike or on foot. 
# https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-11-05
# 
# - Use the "datasets/commute" dataset, which is a summarized version of the above mentioned dataset. `commute <- read_csv("datasets/commute")`
# - Both axis scales are log transformed and the labels comma formatted, using `scales::comma_format()`
# - The point size is 2. The theme is set to light. Use the default color palette.


commute <- read_csv("datasets/commute")


