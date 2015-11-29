setwd("/home/cha/Coursera/RProgramming/Week1/")


x = factor(c("yes", "yes", "no", "no", "yes", "no", "yes"))
table(x)   # counts of each level
unclass(x) # see the underlying representation of each level 

# define the ordering of the levels
x = factor(c("yes", "yes", "no", "no", "yes", "no", "yes"), levels=c("yes", "no"))

# data.matrix()  homogenous data types, data.frame() heterogeneous data type
x = data.frame(foo=1:4, bar=c("a", "b", "c", "d"))


# elements can also have names. this creates a mapping of names to indexes, almost like a hash
x = 1:3
names(x) = c("foo", "bar", "lol")
x["foo"] # 1

x = matrix(data=1:4, nrow=2, ncol=2)
dimnames(x) = list(c("T", "F"), c("A", "B")) # row names, col names