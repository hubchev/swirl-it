### Lecture 3: Preparing data for analysis, data wrangling (transformation) in the tidyverse
# Dolution to the first task
library(ggplot2)
ggplot(ToothGrowth) +
    aes(x = dose, y = len, group = dose) +
    geom_boxplot() +
    facet_wrap(~supp)

# Install the tidyverse package. All the packages that we will use today are included in it
install.packages("tidyverse")

# Reading and writing data -----------------------------------------------------------------

# The easiest way is to use data import from the "Files" window
# 
# **IMPORTANT!! IN ORDER TO USE THIS CODE, YOU ALSO HAVE TO DOWNLOAD THE DATAFILES FROM THE WORKSHOP'S PAGE, THAT YOU CAN FIND IN THE DATASETS LIBRARY!** 
# 
# R has its own data format (.RData), that stores variables from R. You can load an R object using the `load()` function.
# Usually, it is enough to provide the file name (with the relative or absolute path), but import functions often has optional parameters.

load("datasets/movies.RData")

# You can save your variables using the `save()` function. It requires two parameters: the variable to save, and the filename to save to.

x <- c("apple","orange","pinaple")
save(x, file = "datasets/fruits.RData")

# For reading common file formats, we will use the `readr` package (from tidyverse)


# File path ---------------------------------------------------------------------
# By default, R designates a default folder for searching for files. 
# This is called the "working directory"
# Learn what it is:
getwd()

# You can also change e.g.

setwd("d:/download")

# This is an "absolute" path. 
# A relative path is relative to the working directory, e.g.

setwd("temp")
getwd()

# In the file path, you can either use / or \\ to separate folder names.  

# Tibbles ----------------------------------------------------------------------
# Tibbles are the tidyverse variants of data frames. Features:
# Always keep the source data type (e.g. character instead of factor)
# Improved printing (e.g. also shows type)
# Tibble is stricter than data frames in subsetting or slicing, 
# This means that errors won't go unnoticed 

# Data reader functions from tidyverse packages always read into tibble by default.
# It is easy to see the difference between base and tidyverse variants, as tidy
# variants always use the _ as a separator in function name, while base uses .

read.csv("datasets\\movies.csv")

library(readr)
read_csv("datasets\\movies.csv")

# I suggest to always use the tidyverse reading functions

# Reading different data formats ------------------------------------------

# A very common file format in the data analysis community is .csv. It means comma separated values, which is a quite literal description. It is a simple text file, but commas distinguish variables and values from each other. You can import a csv file using

read_csv("datasets/movies.csv")

# Note that as we did not assign the result of the function to a variable, it is not stored. So let's try

m1 <- read_csv("datasets/movies.csv")

# To save a dataset to csv format, you can just use the `write_csv()` function. It requires two parameters: the data frame to save, and the filename to save to.

write_csv(m1, "datasets/movies.csv")

# tsv is almost the same as csv, but tabs are used instead of commas

cocktails <- read_tsv("datasets/cocktail_data.tsv")

# Writing to tsv... yes, you have guessed it: `write_tsv()`
# Reading text files is also easy. `read_lines()` will read the file line by line, and create a vector 
# Here, check out the complete works of Shakespeare:

shakespeare <- read_lines(file = "datasets/shakespeare_all_works.txt")

# Remember that you can read files directly from the internet, if you use the `url()` function:
# We can also skip the first 244 lines as it only contains licence info

shakespeare <- read_lines(url("https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/t8.shakespeare.txt"), skip = 244)


# To read Excel files, we will use the `readxl` package
library(readxl)

# For excel files, you also have to specify the worksheet that you want to access. You can do it by sheet name or position. So the next 2 commands return the same result

read_excel(path = "datasets/cocktails.xlsx", sheet = 1)
read_excel(path = "datasets/cocktails.xlsx", sheet = "Sheet 1")

# You can also read SPSS (and SAS, etc.) formats by using the `haven` package

library(haven)
read_spss("datasets/movies.sav")

# Data manipulation using dplyr ------------------------------------------------

# Let's try the pipe operator
# The pipe is in several packages, for e.g. the magrittr package
library(magrittr)

# Take the following vector
x <- c(55:120, 984, 552, 17, 650)

# Creating a pipeline of commands. Of course, the sorting does not change the result
x %>%
    sort() %>%
    subtract(5) %>%
    divide_by(3) %>%
    sd()

# [1] 46.02999
# Let's load the dplyr package, which is for data transformation in data frames
# Btw, it also contains the %>% operator, so you don't need to load magrittr
library(dplyr) 

# Let's use the ToothGrowth data once again, and practice with the pipe opeartor
# Filter the rows that 
ToothGrowth %>%
    filter(supp == "OJ")

# Let's creare a new variable, which which returns tooth length in cm, not mm. Use mutate()
ToothGrowth %>%
    mutate(len_cm = len / 10)

