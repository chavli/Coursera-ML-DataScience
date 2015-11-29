
# returns the list of colors that R understands
colors()

# creating palettes of colors. you can then choose a color that falls
# between the two colors by passing a value [0, 1]. p is a returned
# function
p <- colorRamp(c("red", "blue"))
p(.5)
p(.76)

# returns a function that lets you choose N "equally spaced" colors
# between the given colors
p <- colorRampPalette(c("red", "yellow"))
p(2)
p(10)

# RColorBrewer pacakge --> provides useful color palletes
# sequential -- ordered data (classes, continuous )
#   - colors with a neutral start: white, light red, red
# diverging -- diverging data (variance, deviations, etc)
#   - colors with a neutral center: red, white, green 
#
# qualitative -- (unordered, categorical data. (classes) )
#   - random colors
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))


# when plotting massive clusters, it is better to use smoothScatter
# 2D histogram vs a bunch of points
x <- rnorm(1000)
y <- rnorm(1000)
smoothScatter(x, y)

# you can specify a color using rgb() as well as transparancy
# 0 = transparent, 1 = opaque
x <- rnorm(1000)
y <- rnorm(1000)
plot(x, y, col = rgb(0, 0, 0, alpha=.2), pch=19)