# Using R as a calculator ------------------------------------------------------

# R can be used as a calculator, so for e.g. try:

21 + 16

# You will see the result of the operiation is:
# [1] 37

# By the way, you may have noticed that text that starts with "#" has a different color. These are the comments. You can have as many comment in a script as you want. The "#" Does not have to be in the beginning of the line, but everything after it will count as comment.

# You can try more complex operations too:

(11*2.3)^2 + 3*(log(15)) * pi + sin(1/5) 
# [1] 665.8114

# ^: means exponential
# *: means multiply
# log(): natural log
# pi: pi (surprise)
# sin(): sinus
# Wrap your expressions in () if you want them to be evaluated as you want


# Variables --------------------------------------------------------------------
# Variable types
# There are different variable types in R
# numeric, integer, character, logical, and factor are the most often used types

# numeric/double: 2, 15.5
number1 <- 55 # Assign a value to a variable

Number2 = 66 # = is the same as <-, but <- is the standard as it is directional

number1 + number2
# Error: object 'number2' not found

# Mind that R is case sensitive (but space agnostic)! So try again:
number1 +      Number2
# [1] 121

# integer: 2L (the L tells R to store this as an integer)

days_in_week <- 7L
class(days_in_week)

# character: "a", "apple"

string <- "abc"

is.character(string)

# logical: TRUE, FALSE
is_it_monday <- TRUE

# It is possible to convert types. This conversion between modes of storage is called “coercion”.
as.numeric(is_it_monday)


# +1: factor: labelled numeric data, e.g. 1: apple, 2: pear. Useful for ordering. it is basically not a type but a data structure. See later.

# Functions --------------------------------------------------------------------

# There are also functions in R that are basically commands.
# Functions usually have parameters that define what data to use, and how the command should be executed
# You always have to use parentheses after the names of the functions, even if it does not have any parameters.
# For example, let's see how to use commands to make plots

# Graphics
# First, we use the rnorm() command that generates 1000 random numbers with a mean of 100, and a standard deviation of 10. So this function takes three parameters (how many numbes, what should be the mean and sd). 

x <- rnorm(1000, mean = 100, sd = 10) 
x # Simply print the content of a variable
# You can create a histogram of the distribution of the variable. This function only requires 1 parameter to create the plot, but actually, you can use several other parameters to make the plots more fancy.
hist(x)

# How to get help in R
?hist # This will show you what parameters you can use when drawing a histogram

# If you know what you want to do, but don't know the function name
??histogram


# Data structures --------------------------------------------------------------
# R has many data structures. These include
# 
# atomic vector: a variable with several elements of the same kind
# data frames: a dataset with several variables (vectors) inside
# list: we will discuss later
# matrix: will not discuss now

# A numeric vector
numbers <- c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19) # Create a number vector
numbers # Print the numbers from 10 to 19
# [1] 10 11 12 13 14 15 16 17 18 19 

# See the difference between numeric and character vectors
as.character(numbers)
# [1] "10" "11" "12" "13" "14" "15" "16" "17" "18" "19"

length(numbers)
# [1] 10

# Create a character vector. Mind the ""-s. It is the same as '', but the opening quote has to match the closing quote.
fruits <- c("apple", 'apple', "banana", "kiwi", "pear", "strawberry", 'strawberry')
print(fruits) # Print the content of the variable
print("Hello world!") # Good, we have now made a Hello world program

# Indexing
# Get only the 1st, third, and fifth element of the vector
fruits[c(1,3,5)]

# Remove the first 3, and the 7th elements
fruits[-c(1:3, 7)]

# Matrices are 2 dimensional data structures of the same type, we will not use them

# Factors
# Factors are basically not types but data structures, i.e. a numeric vector with labels

answers <- factor(c(1, 1, 3, 2, 3), 
                  levels = c(1, 2, 3), 
                  labels = c("No", "Maybe", "Yes")
                  )
anwers

class(answers)
str(answers)
attributes(answers)


# Data frames ------------------------------------------------------------------
# There are built in dataframes in R, just to try things

data("USArrests") # Load a built in data frame. This one is about US arrests
USArrests  # Check the data.frame

str(USArrests) # Check the structure of the data frame, types of variables, etc.
# 'data.frame':	50 obs. of  4 variables:
# $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
# $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
# $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
# $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

head(USArrests) # First 6 records
tail(USArrests, 10) # Last 10 records

names(USArrests) # Variable names
row.names(USArrests) # Name of the observations/records
nrow(USArrests) # Number of observations/records
ncol(USArrests) # Number of variables
dim(USArrests) # Number of dimensions

# Exploratory data analysis

# Access one particular variable in a data.frame
# Two main ways:
# First is as it was a 2 dimensional variable.
USArrests[1:10, c("Murder","Assault","Rape")]

# You can also use the $ to get the value of a single variable from a dataset.
USArrests$Assault # This will print the contents of that single variable

# Get a numerical summary of the variable Murder, from the USArrests dataset
summary(USArrests$Murder)

# Scatter plot of urban population vs. the murder arrests 
plot(x = USArrests$UrbanPop, y = USArrests$Rape)

# Make a linear model (will dicuss this later, the point is to check the association)
USArrest_lm <- lm(USArrests$Rape ~ USArrests$UrbanPop) # This will return a complex object, but we are only interested in the lm coefficients. Don't worry about this too much, we are going to learn linear models in a later class.

abline(USArrest_lm$coefficients, lty = "dashed", col = "red") # Make a strait line be using the linear model coefficients. Linetype is dashed.


# Packages ---------------------------------------------------------------------

# If R is a toolbox, than packages are the tools that are developed for particular functions. There are many different packages in R, but usually you only use some in a particular project. 
# You can get these packages directly in R from a package repository in the cloud. 
# For example, let's download a package called "swirl".

install.packages("swirl") # Download a package from the main package repository (CRAN)

# swirl is a great teaching tool within R about R programming. I strongly recommend checking it out.
# To be able to use a particular tool, you need to load it (the analogue of taking it out of your toolbox)

library(swirl) # Load the package to the R session
# Follow the instructions of swirl and do the first lesson. As a homework, you can do lesson 2-7. 
# To stat swirl, just type: 
swirl()


