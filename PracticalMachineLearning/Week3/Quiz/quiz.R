library(AppliedPredictiveModeling)
library(caret)
library(ElemStatLearn)
library(pgmm)
library(rpart)
library(dplyr)

# --- Question 1
# 1. Subset the data to a training set and testing set based on the Case variable in the data set.
# 2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables
# and default caret settings.
data(segmentationOriginal)

training_data <- segmentationOriginal %>% filter(Case=="Train") %>% select(-Case)
test_data <- segmentationOriginal %>% filter(Case=="Test") %>% select(-Case)
set.seed(125)
model <- train(Class~., method="rpart",data=training_data)
plot(model$finalModel)
text(model$finalModel)

# B) PS, WS, PS, NA


# --- Question 2
# The bias is larger and the variance is smaller. Under leave one out cross validation K is equal
# to the sample size.

# --- Question 3
data(olive)
olive = olive[,-1]
model <- train(Area ~ ., data=olive, method="rpart")
plot(model$finalModel)
text(model$finalModel)

newdata = as.data.frame(t(colMeans(olive)))
predict(model, newdata = newdata)

# 2.783. It is strange because Area should be a qualitative variable - but tree is reporting the
# average value of Area as a numeric variable in the leaf predicted for newdata

# --- Question 4
# Set the seed to 13234 and fit a logistic regression model (method="glm", be sure to specify
# family="binomial") with Coronary Heart Disease (chd) as the outcome
# Y = chd (Coronary Heart Disease)
# x1 = age (age at onset)
# x2 = alcohol (alcohol consumption)
# x3 = obesity (obesity levels)
# x4 = tobacco (cumulative tabacco)
# x5 = typea (type-A behavior)
# x6 = ldl (low density lipoprotein cholesterol)
data(SAheart)
set.seed(8484)
train <- sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA <- SAheart[train,]
testSA <- SAheart[-train,]
set.seed(13234)

missClass = function(values,prediction) {
    sum(((prediction > 0.5)*1) != values)/length(values)
}

model <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl
               , data=trainSA,  method="glm", family="binomial")
train_response <- predict(model, trainSA)
test_response <- predict(model, testSA)

train_acc <- missClass(trainSA$chd, train_response)
test_acc <- missClass(testSA$chd, test_response)


# Question 5:
# Set the variable y to be a factor variable in both the training and test set. Then set the seed
# to 33833. Fit a random forest predictor relating the factor variable y to the remaining variables.
# Read about variable importance in random forests here:
#    http://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm#ooberr
# The caret package uses by defualt the Gini importance. Calculate the variable importance using
# the varImp function in the caret package. What is the order of variable importance?
data(vowel.train)
data(vowel.test)
vowel.train <- vowel.train %>% mutate(y=as.factor(y))
vowel.test <- vowel.test  %>% mutate(y=as.factor(y))
set.seed(33833)
model <- train(y~., data=vowel.train, method="rf")


