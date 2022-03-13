### Lecture 2
# Quick tutorial for R Studio and how to use scripts

x <- 127:987
x_mean <- mean(x)
x - x_mean
# What should be the mean of this vector? Now, calculate this in the console. Obviously, it's 0! 
# Congrats, you've just learned centering! This helps to get rid of baseline differences.

# Let's also calculuate the standard deviation, and name it x_sd!
x_sd <- sd(x)
# And divide each value of x with the sd of the vector
x/x_sd
# This is called scaling. This helps to get rid of differences in a scale, for eg. if someone is using 

# When using centering and scaling together, it is called standardization, or z-score. This helps to make 
(x - x_mean)/x_sd
# This gives the same result as
scale(x) # Both centers and scales. You don't have to use parameters, as centering and scaling is the same
# You can choose to have only centering, or scaling 

scale(x, center = TRUE, scale = FALSE) # Only centers
scale(x, center = FALSE, scale = T) # Only scales (mind that you can abbreviate TRUE to T, but this is case sensitive!)


# Data visualization -----------------------------------------------------------
# Install ggplot2 using
install.packages("ggplot2")
library(ggplot2) # Load the package that we will use for visualization

# Load the movie data from the internet
# We can read a data frame from a file or directly from the internet.
# As this file is an R data object, reading it instantly adds it to the environment
load(url("https://stat.duke.edu/~mc301/data/movies.Rdata"))

# Checking the data
movies
# Also, you can check the data in a scrollable way in the upper right corner, when clicking on the "movies" text. Btw, this is the same as typing `View(movies)` in the consol (mind the capital V).

head(movies) # This shows the first 6 rows of the dataset
# So, how much the audience and critics score agree?
ggplot(data = movies) + # Call the plotting, define the dataset # Elements can be added to a plot using `+`
    aes(x = audience_score, y = critics_score) + # Define aesthetics, that have a variable value
    geom_point() # geoms are the actual plots

# So we created a scatter plot
plot1 <- # We can store the plot in a variable, so it will only be plotted if we explicitly print the variable
ggplot(data = movies) +
    aes(x = audience_score, y = critics_score, color = genre) + # Let's add color, based on genre
    geom_point(aes(shape = mpaa_rating)) # We can also add aesthetics in the geom. Let's add shape too, based on mpaa_rating rating. Don't forget to wrap the aesthetic into aes()!

plot1 # This will print the plot

ggplot(data = movies) +
    aes(x = audience_score, y = critics_score, color = genre) + # Let's add color, based on genre
    geom_point(shape = "+", aes(size = log10(imdb_num_votes))) # If you want to give constant values, you don't have to use aes(). In that case, define these constants in the geom. You can use contant and variable aesthetics in the same time, but not for the same aesthetic.


# Exercises --------------------------------------------------------------------

# Try to make a scatter plot, using different variables to explore different research questions
# Option 1: Is there any yearly seasonality in movie genres? Are there movie genres that are not featured in certain months?
# Option 2: Do films get longer on average over time? Also highlight the films that are longer than 3 hours!
# Option 3: Is there an association between the number of votes and rating? Also check if title type is relevant in this question!

# Option 1 Solution
ggplot(data = movies) +
    aes(y = genre, x = thtr_rel_month) +
    geom_point(size = 3) +
    scale_x_continuous(breaks = 1:12, minor_breaks = 0) # The x axis is ugly, we will learn how to fix it later

ggplot(data = movies) +
  aes(y = genre, x = (thtr_rel_month)) +
  geom_point(size = 3) +
  scale_x_discrete()
  scale_x_continuous(breaks = scales::pretty_breaks())
    
# Option 2 Solution
ggplot(data = movies) +
    aes(y = runtime, x = thtr_rel_year, color = runtime > 180) +
    geom_point(size = 2)

# Option 3 Solution
ggplot(data = movies) +
    aes(y = imdb_rating, x = imdb_num_votes, shape = title_type, color = title_type) +
    geom_point(size = 2.5)


# Facets -----------------------------------------------------------------------
# Facets are separate panels that may help to discover trends in the data
ggplot(data = movies) +
    aes(y = imdb_rating, x = imdb_num_votes) +
    geom_point(size = 2) +
    facet_wrap(~title_type) # Mind that you have to put a ~ before the variable.

# You can also use two variables for faceting as rows and columns
ggplot(data = movies) +
    aes(y = imdb_rating, x = runtime) +
    geom_point() +
    facet_grid(title_type ~ critics_rating)


# More geoms -------------------------------------------------------------------
# A simple histogram
ggplot(data = movies) +
    aes(x = runtime) +
    geom_histogram()

# Density plot
ggplot(data = movies) +
    aes(x = runtime, group = title_type, fill = title_type) +
    geom_density(alpha = .5) # Alpha sets opacity. It can be a value between 0-1

