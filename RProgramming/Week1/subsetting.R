setwd("/home/cha/Coursera/RProgramming/Week1/")
x = list(foo=1:4, bar=.6, baz="hello")
name = "foo"

# x$name does not exist. x[[name]] is translated to x[["foo"]] which does exist
x[[name]]

# this returns a list, the same type as the original object x
x[1]

# this returns the actual data in the element, a vector
x[[1]]

# you can also reference elements by name, both of the following return the vector
x$bar
x[["bar"]]

# this returns a list, not the vector of data
x["bar"]