# xyplot, bwplot, histogram, stripplot, dotplot, splom, levelplot

# lattice functions take a formula which can include conditioning variables
# y ~ x | f * g
library(lattice)
library(nlme)
xyplot(distance ~ age | Subject, data = Orthodont)
xyplot(distance ~ age | Sex, data = Orthodont)

# lattice functions return a trellis object, which is autoprinted. the object
# can be treated like any other variablae (i.e saved)

# it is also possible to control what gets displayed in the panels
x <- rnorm(100)
y <- x + rnorm(100)
g = gl(2, 50)
xyplot(y ~ x | g,
  panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # default xyplot 
    panel.lmline(x, y, col = 2)   # linear regression line
    panel.loess(x, y, col = 3) # polynomial regression line
    panel.abline(mean(x), col="green") # mean
  })

# ------------------------------------------------------------------------------

data(environmental)

# since temp is continuous, we have to force it to have a discrete
# number of bins
temp.cut <- equal.count(environmental$temperature, 4)
wind.cut <- equal.count(environmental$wind, 4)
xyplot(ozone ~ radiation | temp.cut * wind.cut, data = environmental,
  panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # default xyplot 
    panel.loess(x, y, col = 3) # polynomial regression line    
  })

# ------------------------------------------------------------------------------
# pair-wise scatterplots
splom(environmental)
