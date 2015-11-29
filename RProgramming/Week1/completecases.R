setwd("/home/cha/Coursera/RProgramming/Week1/")

df = data.frame(foo=c(1, NA, 2, 5, NA, 12, 3, 1, NA), bar=c(NA, "a", "b", NA, "d", "e", "f", "g", NA))
good = complete.cases(df)
df[good, ]    # cases with no missing data
df[!good, ]   # cases with missing data

# we can also compare vectors
x = c(1, NA, 2, 5, NA, 12, 3, 1, NA)
y = c(NA, "a", "b", NA, "d", "e", "f", "g", NA)
good = complete.cases(x, y)
x[good]
y[good]
df = data.frame(foo=x[good], bar=y[good])