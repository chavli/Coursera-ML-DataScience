# qplot() "quick plot" is a good starting point
# ggplot lets you do more and is the basis for ggplot2
library(ggplot2)
qplot(displ, hwy, data=mpg) # mpg datafrane comes with ggplot2

# colors are based on the factors defined by drv
qplot(displ, hwy, data=mpg, color = drv)

# qplot can also add a best-fit curve with 95% CIs
# basic args: (x, y, dataset)
qplot(displ, hwy, data = mpg, geom=c("point", "smooth"), method = "loess") 
# method can also be lm


# histograms are created by defining a single variable
# geom = "density" : creates density curves
qplot(hwy, data = mpg, fill=drv)


# facets are similar to panels in latice plots
# facets arg define the number of rows and columns
# facets = numrows ~ numcols, "." = nothing
qplot(displ, hwy, data = mpg, facets=.~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth=2)

# -----------------------------------------------------------------------------
# ggplot details

#begin by defining the dataset and aesthetics (x, y)
g <- ggplot(mpg, aes(displ, hwy))

# then you add on layers. this includes colors, labels, lines, etc
g + geom_point(alpha = 1/3) 
  + geom_smooth(method = "lm", se=FALSE, col="steelblue") 
  + theme_bw(base_family = "Times", base_size = 10)
  + labs(x = expression("log " * PM[2.5]))
  + labs(y = "Y Label")
  + labs(title = "hello world")


# cut(data, cutpoints), cutpoints are percentile values

# -----------------------------------------------------------------------------
# LATEX Support
# expressions()
# any parameter that takes text can take an expression
expression(hat(gamma) == 0)
expression(sum(x[i] * y[i], i == 1a, n))

# if the expression is the result of a calculate you use substitute()
substitute(bar(x) == k, list(k=mean(x)))
