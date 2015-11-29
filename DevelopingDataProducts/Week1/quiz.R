# Question 1
# This function plots distance versus speed, each de-meaned and an associated line of slope s.
# Which of the following code will make a manipulate plot that creates a slider for the slope?
library(manipulate)
myPlot <- function(s) {
    plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
    abline(0, s)
}

manipulate(myPlot(s), s = slider(0, 2, step = 0.1))


# Question 5
