# Functional programming in R
library(tidyverse)


# Lists ------------------------------------------------------------------------

# Tibbles ----------------------------------------------------------------------

# Tibbles can be nested and unnested

# Iteration --------------------------------------------------------------------


# Iteration without loops


# Conditions -------------------------------------------------------------------


# Vectorized condition: if_else()


# Writing functions ------------------------------------------------------------

# When we do any command in R, we execute a function
# Even if the function is not visible, like 5*8. Under the hood, this is translated to

`*`(5, 8)

# This is usefult to know for piping

5 %>% 
    `*`(4)

# Functions either return something, or have a side effect. It is better not to do both.
# Let's create a simple function

hello_world <- function(){
    print("Hello world!")
}

hello_world()