# Boxplot
ggplot(data = movies) +
    aes(y = audience_score, x = mpaa_rating) +
    geom_boxplot() # Boxplot shows median and density, see explanation in slides

# Violinplot (density plot like box plot)
ggplot(data = movies) +
    aes(y = audience_score, x = mpaa_rating, fill = mpaa_rating) +
    geom_violin() # Violoin plot is similar to boxplot: the wider the plot, the more data points there

# Line plot
ggplot(data = head(movies, 20)) + # We only choose the first 20 records
    aes(y = imdb_rating, x = thtr_rel_year) +
    geom_line(size = 2) +
    geom_point(size = 5, color = "#FF0000") # You can use more then just one geom. E.g. add points

# Text annotation
ggplot(data = head(movies, 20)) + # We only choose the first 20 records
    aes(y = imdb_rating, x = thtr_rel_year, label = title) +
    geom_line(size = 2) +
    geom_point(size = 5, color = "#00FF00") + # You can use more then just one geom. E.g. add points
    geom_text()

# Label is the same with a background
ggplot(data = head(movies, 20)) + # We only choose the first 20 records
    aes(y = imdb_rating, x = thtr_rel_year, label = title) +
    geom_line(size = 2) +
    geom_point(size = 5, color = "#FF0000") + # You can use more then just one geom. E.g. add points
    geom_label()

# Barplot
ggplot(data = tail(movies, 5)) + # Use the last 5 movies
    aes(x = title, y = imdb_rating) +
    geom_col()

# Pointrange
ggplot(data = tail(movies, 5)) + # Use the last 5 movies
    aes(x = title, y = imdb_rating, ymin = imdb_rating - 1, ymax = imdb_rating + 1) +
    geom_pointrange()  

# Errorbar
ggplot(data = tail(movies, 5)) + # Use the last 5 movies
    aes(x = title, y = imdb_rating, ymin = imdb_rating - 1, ymax = imdb_rating + 1) +
    geom_errorbar()     

# Horizontal errorbar
ggplot(data = tail(movies, 5)) + # Use the last 5 movies
    aes(y = title, x = imdb_rating, xmin = imdb_rating - 1, xmax = imdb_rating + 1) +
    geom_errorbarh(height = .5)   


# Statistical transformations --------------------------------------------------
# ggplot can automatically  transform your data, which means it puts in a summarised format so you can plot it directly

# Bar plot of the number of movies in each category. You don't have to specify y, as it will be the calculated count. Aggregating and summarising data may help to understand, but inevitably causes data loss
ggplot(data = movies) +
    aes(x = genre) +
    geom_bar()

# Adds a non-linear trendline and standard error as default
ggplot(data = movies) +
    aes(x = thtr_rel_year, y = imdb_num_votes) +
    geom_point() +
    geom_smooth()

# You can also add a linear model trend ("lm"), and remove the standad error
ggplot(data = movies) +
    aes(x = thtr_rel_year, y = imdb_num_votes) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE)


# Position ---------------------------------------------------------------------
# Make a stacked bar chart that shows absolute counts
ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "stack")

# You can also make the plot proportional
ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "fill")

# Or present the count next to each other, so everything is comparable
ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "dodge")

# Position jitter slightly scatters the data points so they become more visible. Scattering is random
ggplot(data = movies) +
    aes(x = genre, y = audience_score) +
    geom_point(position = "jitter")


# Coordinate systems -----------------------------------------------------------
# Flip x and y
ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "dodge") +
    coord_flip()

# Polar plot
ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "fill") +
    coord_polar()


# Themes -----------------------------------------------------------------------
# There are several themes other than the default
# Try adding these to any plot!
plot1 + theme_minimal()
plot1 + theme_light()
plot1 + theme_dark()


# Scales -----------------------------------------------------------------------
# Continuous scale
ggplot(data = movies) +
    aes(y = genre, x = thtr_rel_month) +
    geom_point(size = 3) +
    scale_x_continuous(breaks = 1:12, minor_breaks = 0)

# Discrete scale
ggplot(data = movies) +
    aes(x = genre, y = thtr_rel_month) +
    geom_point(size = 3) +
    coord_flip() +
    scale_y_discrete()

# You can set the scale for several aesthetics, such as fill or color
plot2 <-
  ggplot(data = movies) +
    aes(x = genre, group = critics_rating, fill = critics_rating) +
    geom_bar(position = "fill") +
    coord_polar() +
    scale_fill_brewer(palette = "YlOrRd")
    
plot2

### Save your plot
# Put your plot into a variable ( <- ), than 
# ggsave(<VARIABLE NAME>, "<FILENAME>")
# If you don't specify variable name, then the last plotted object will be saved
ggsave(plot2, "film_plot_1.jpg")


