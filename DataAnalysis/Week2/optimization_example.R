# make means constructor?

make.NegLogLik <- function(data, fixed=c(FALSE, FALSE)){
  params <- fixed

  # p is a parameter vector
  function(p){
    # boolean indexing to determine which indexes are set to
    # the values of p
    params[!fixed] <- p
    
    mu <- params[1]
    sigma <- params[2]

    # negative log-likelihood
    a <- -.5*length(data)*log(2*pi*sigma^2)
    b <- -.5*sum((data - mu)^2 / (sigma^2))

    -(a + b) # last line is the return value
  }
}


# usage example
set.seed(1)
normals <- rnorm(100, 1, 2) # samples, mu, sigma
nll <- make.NegLogLik(normals)

# arguments: parameter vector, function to optimize
optim(c(mu=0, sigma = 1), nll)

#optimize() can also be used to optimize over one variable

#PLOTTING

nll <- make.NegLogLik(normals, c(1, FALSE)) # optimize as a function of sigma

# different values for sigma
x <- seq(1.7, 1.9, len=100) 

# apply nll to each value of sigma
y = sapply(x, nll) 

# optimization curve
plot(x, exp(-(y - min(y))), type = "l" )