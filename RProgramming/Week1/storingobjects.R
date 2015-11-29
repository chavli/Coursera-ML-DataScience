setwd("/home/cha/Coursera/RProgramming/Week1/")
x = c(1, 2, 3, 4, 5)
y = c("hello", "world", "a", "b", "c")

df = data.frame(foo=x, bar=y)

# save/retrieve a single object
dput(x, file = "x.R")
a = dget("x.R")

# save/retreive multiple objects
dump(list = c("x", "y", "df"), file="data.R") # save everything
rm(list = ls()) # delete everything
source("data.R") # retrieve everything

