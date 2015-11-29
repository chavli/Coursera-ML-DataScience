# Object Oriented Programming in R. based on the S4 classes/method system
library(methods)

# creating instances of a classes can be done by calling Class.new()
# new(...)

#a method is an implementation of a generic function for a specific classes
# --> mean, sd, var etc

# ?Classes and ?Methods for more info

# every R objecs have a class
class(1)
class(1L)
class(TRUE)
class(NA)
class("foo")

# more complex objects
x <- rnorm(1000)
y <- x + rnorm(1000)
fit <- lm(y ~ x)
class(fit)
summary(fit)

# showMethods() lets you see the available methods for an objects. only works with
# S4 generic classes
showMethods("show")

# getS3Method(<generic function>, <class>)
getS3Method("mean", "default")

# getMethod(<generic>, <signature>)


# Example: generic functions with varying behavior
x <- rnorm(200)
plot(x) # points are plotted

# convert x to time series data
tx <- as.ts(x)
plot(tx) # points are connected


# Example: creating classes with setClass() function
# data elements of a class are called "slots"

# adding methods to a class is done with setMethod
setClass( "polygon",
          representation(x = "numeric", y = "numeric"))

# @ allows you to access slots in a class
setMethod("plot", "polygon",
          function(x, y, ...){
            plot(x@x, x@y, type="n", ...) # plot the vertices
            xp <- c(x@x, x@x[1])  
            yp <- c(x@y, x@y[1])
            lines(xp, yp) # draw the edges
          })

showMethods("plot")


# Example: using our new class
p <- new("polygon",  x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)

library(stats4) # classes for maximum likelihood analysis