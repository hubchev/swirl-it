  assign("cars93", openintro::cars93, envir=globalenv())
  assign("mpg.midsize", cars93[cars93$type=="midsize","mpg_city"], envir=globalenv())
