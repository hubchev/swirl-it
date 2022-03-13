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

# Data frames are restricted lists, meaning that practically it is a list of 
# variables (vectors). 


# Tibbles ----------------------------------------------------------------------

data.frame(x = data.frame(x = 1:4))

# Tibbles can be nested and unnested

# Iteration --------------------------------------------------------------------


# Iteration without loops



# Control structures ------------------------------------------------------


# Vectorized condition: if_else()


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

# We can also add parameters

bottles <- function(x){
    paste("There are ", x, "bottles on the shelf")
}

bottles(1)

# Make it more complex, so we can handle the plural

bottles <- function(x){
    
    plural <- ifelse(x > 1, "s", "")
    be <- ifelse(x > 1, "are", "is")
    
    paste0("There ", be, " ", x, " bottle", plural, " on the shelf")
}

bottles(1)
bottles(2)

# Let's make an iteration to make this meaningful

for (i in 1:12){
    bottles(i)
}

# It does not print the result. Let's wrap it in a print()

for (i in 1:12){
    print(bottles(i))
}

# However it is more easier with map, although it returns a list

library(purrr)

map(1:12, bottles)

# We can explicitly use a map function to return a character vector instead

map_chr(1:12, bottles)

# Mind that if we use another type, it crashes

map_int(1:12, bottles)



