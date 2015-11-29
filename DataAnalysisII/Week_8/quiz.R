# Question 1
# False discovery rate = 0.20 False positive rate = 0.09

# Question 2
# How many are significant at the alpha = 0.1 level when controlling the family wise error rate using the methods described in the lectures? 
# When controlling the false discovery rate at the alpha = 0.1 level as described in the lectures?
# FWER = 7 FDR = 61
set.seed(3343)
pValues = rep(NA,100)
for(i in 1:100){
  z = rnorm(20)
  x = rnorm(20)
  y = rnorm(20,mean=0.5*x)
  pValues[i] = summary(lm(y ~ x))$coef[2,4]
}

fwer = sum(p.adjust(pValues, method="bonferroni") < .1);
fdr = sum(p.adjust(pValues, method="BH") < .1);


# Question 4
# where b0=1, b1=2 and x and e both have a normal distribution with mean zero and variance one.
# Case 1: b1 is estimated correctly Case 2: b1 is underestimated

b1s = rep(0, 100)
set.seed(12345)
for(i in seq(100)){
  e = rnorm(100);
  x = rnorm(100);
  idx = x < 2;
  y = 1 + 2*x + e
  linfit = lm(y[idx] ~ x[idx])
  
  b1s[i] = linfit$coefficients["x[idx]"]
}

b1s = rep(0, 100)
for(i in seq(100)){
  e = rnorm(100);
  x = rnorm(100);
  y = 1 + 2*x + e
  idx = y < 2;
  linfit = lm(y[idx] ~ x[idx])
  
  b1s[i] = linfit$coefficients["x[idx]"]
}


# Question 5
library(MASS)
b1s = rep(0, 100)
set.seed(12345)
for(i in seq(100)){
  e = rnorm(100);
  x = rnorm(100);
  idx = x < 2;
  y = 1 + 2*x + e
  linfit = rlm(y[idx] ~ x[idx])
  
  b1s[i] = linfit$coefficients["x[idx]"]
}

b1s = rep(0, 100)
for(i in seq(100)){
  e = rnorm(100);
  x = rnorm(100);
  y = 1 + 2*x + e
  idx = y < 2;
  linfit = rlm(y[idx] ~ x[idx])
  
  b1s[i] = linfit$coefficients["x[idx]"]
}