library(manipulate)

# manipulate({}, ...)
# {}: the code to execute based on inputs
# ...: code that defines which variables can be changed and how to change them

manipulate(plot(1, x), x = slider(1, 100))
manipulate({
    hist(rnorm(mean=x, sd=1, n=n))
    },
    x = slider(1, 10), n=slider(1, 1000))
