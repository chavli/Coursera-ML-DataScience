#lapply - loop over a list and apply a function to each element 
#         always returns a list
x <- 1:4
lapply(x, runif) # generate N uniform random values

# the last argument of lapply is ... which allows you to pass in additional 
# arguments for the looping function
lapply(x, runif, min = 0, max = 10) 

# ------------------------------------------------------------------------------

#sapply - simpler verison of lappy
# if all lists have 1 element, a vector is returned
# if all lists have the same length >1 a matrix is returned
# otherwise a list of lists is returned
x <- list(rnorm(100), runif(100), rpois(100, 1))
sapply(x, quantile, probs = c(.25, .75))

# ------------------------------------------------------------------------------

#apply  - apply a function over margins of an arrray
# applies functions over the dimensions of a matrix (rows, cols, etc)
x <- matrix(rnorm(200), 20, 10) 

# second argument determines which dimension is preserved.
# others are collapsed

#colMeans, colSums, etc are optimized versions of their apply counterparts
apply(x, 2, mean) # colMeans(x)  
apply(x, 1, mean) # rowMeans(x)

apply(x, 1, quantile, probs = c(.25, .75))

# EXAMPLE: 3 dimensions (average matrix)
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10)) #array of 10 2x2 matricies
apply(a, c(1, 2), mean)

# ------------------------------------------------------------------------------

#tapply - apply a function over subsets of a vector
# calculating the average of a certain class of data
x <- c(rnorm(10), runif(10), rnorm(10, 1) )
f <- gl(3, 10)  # factor variable, will split x into 3 groups of 10
tapply(x, f, mean)

# split - seperates a vector, list, or data frame based on a factor variable
x <- c(rnorm(10), runif(10), rnorm(10, 1) )
f <- gl(3, 10) 
split(x, f) # returns a list 
lapply(split(x, f), mean) # same as tapply(x, f, mean)

# splitting on multiple factors, this is good for breaking fown a variable
# by multiple classes (gender, age, etc)
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = T)) # drop empty groups
 
#mapply - multivariate version of lapply
# apply a function to multiple lists, vectors, etc in parallel
# vectorize functions that dont typically take vector parameters

mapply(rep, 1:4, 4:1)  # mapply(function, param1, param2, paramN)
mapply(noise, 1:5, 1:5, 2)