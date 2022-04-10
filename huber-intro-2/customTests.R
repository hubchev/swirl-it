# Put custom tests in this file.
      
      # Uncommenting the following line of code will disable
      # auto-detection of new variables and thus prevent swirl from
      # executing every command twice, which can slow things down.
      
      # AUTO_DETECT_NEWVAR <- FALSE
      
      # However, this means that you should detect user-created
      # variables when appropriate. The answer test, creates_new_var()
      # can be used for for the purpose, but it also re-evaluates the
      # expression which the user entered, so care must be taken.

test_dataframe <- function() {
  try({
    x1 = get('x1', globalenv())
    x2 = get('x2', globalenv())
    x3 = get('x3', globalenv())
    t  = get('t', globalenv())
    t1 = identical(t, data.frame(a=x1, b=x1+x2, c=x1+x2+x3))
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_plot_dataframe <- function() {
  try({
    x1 = get('x1', globalenv())
    x2 = get('x2', globalenv())
    x3 = get('x3', globalenv())
    t  = get('t', globalenv())
    t1 = identical(t, data.frame(a=x1, b=x1+x2, c=x1+x2+x3))
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

# test_firstscript <- function() {
#   #try({
#   #  source("A_(very)_short_introduction_to_R/Module_2/scripts/firstscript.R")
#   #}, silent = TRUE)
#   exists('ok') && isTRUE(ok) 
# }


# test_func3 <- function() {
#   try({
#     func <- get('remainder', globalenv())
#     t1 <- identical(func(9, 4), 9 %% 4)
#     t2 <- identical(func(divisor = 5, num = 2), 2 %% 5)
#     t3 <- identical(func(5), 5 %% 2)
#     ok <- all(t1, t2, t3)
#   }, silent = TRUE)
#   exists('ok') && isTRUE(ok)
# }
# 
# in yaml:
# - Class: script
# Output: Make sure to save your script before you type submit().
# AnswerTests: test_func3()
# Hint: "Remember to set the appropriate default values!"
# Script: remainder.R
# 
