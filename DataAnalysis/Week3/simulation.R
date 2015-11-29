
# generate a random normal number, sd and mu optional (default: standard normal)
rnorm(10, mean <- 0, sd <- 1)

# evaluate the normal prob dens at a point (or vector of points)
dnorm(0, mean <- 0, sd <- 1)

# evaluate CDF of normal 
pnorm(0)

# other dists follow the same format: rpois, dpois, ppois, qpois
#d: density, r: random generation, p: CDF, q: quantile function

# other important things: setting the seed for reproducibility
set.seed(1)


#EXAMPLE 1:
set.seed(1)
x <- rnorm(100)
e <- rnorm(100, 0 , 2)
y <- .5 + 2 * x + e
summary(y)
plot(x, y)

#EXAMPLE 2:
x <- seq(1, 100)
e <- rnorm(100, 0,1)
y <- 1.5 - 3 * x + e
plot(x, y)

#EXAMPLE 3: Poisson Model
# Y ~ Poisson(mu)
# log(mu) = b1 + b2x
set.seed(1)
x <- rnorm(100)
log.mu <- .5 + .3 * x
y <- rpois(100, exp(log.mu))
plot(x, y)

# Sampling with/without replacement
set.seed(1)
sample(1:10, 4) # pick 4 from the set 1:10
sample(1:10, 4, replace = T) # sample with replacement
sample(1:10) # without the second parameter, sample() creates a permutation