---
title       : Confidence Interval Simulator 
subtitle    : Data Products, Coursera 2015
author      : Cha Li
job         : Data Scientist
logo        :
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax, shiny, interactive]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Confidence Intervals

Confidence intervals (CI) allow us to state how certain we are about our estimates. A common case is 
estimating the sample mean when we want to know the average and also how sure we are about that 
average. 

Assuming the data follows a normal distribution then we have the following definition of the CI:
$$X \\sim N(\\mu, \\sigma\^{2} )$$
$$\\bar{X}\\pm z \\times \\frac{\\sigma}{\\sqrt{n}}$$

--- .class

## The Problem
Several variables have an influence on the range of the confidence interval and in most cases it's
difficult for people to decide which variables to change. Do you need more data? A different confidence
level? 

This issue is why I created a [shiny app](https://chavli.shinyapps.io/ci-simulator) which calulates 
and plots the intervals given a set of user inputs for the mean, standard deviation,
confidence level, and sample size.

The next two slides will briefly go over the R code the above app uses and an example output plot.

---

## R Confidence Intervals
Typically, to calculate a confidence interval in R you would do something like the following:

```r
set.seed(12345)                         # control randomness
z <- 1.96                               # 95% confidence level 
N <- 100
data <- rnorm(n = N, mean = 10, sd=6)  # true mean and sd are 10 and 6, respectively
X_bar <- mean(data)
X_sd <- sd(data)
X_ci <- X_bar + c(-1, 1) * z * (X_sd / sqrt(length(data)))
```

This gives us the following result:

$n = $ 100, $\\bar{X} = $ 11.4711832, $\\sigma_{X} = $ 6.688385

95% Confidence Interval: [10.16, 12.78]

In this instance, the true mean is just barely outside the calculated CI.

--- &twocol

## Visualizing

*** =left
The plot to the right shows the calculated confidence interval laid over a histogram the sample data.

- <span style="color:purple">Purple Line</span>: the true distribution mean, 10
- <span style="color:red">Red Line</span>: the sample mean
- <span style="color:#b8860b">Yellow Lines</span>: the lower and upper bounds of the 95% CI of the sample mean
- <span style="color:#1e90ff">Blue Bars</span>: the distribution of random data

*** =right

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3-1.png) 

