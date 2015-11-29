setwd("/home/cha/Coursera/DataAnalysisII/HW2/")

library(cvTools)
library(boot)
source("code/uniformPredictor.R")
source("code/categoricalError.R")

load("data/samsungData.rda")

test_group = c(27, 28, 29, 30)



measurement_data = samsungData[, 1:561]
subject = samsungData$subject
outcomes = as.factor(samsungData$activity)

testing_data = samsungData[ samsungData$subject %in% test_group, ]
training_data = samsungData[ !(samsungData$subject %in% test_group), ]


K = 10
cv_sets = sample(1:K, size=nrow(training_data), replace=T)
cv_datasets = split(training_data, cv_sets)

error_v = rep(0, K)
conf_mat_v = c(rep(0, 36))

for( k in 1:K ){
  cv_data = cv_datasets[[k]]
  truth = cv_data$activity
  predictions = uniformPredictor(length(truth), unique(outcomes))
  
  error = categoricalError(truth, predictions)
  error_v[k] = error
  conf_mat = table(truth, predictions)
  flat = array(conf_mat)
  conf_mat_v = conf_mat_v + flat
  
  print("==========================================")
  output = paste("Error:", error)
  print(output)
  print(conf_mat)
}

avg_conf_mat = matrix(conf_mat_v / 10, nrow = 6, ncol=6)
avg_error = mean(error_v)

truth = testing_data$activity
predictions = uniformPredictor(length(truth), unique(outcomes))
test_error = categoricalError(truth, predictions)

if(FALSE){
  # bootstrap
  B = 1000
  bs_error_v = rep(0, B)
  bs_conf_mat_v = c(rep(0, 36))
  
  for( b in 1:B){
    sample_data = sample(training_data, size=nrow(training_data)/2, replace=T)
    truth = sample_data$activity
    predictions = uniformPredictor(length(truth), unique(outcomes))
    
    bs_error_v[b] = categoricalError(truth, predictions)
  }
}
