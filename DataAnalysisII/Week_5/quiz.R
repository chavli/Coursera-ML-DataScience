# Question 1
data(warpbreaks)
anova_test = aov(warpbreaks$breaks ~ warpbreaks$wool + warpbreaks$tension)

#Question 2
# T: .2 F: .8
# Odds: 1 : 4 = .25
# Log Odds = log(.25)
log(.25)


# Question 3
library(glm2)
data(crabs)
pois_fit = glm(crabs$Satellites ~ crabs$Width, family="poisson")
summary(pois_fit)
exp(pois_fit$coefficients[2]) # you must exponentiate the coef to find the multiplicative change per unit

# Question 4, expected value of Y
# E[Y|X] = exp(b0 + b1*X) = exp(b0)exp(b1*X)
exp(pois_fit$coefficients[1]) * exp(pois_fit$coefficients[2] * 22)

# Question 5
library(MASS)
data(quine) 
lin_fit = lm(log(Days + 2.5) ~.,data=quine)
step(lin_fit) #variable selection based on AIC, log_liklihood + |S| 

