
#Question 2
# Fit linear models with the yValues as outcome and a natural cubic spline model for the xValues as the covariates. 
# Fit the model with degrees of freedom equal to each integer between 1 and 10. For each model, calculate the root 
# mean squared error (RMSE) between the fitted values and the observed yValues (the rmse() function in R may help). 
# aAt what number of degrees of freedom is there the most dramatic drop in the RMSE? Why does this make sense?
#
# ANS: The RMSE drops between df=2 and df=3. This is because the sinusoidal model has one inflection points - like a cubic function.The RMSE drops between df=2 and df=3. This is because the sinusoidal model has one inflection points - like a cubic function.
library(splines)
library(Metrics)
set.seed(53535)
xValues = seq(0,2*pi,length=100)
yValues = rnorm(100) + sin(xValues)

errs = rep(0, 10)
for(i in 1:10){
  nsX = ns(xValues, df=i)
  lin_fit = lm(yValues ~ nsX)
  errs[i] = rmse(yValues, lin_fit$fitted.values)
}

# Question 3
# Calculate the 75th percentile of the Wind variable. Then set the seed to 883833 and use the one.boot function 
# with 1,000 replications to calculate the bootstrap standard error of the 75th percentile of the Wind variable.
#
#ANS: The 75th percentile is: 11.5 The bootstrap s.d. is: 0.5965868
library(simpleboot) 
data(airquality)
attach(airquality)
set.seed(883833)
results = one.boot(airquality$Wind, quantile, R=1000, probs=.75)
quantile(airquality$Wind, .75)
sd(results$t)

# Question 4
# Set the seed to 7363 and calculate three trees using the tree() function on bootstrapped samples 
# (samples with replacement). Each tree should treat the DriveTrain variable as the outcome and Price and Type 
# as covariates. Predict the value of the following data frame
#
#ANS: Front Percent of Votes = 100%
library(tree)
data(Cars93,package="MASS")
testdata = data.frame(Type = "Large",Price = 20)

for( i in 1:3){
  set.seed(7363)
  bs_sample = sample(Cars93, replace=T)
  tree_fit = tree(DriveTrain ~ Price + Type, data=bs_sample)
  outcome = predict(tree_fit, newdata=testdata)
  print(outcome)
}

# Queston 5
# Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. 
# Fit (1) a random forest predictor relating the factor variable y to the remaining variables and 
# (2) an svm predictor using the svm() function in the e1071 package. 
# What are the error rates for the two approaches on the test data set? What is the error rate when the two methods agree on a prediction?
#
#ANS: 
library(ElemStatLearn)
library(randomForest)
library(e1071)
set.seed(33833)
data(vowel.train)
data(vowel.test) 

forest = randomForest(as.factor(y) ~., data = vowel.train)
svm_fit = svm(as.factor(y) ~., data = vowel.train)

forest_outcomes = predict(forest, newdata=vowel.test)
svm_outcomes = predict(svm_fit, newdata=vowel.test)

# error rate when the two models agree is lower (whoa)
flags = forest_outcomes == svm_outcomes
agreement = svm_outcomes[flags]
targets = vowel.test$y[flags]

