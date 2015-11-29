library(dplyr)
library(caret)
library(lubridate)

# --------------------------------------------------------------------------------------------------
# Question 1
# --------------------------------------------------------------------------------------------------
# Set the variable y to be a factor variable in both the training and test set. Then set the seed to
# 33833. Fit (1) a random forest predictor relating the factor variable y to the remaining variables
# and (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the
# caret package.
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

train_data <- vowel.train %>% mutate(y=as.factor(y))
test_data <- vowel.test %>% mutate(y=as.factor(y))
set.seed(33833)

rf_model <- train(y ~ ., data=train_data, method="rf")
gbm_model <- train(y ~ ., data=train_data, method="gbm")

rf_results <- predict(rf_model, test_data)
gbm_results <- predict(gbm_model, test_data)

confusionMatrix(rf_results, test_data$y)
confusionMatrix(gbm_results, test_data$y)

agree_idx <- rf_results == gbm_results
agreed_y <- rf_results[agree_idx]
agree_acc <- sum(agreed_y == test_data$y[agree_idx]) / length(test_data$y[agree_idx])

agreement <- (sum(rf_results == gbm_results & gbm_results == test_data$y) / length(test_data$y))

# rf train acc: 93.6%, test 60%
# gbm train acc: 87.9%, test 52%
# agree idx: 62.2%

# final answer
# RF Accuracy = 0.6082
# GBM Accuracy = 0.5152
# Agreement Accuracy = 0.6361


# --------------------------------------------------------------------------------------------------
# Question 2
# --------------------------------------------------------------------------------------------------
# Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf")
# , boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions
# together using random forests ("rf"). What is the resulting accuracy on the test set? Is it better
# or worse than each of the individual predictions?
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
rf_model <- train(diagnosis ~ ., data = training, method="rf")
gbm_model <- train(diagnosis ~ ., data = training, method="gbm")
lda_model <- train(diagnosis ~ ., data = training, method="lda")

rf_train_predict <- predict(rf_model, training)
gbm_train_predict <- predict(gbm_model, training)
lda_train_predict <- predict(lda_model, training)

# now create the stacked model
stacked_data <- data.frame(
    rf=rf_train_predict
    , gbm=gbm_train_predict
    , lda=lda_train_predict
    , diagnosis=training$diagnosis)
stacked_model <- train(diagnosis ~ ., data=stacked_data, method="rf")


rf_test_predict <- predict(rf_model, testing)
gbm_test_predict <- predict(gbm_model, testing)
lda_test_predict <- predict(lda_model, testing)

stacked_test_data <- data.frame(
    rf=rf_test_predict
    , gbm=gbm_test_predict
    , lda=lda_test_predict
    , diagnosis=testing$diagnosis)
stacked_predict <- predict(stacked_model, stacked_test_data)

confusionMatrix(rf_test_predict, testing$diagnosis)
confusionMatrix(gbm_test_predict, testing$diagnosis)
confusionMatrix(lda_test_predict, testing$diagnosis)
confusionMatrix(stacked_predict, testing$diagnosis)

# rf test: 76.8%, gbm: 80.5%, lda: 76.8%, stacked: 79.3%
# final answer
# Stacked Accuracy: 0.80 is better than random forests and lda and the same as boosting.

# --------------------------------------------------------------------------------------------------
# Question 3
# --------------------------------------------------------------------------------------------------
# Set the seed to 233 and fit a lasso model to predict Compressive Strength. Which variable is the
# last coefficient to be set to zero as the penalty increases? (Hint: it may be useful to look up
# ?plot.enet).
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
lasso_model <- train(CompressiveStrength ~. , data=training, method="lasso")
# plot which variables get 0'd the fastest as a function of lambda
plot.enet(lasso_model$finalModel, xvar ="penalty")

# final answer
# Cement

# --------------------------------------------------------------------------------------------------
# Question 4
# --------------------------------------------------------------------------------------------------
# Fit a model using the bats() function in the forecast package to the training time series. Then
# forecast this model for the remaining time points. For how many of the testing points is the true
# value within the 95% prediction interval bounds?
library(forecast)
dat = read.csv("data/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest = ts(testing$visitsTumblr)

model <- bats(y=tstrain)
prediction <- forecast(model, h = length(tstest),level = 95)
sum(tstest >= prediction$lower & tstest <= prediction$upper) / length(prediction$upper)

# final answer
# 96.1% of datapoints fall within the forecast

# --------------------------------------------------------------------------------------------------
# Question 5
# --------------------------------------------------------------------------------------------------
# Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive
# Strength using the default settings. Predict on the testing set. What is the RMSE?
library(e1071)
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
svm_model <- svm(CompressiveStrength ~ ., data=training)
test_predict <-predict(svm_model, testing)

rmse <- sqrt(sum((testing$CompressiveStrength - test_predict)^2) / length(test_predict))

# final answer
# 6.72