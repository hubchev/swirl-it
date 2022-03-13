# Data wrangling assignment

# Your Cuban uncle sets up a cocktail bar in downtown Budapest. He has a secret list of cocktails that he would like to serve in the bar. He asks you to do create a few lists and tables to set up the shop. As your uncle is a secret hipster, he has a dataset on Github that you can use for the task!
# Note: There are several different ways to solve these tasks, feel free to come up with your own.

## 1. Read the data

# Read the cocktail dataset from: <https://github.com/nthun/cocktail-balance> You can also find the codebook there.

cocktail <- read_tsv("https://raw.githubusercontent.com/nthun/cocktail-balance/master/cocktail_data.tsv")


## 2. Transform the data table and clean the ingredient variable!

# The ingredients are currently in a single cell for each cocktail. It would be better to put them in separate rows. Also, the variable should be cleaned of all quantities (e.g. 1/2 oz, 2 dashes, etc.), and the indicator of alcohol content (e.g. 47.3% abv). You will need to use this cleaned table in later tasks.

# This first task is a bit difficult, so I solved it for you. Use the cocktail_long dataset for the upcoming tasks

cocktail_long <- 
    cocktail %>% 
    # Break apart the dataset, so now every ingredient is in separate rows
    separate_rows(ingredients, sep = "<br/>") %>% 
    # Remove sting segments that are unnecessary
    mutate(ingredients = str_remove_all(ingredients, 
                                        "^.* oz |^.* dash |^.* dashes |^.* drop.|^.* bsp | \\(.*% abv\\)") %>% 
               # Remove white space
               str_squish() %>% 
               str_to_title())

## 3. All ingredients in alphabetical order

# Before opening the bar, you need to find a reliable supplier that has all the ingredients. You need to send a list of all possible ingredients you will need. They don't need the quantities (i.e. how many of these are needed), just the names of the ingredients.

cocktail_long %>% 
  distinct(ingredients) %>% 
  arrange(ingredients) %>% 
  pull(ingredients)


## 4. Number of unique ingredients

# How many different ingredients you will need?

cocktail_long %>% 
    distinct(ingredients) %>% 
    pull()


## 5. What are the top 10 ingredients?

# What are the 10 most frequently used ingredients? If there are ties, you can list more than 10.

cocktail_long %>% 
  count(ingredients, sort = TRUE) %>%
  top_n(10, n) %>% 
  pull(ingredients)


## 6. Which cocktail(s) has/have the most ingredients?

# Count the number of ingredients and filter all the cocktails that has that many.

cocktail_long %>% 
    count(name, sort = TRUE) %>% 
    top_n(1, n) %>% 
    pull(name)


## 7. How many ingredients appear in only one cocktail (rare ingredient)?

# Count all cocktails with only one ingredient, and

single_ingredient <-
  cocktail_long %>% 
  count(ingredients) %>% 
  filter(n == 1)

single_ingredient %>% 
  nrow()


## 8. Which cocktail has an ingredient that is only used in one cocktail?

cocktail_long %>% 
    left_join(single_ingredient, by = "ingredients") %>% 
    drop_na(n) %>% 
    distinct(name) %>% 
    pull(name)


## 9. What are the cocktails without rare ingredients?

cocktail_long %>% 
  left_join(single_ingredient, by = "ingredients") %>% 
  group_by(name) %>% 
  filter(all(is.na(n))) %>% 
  ungroup() %>% 
  distinct(name) %>% 
  pull(name)
  


## 10. Create a cheat sheet for the bartender!

# Create a table that shows all cocktail names as rows and all ingredients as columns. When a cocktail requires an ingredient, there should be an "X" in the cell, otherwise, the cell should remain empty. Example:

tribble(~name, ~Lime, ~`White rum`, ~`Cane sugar`, ~`Coca-cola`, ~Mint, ~Soda,
        "Caipirissima", "X", "X", "X", "", "", "",
        "Cuba Libre", "X", "X", "", "X","","",
        "Mojito", "X", "X", "", "", "X", "X") %>% 
    relocate(name, sort(names(.)))


# You can use knitr::kable() to print the whole table

cocktail_long %>% 
  # Select relevant columns and prepare for dummy coding
  transmute(name, ingredients, value = "X") %>% 
  # Remove multiple instances of the same ingredient in the same cocktail
  group_by(name) %>% 
  distinct(ingredients, .keep_all = TRUE) %>% 
  ungroup() %>% 
  # Spread the table
  pivot_wider(names_from = "ingredients", 
              values_from = "value",
              values_fill = "") %>% 
  # Rearrange columns
  relocate(name, sort(names(.))) %>% 
  # Rearrange rows
  arrange(name) %>% 
  knitr::kable()

