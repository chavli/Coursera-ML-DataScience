setwd("/home/cha/Coursera/RProgramming/Week3")

# Question 1
library(datasets)
data(iris)
species_data = split(iris, iris$Species)
mean(species_data$virginica$Sepal.Length)

# Question 2
apply(iris[, 1:4], 2, mean)

# Question 3
library(datasets)
data(mtcars)
mpg_by_cyl = sapply(split(mtcars$mpg, mtcars$cyl), mean)

# Question 4
hp_by_cyl = sapply(split(mtcars$hp, mtcars$cyl), mean)