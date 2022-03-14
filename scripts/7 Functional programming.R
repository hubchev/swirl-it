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
        fruits = list(orange = "orange", apple = "apple")
    )

things3

# Indexing is also possible through names

things3[["x"]]

things3$x

things3$fruits$orange

# Data frames are restricted lists, meaning that practically it is a list of 
# variables (vectors). Because of this, data frames can also have variables that
# contain lists.

# Tibbles can be nested and unnested

tibble(x = list(x = 1:4))

# Iteration --------------------------------------------------------------------
# Iteration is when we execute the same thing several times. 
# We have to define the sequence of things that we want to iterate through

for (i in 1:12){print(i)}

# Iteration without loops

lapply(1:12, function(x) print(x))

# The tidyverse variant is much more concise, and the output is more consistent

map(1:12, print)

# We can explicitly use a map function to return a character vector instead

map_chr(1:12, print)

# Mind that if we use another type, it crashes

map_int(1:12, print)

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

map_chr(1:12, bottles)





