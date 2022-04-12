# Dot plot
plot(cars93$price, rep(1, nrow(cars93)), ylab="", yaxt="n", xlab="Price ($1000s)",
     xlim=c(5,65))