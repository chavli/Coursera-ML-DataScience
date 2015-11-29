# lattice graphics, plots are built using a single function call. the base 
# packages allows you to build plots function by function.

# --> important page: ?par

# general plot parameters:
# par(), sets plot settings for all plots
# pch: plotting symbol, lty: line type, lwd: line width, col: plot color
# las: orientation of the axis labels, bg: background color, mar: margin size
# oma: outer margin size, mfrow / mfcol: number of plots in a row and col
# rows are filled row wise and col wise respectively
# example: par(las = 2)
x<- rnorm(100)
y = x + rnorm(100)
par(las = 1)
plot(x, y)

par(las = 2)
plot(x, y)

# base graphic functions
# plot() creates a plot
# lines() and points()
# text()
# title()
# mtext() -- add text in margins
# axis() -- add axis ticks / labels
# legend()
x <- rnorm(100)
y <- x + rnorm(100)
plot(x, y)
x1 <- rnorm(10)
y1 <- rnorm(10)
points(x1, y1, col="red")

# graphics devices: PDF (vector graphics), postscript, xfig, png, jpeg, bitmap
# bitmapped formats are good for very large datasets 
#IMPORTANT EXAMPLE:
#pdf(file="test.pdf")  #launch graphics device
png(file="test.png")
x <- rnorm(100)
hist(x)
graphics.off() # creates the file with the histogram

# copying between devices, COPYING IS NOT AN EXACT OPERATION
# dev.copy(), dev.copy2pdf() 
example(points) # !!!



# fitting a linear model
x <- rnorm(200)
y <- rnorm(200)
z <- rnorm(200)
fit <- lm(y ~ x)
plot(x, y)
abline(fit, lwd = 2, col="red")

# multiple plots per device
dev.new()
par(mfrow=c(1, 2)) # 1 row, 2 columns. plots placed row-wise
plot(x, y)
plot(x, z)

# plotting multiple classes of data
x <- rnorm(100)
y <- rnorm(100)
g <- gl(2, 50, labels=c("male", "female")) # 2 groups of 50
plot(x, y, type="n") # create the device but without data
points( x[g == "male"], y[g == "male"], col="blue")
points( x[g == "female"], y[g == "female"], col="red")

