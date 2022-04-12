  assign("cars", datasets::cars, envir=globalenv())
  assign("mpg.midsize", cars[cars$type=="midsize","mpgCity"], envir=globalenv())