# Let's see the average tooth length in centimeters, use summarise()
# This takes several data and summarizes it accoring to our wishes
# The result will not contain the original data
ToothGrowth %>%
    mutate(len_cm = len / 10) %>%
    summarise(mean_len_cm = mean(len_cm))

# Let's also calculate the nuber of cases, using the function n()
ToothGrowth %>%
    mutate(len_cm = len / 10) %>%
    summarise(mean_len_cm = mean(len_cm),
              cases = n())

# It makes the most sense if we also create groups but BEFORE summarize, using group_by()
tooth_results <-
    ToothGrowth %>%
    mutate(len_cm = len / 10) %>%
    group_by(supp) %>%
    summarise(mean_len_cm = mean(len_cm),
              cases = n())

tooth_results
# You can also use the grouping with mutate. Then it adds the group means and number of cases to the original data
# This way, the result will also contain the original data AND the summary statistics with redundancy
ToothGrowth %>%
    mutate(len_cm = len / 10) %>%
    group_by(supp) %>%
    mutate(mean_len_cm = mean(len_cm),
           cases = n())

# We can also arrange the results based on a variable
tooth_results %>% 
    arrange(mean_len_cm)


# Practice on the gapminder data. First install it, than load the data 
install.packages("gapminder")
gapminder <- gapminder::gapminder


# Tasks ------------------------------------------------------------------------
# Gapminder contains the data of several countries at different times.
# It is in tidy format. Check the codebook
?gapminder::gapminder

# Task 1 solution
solution_1 <-
    gapminder %>% 
    filter(year %in% c(1952, 1957)) %>%
    group_by(continent) %>% 
    summarise(life_exp_med = median(lifeExp)) %>% 
    arrange(-life_exp_med)

# Task 1 data viz   
solution_1 %>% 
    ggplot() +
        aes(x = continent, y = life_exp_med) +
        geom_col()

# Task 2 solution
solution_2 <-
    gapminder %>% 
    filter(country %in% c("Hungary","Norway","Austria")) %>% 
    group_by(country) %>% 
    mutate(mean_pop = mean(pop),
           cent_pop = pop - mean_pop)

# First let's see what does the data look like without centering
solution_2 %>% 
    ggplot() +
    aes(x = year, y = pop, group = country, color = country) +
    geom_line(size = 1.5) +
    geom_hline(yintercept = 0) +
    scale_y_continuous()

# And the solution with centering is the following. Mind that it will remove baseline differences, but trends will be more visible
solution_2 %>% 
    ggplot() +
        aes(x = year, y = cent_pop, group = country, color = country) +
        geom_line(size = 1.5) +
        geom_hline(yintercept = 0) +
        scale_y_continuous()
    


# Tidy data --------------------------------------------------------------------
library(tidyr)

# We will use the who data from the tidyr package
# Check the codebook

who
?who
# gather arranges data to long format
# you have to give a name that will store

who_long <- 
    who %>% 
    pivot_longer(cols = new_sp_m014:newrel_f65,
                 names_to = "variable",
                 values_to = "value")

# You can see a lot of missing values (NA) that you can easily remove
who_long <- 
    who_long %>% 
    drop_na(value)

# According to the codebook, there are several things encoded in these variables, that is not tidy
# For example, ˙new_` in the vairable name does not contain information, so let's remove it
# To make operations on strings, let's use the stringr package, also from the tidyverse

library(stringr)

# Mind that that the data does not change, as we don't save it to any variable
who_long %>% 
    mutate(variable = str_replace(variable, "new_",""))
    

# This way, the variable contains 3 different information: test result, gender, and age
# Let's separate the test result first

who_long %>% 
    mutate(variable = str_replace(variable, "new_","")) %>% 
    separate(col = variable, into = c("test_result","gender_age"), sep = "_")

# We still need to separate the gender from the age
who_tidy <-
    who_long %>% 
    mutate(variable = str_replace(variable, "new_","")) %>% 
    separate(col = variable, into = c("test_result","gender_age"), sep = "_") %>% 
    mutate(gender = gender_age %>% substring(1,1),
           age_group = gender_age %>% substring(2))

who_tidy

# Now we can verify what age groups we have
who_tidy %>% 
    distinct(age_group)

# To keep the other variables
who_tidy %>% 
    distinct(age_group, .keep_all = TRUE)

# We can also transform the data to wide format, for e.g. the age groups. 
# Let's say we only want to make the age groups in wide format, but keep the gender,  test results, year, etc. in long format
who_tidy %>% 
    pivot_wider(names_from = age_group, 
                values_from = value)

# From here, it would be quite easy to drop redundant variables, like gender_age
who_tidy %>% 
    pivot_wider(names_from = age_group, 
                values_from = value) 
    select(-gender_age)

# Note that wide format is not the optimal format for data analysis or plotting if you 
# have repeated measurements
    

# Recode variables -------------------------------------------------------------

case_when
recode

# Joining data -----------------------------------------------------------------

left_join()
right_join()
full_join()
anti_join(

bind_cols()
bind_rows()


    
)

      