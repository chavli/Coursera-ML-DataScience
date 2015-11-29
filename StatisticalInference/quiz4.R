# Question 1 --------------------------------------------------------
baseline = c(140, 138, 150, 148, 135)
week2 =  c(132, 135, 151, 146, 130)
# paired two sided t-test
# null hypothesis, no difference
t.test(week2, baseline, mu=0, paired=T)


# Question 2 --------------------------------------------------------
# n = 9, mu = 1100cc, sd=30cc
# alpha = .05, two sided

mu = 1100
sd = 30
n=9
t_score = qt(.975,df = n-1)
confinf = mu + c(-1, 1) * t_score * sd / sqrt(n)
# 1076.94 1123.06


# Question 3 --------------------------------------------------------
# n = 4, 3 of 4 people chose coke over pepsi
# p-value one-sided exact test

# binomial trial, n=4, successes = 3, but discrete and we want 3 and 4 so q = 2 (calculate strictly
# greater than). assume a 50% chance for coke or pepsi. one-sided, lower tail = F
pbinom(q=2, size = 4, lower.tail = F, prob=.5)

# Question 4 --------------------------------------------------------
# rate = 1 per 100 days, observed rate 10 per 1787 days ( 0.5595971 per 100 days).
# one-sided p-value for the relevant test that this hospital is below the standard
# poisson distribution, also discrete. and strict comparisons
# lambda = expected rate * observation time
ppois(q = 10, lambda = 17.87, lower.tail = T)

# Question 5 --------------------------------------------------------
# paired two sided t-test. 18 total people, 9 per group
# mu diff for treament group -3
# mu diff for placebo group 1
# delta = 4,null hyp = no diff
# pooled variance (similar variances)
pt(q=4, df=8, lower.tail = T) *2


# Question 6 --------------------------------------------------------
# Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc.
# Would you reject in a two sided 5% hypothesis test of H0:μ=1,078?
# no reject

# Question 7 --------------------------------------------------------
# n = 100, volume loss -.01 sd = .04mm
# 5% one-sided test null hyp = no loss (0mm)
# whats the power
# t-distributon
power.t.test(n = 100, delta = .01, sd = .04, sig.level = .05, alternative="one.sided", type="one.sample")
#      One-sample t test power calculation
#               n = 100
#           delta = 0.01
#              sd = 0.04
#       sig.level = 0.05
#           power = 0.7989855
#     alternative = one.sided


# Question 8 --------------------------------------------------------
# volume loss -.01 sd = .04mm
# 5% one-sided test null hyp = no loss (0mm), 90% power
# what's the n
# t-distributon
power.t.test(power=.9, delta = .01, sd = .04, sig.level = .05, alternative="one.sided", type="one.sample")
#      One-sample t test power calculation
#               n = 138.3856
#           delta = 0.01
#              sd = 0.04
#       sig.level = 0.05
#           power = 0.9
#     alternative = one.sided

# Question 9 --------------------------------------------------------
# As you increase the type one error rate, α, what happens to power?
# power also increases


