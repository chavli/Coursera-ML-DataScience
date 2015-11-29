# Confidence Intervals & P-Values

# Assume nothing is going on, how unusual is the estimate we calculated?
# H0 - null hypothesis, test statitic's real value is 0.

# given a test statistics p_hat, the p_value is the area under the curve > p_hat and < -p_hat
# p-value < .05 (significant)
# p-value < .01 (strongly significant)
# p-value < .001 (very significant)

# statistically significant, scientifically significant, practically significant


# report confidence intervals for a statistics and the p-value of that statistic 

# NOTE: samples used to calculate p-values must be drawn from the same set (not independent)

# indepedent (no relationship)
x = rnorm(20); y = rnorm(20)
linfit = lm(x ~ y)
summary(linfit)
confint(linfit)

# dependent 
x = rnorm(20); y = rnorm(20, mean=x)
linfit = lm(x ~ y)
summary(linfit)
confint(linfit)


