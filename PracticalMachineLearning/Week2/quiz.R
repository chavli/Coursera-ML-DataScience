# Question 3
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

varidx <- grep("^IL", colnames(training))
training_data <- training[, varidx]
pca <- preProcess(training_data, method="pca")
pca$trace

# Question 4
# Create a training data set consisting of only the predictors with variable names beginning with IL
# and the diagnosis. Build two predictive models, one using the predictors as they are and one using
# PCA with principal components explaining 80% of the variance in the predictors. Use method="glm" in
# the train function. What is the accuracy of each method in the test set? Which is more accurate?
library(caret)
library(AppliedPredictiveModeling)
library(dplyr)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

varidx <- grep("^IL", colnames(training))
varnames = colnames(training)[varidx]
training_data <- training[, c("diagnosis", varnames)]

model <- train(data=training_data, diagnosis~., method="glm")
pca_model <- train(data=training_data, diagnosis~., method="glm", preProcess="pca")

Y_hat <- predict(model, testing)
confusionMatrix(testing$diagnosis, Y_hat)

Y_hat <- predict(pca_model, testing)
confusionMatrix(testing$diagnosis, Y_hat)


