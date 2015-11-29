setwd("/home/cha/Coursera/DataAnalysisII/Week_6/")


# Question 3
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Then fit a logistic regression model with Coronary Heart Disease (chd) as the outcome and 
# age at onset 
# current alcohol consumption
# obesity levels
# cumulative tabacco
# type-A behavior
# low density lipoprotein cholesterol 
# as predictors. 
log_fit = glm(chd ~ age + alcohol + obesity + tobacco + typea + ldl, family="binomial", data=trainSA)
train_Y = predict(log_fit, type="response")
test_Y = predict(log_fit, newdata=testSA, type="response")

# error function
missClass = function(truth ,prediction){sum(((prediction > 0.5)*1) != truth)/length(truth)}

train_error = missClass(trainSA$chd, train_Y)
test_error = missClass(testSA$chd, test_Y)

# Queston 4
library(tree)
library(pgmm)
data(olive)
olive = olive[,-1]

tree_fit = tree(Area ~ Palmitic + Palmitoleic + Stearic + Oleic + Linoleic + Linolenic + Arachidic + Eicosenoic, data=olive)



  
