# Put custom tests in this file.
      
      # Uncommenting the following line of code will disable
      # auto-detection of new variables and thus prevent swirl from
      # executing every command twice, which can slow things down.
      
      # AUTO_DETECT_NEWVAR <- FALSE
      
      # However, this means that you should detect user-created
      # variables when appropriate. The answer test, creates_new_var()
      # can be used for for the purpose, but it also re-evaluates the
      # expression which the user entered, so care must be taken.

test_readfiles <- function() {
  try({
    d3 = get('d3', globalenv())
    d3g_answer = c(10,20,40,80,160,320)
    t1 = identical(d3$g, d3g_answer)
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_plotdates <- function() {
  try({
    dates = get('dates', globalenv())
    t1 = identical(class(dates), c("POSIXlt","POSIXt"))
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_ifstatement <- function() {
  try({
    d = get('d', globalenv())
    t1 = identical(d, 2)
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_forloop <- function() {
  try({
    s = get('s', globalenv())
    t1 = identical(s, c(NA,20,30,40,50,60,70,80,NA,NA))
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_exercise_forloop <- function() {
  try({
    z = get('z', globalenv())
    #t1 = identical(z, c(seq(10,40,10), seq(0.5,9,0.1), seq(910,1000,10)))
    t1 = identical(z[1],10)
    t2 = identical(z[36],3.6)
    t3 = identical(z[99],990)
    ok = all(t1,t2,t3)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_function <- function() {
  try({
    z = get('z', globalenv())
    t1 = identical(z[1],10)
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_exercise_function <- function() {
  try({
    fun2 = get('fun2', globalenv())
    t1 = identical(round(fun2(seq(1,100,0.5)),2), round(c(seq(10,45,5), seq(0.5,9,0.05), seq(905,1000,5)),2))
    ok = all(t1)
  }, silent = TRUE)
  exists('ok') && isTRUE(ok)
}


