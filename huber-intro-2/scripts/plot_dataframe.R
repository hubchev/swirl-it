# Text behind the #-sign is not evaluated as code by R. 
# This is useful, because it allows you to add comments explaining what the script does.

# Make data frame
x1 = rnorm(100)
x2 = rnorm(100)
x3 = rnorm(100)
t = data.frame(a=x1, b=x1+x2, c=x1+x2+x3)

# Plot data frame
plot(t$a, type='l', ylim=range(t), lwd=3, col=rgb(1,0,0,0.3))
lines(t$b, type='s', lwd=2, col=rgb(0.3,0.4,0.3,0.9))
points(t$c, pch=20, cex=4, col=rgb(0,0,1,0.3))

# Note that with plot you get a new plot window while points and lines add to the previous plot.