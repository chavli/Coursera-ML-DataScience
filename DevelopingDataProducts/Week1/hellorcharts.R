library(rCharts)
data(iris)

names(iris) <- gsub("\\.", "", names(iris))
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data=iris, color="Species", type="point")
r1$save("fig/r1.html", cdn=T)

r1$print("chart1") # prints the D3 javascript
r1$publish("testplot", host="rpubs")