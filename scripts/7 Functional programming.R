# Programming basics and functional programming in R
library(tidyverse)


# Lists ------------------------------------------------------------------------

# Lists are complex nested data structures, they can contain different data types
# or even other lists.

things <- list(1, "a", TRUE, 1+4i)
things

str(things)

# List don't even have to contain the same number of elements
things2 <- list(1:5, letters, NULL, list("orange", "apple"))

things2

length(things2)

# This returns a list that contains the first element of the second list object.

things[2]

# Accessing the whole second element (all letters) as a vector

things2[[2]]

# Getting the apple element 

things2[[4]][[2]]

# List elements can also be named

things3 <-
    list(
        x = 1:5,
        letters = letters,
        nothing = NULL,
        fruits = list(first = "orange", second = "apple")
    )

things3

# Indexing is also possible through names

things3[["x"]]

things3$x

things3$fruits$first

# This is useful to know, because very often when you download data using APIs,
# you will find that the data is stored in complex list formats. Putting the data
# into a 2 dimensional tabular format is called data rectangling.

# Data frames are restricted lists, meaning that practically it is a list of 
# variables (vectors). Because of this, data frames can also have variables that
# contain lists.

# Tibbles can be nested and unnested

tibble(x = list(x = 1:4))




# Writing functions ------------------------------------------------------------

# When we do any command in R, we execute a function
# Even if the function is not visible, like 5*8. Under the hood, this is translated to

`*`(5, 8)

# This is useful to know for piping

5 %>% 
    `*`(4)

# Functions either return something, or have a side effect. It is better not to do both.
# Let's create a simple function

hello_world <- function(){
    print("Hello world!")
}

hello_world()

# We can also add parameters to the function.

bottles <- function(x){
    paste("There are", x, "bottles on the shelf")
}

bottles(12)
bottles(1)

# Make it more complex, so we can handle the plural

bottles <- function(x){
    
    plural <- ifelse(x > 1, "s", "")
    be <- ifelse(x > 1, "are", "is")
    
    paste0("There ", be, " ", x, " bottle", plural, " on the shelf")
}

bottles(1)
bottles(2)

# Conditional execution -----------------------------------------------------

# All programming languages have functions for controlling the flow of running
# a script, such as conditional execution. So you can have certain conditions for
# parts of your code to run or not run. In functions, it is useful to verify if
# the parameters fit certain characteristics for example.

bottles <- function(x) {
    if (!is.numeric(x))
        stop("Provide a number!")
    if (x < 0)
        stop("Provide a number that is larger than zero!")
    
    plural <- ifelse(x > 1, "s", "")
    be <- ifelse(x > 1, "are", "is")
    
    paste0("There ", be, " ", x, " bottle", plural, " on the shelf")
}

# Our function now returns a proper error message if the parameter was not a number
# or less than 0
bottles("a")
bottles(-1)

# Vectorized condition: if_else()
# You can also use a simplified and vectorized version of conditional execution.
# For e.g. when you only want to change certain values of a variable, but not others.

starwars %>% 
    mutate(height = if_else(name == "Darth Vader", 205, height))

# Note that the previous command does not run as we did not define the "true" 
# parameter properly as an integer number. ifelse() wouldn't care, but if_else()
# does. 

starwars %>% 
    mutate(height = if_else(name == "Darth Vader", 205L, height))

# It is also possible to set several several conditional rules using case_when()

starwars %>% 
    mutate(height = case_when(name == "Darth Vader" ~ 205L,
                              name == "Luke Skywalker" ~ 171L,
    # This last bit just means to keep the values the same for all the others
                              TRUE ~ height)
           )


# Iteration --------------------------------------------------------------------
# Iteration is when we execute the same thing several times. 
# We have to define the sequence of things that we want to iterate through

for (i in 1:12){
    print(i)
    }

# R is a functional programming language, which also means that loops are less
# important here as in other programming languages. They can be substituted with
# vectorized functions. Vectorized means that the functions are basically executing
# at the same time on all elements, and not happening sequentially.
# Iteration without loops

# Although there is a base R variant for this, we will only discuss the tidyverse
# variant of looping.

map(1:12, print)

# This looks strange because printing something is actually a side effect, and not
# really an output value. For side effects, the walk function should be used.

walk(1:12, print)

# This is the same as, but now we can define the parameters inside the ().

walk(1:12, ~print(.x))

# Let's use our bottles function to make this meaningful

for (i in 1:12){
    bottles(i)
}

# It does not print the result. Let's wrap it in a print()

for (i in 1:12){
    print(bottles(i))
}

# Let's use functional looping instead of iteration

walk(1:12, bottles)

# walk doesn't work anymore, because the bottles function actually returns a value
# and not a side effect. So now we can use map for looping, although it returns a list

map(1:12, bottles)

# Map has variants that will convert the list output to a specific data type
# map_chr will return a character vector instead

map_chr(1:12, bottles)





