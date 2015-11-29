library(slidify)
library(knitr)
setwd("/home/cha/Coursera/DevelopingDataProducts/Project/slidify/")
author("ci-simulator")


slidify("ci-simulator/index.Rmd")
browseURL("ci-simulator/index.html")