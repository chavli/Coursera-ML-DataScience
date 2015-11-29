setwd("/home/cha/Coursera/DataAnalysisII/HW2/")

library(cvTools)
library(boot)
library(tree)
source("code/uniformPredictor.R")
source("code/categoricalError.R")

load("data/samsungData.rda")

REDUCED = 100
K = 10
B = 100

measurement_data = samsungData[, 1:561]
subject = samsungData$subject
outcomes = as.factor(samsungData$activity)

centered_data = scale(measurement_data, scale=T, center=T)
pca_data = prcomp(centered_data)

testing_data = centered_data[ subject %in% test_group, ]
testing_outcomes = array (outcomes [ subject %in% test_group ])
training_data = centered_data[ !(subject %in% test_group), ]
training_outcomes = array(outcomes[!(subject %in% test_group) ])

used_pcs = pca_data$rotation[, 1:REDUCED]
reduced_training= data.matrix(training_data) %*% data.matrix(used_pcs)
reduced_training = data.frame( reduced_training ) 

cv_sets = sample(1:K, size=nrow(reduced_training), replace=T)


error_v = rep(0, K)
conf_mat_v = c(rep(0, 36))

for( k in 1:K ){
  holdout_data = reduced_training[ cv_sets == k, ]
  used_data = reduced_training[ cv_sets != k, ]
  
  truth = training_outcomes[cv_sets != k]
  tree_fit = tree(as.factor(truth) ~ ., data = used_data)
  
  truth = training_outcomes[cv_sets == k]
  predictions = predict(tree_fit, newdata = holdout_data)
  
  #extract the actual predictions
  predictions = colnames(predictions)[apply(predictions, 1, which.max)]
  error = categoricalError(truth, predictions)
  
  
  error_v[k] = error
  conf_mat = table(truth, predictions)
  flat = array(conf_mat)
  conf_mat_v = conf_mat_v + flat

}
avg_conf_mat = matrix(conf_mat_v / 10, nrow = 6, ncol=6)
avg_error = mean(error_v)

# TEST DATASET
reduced_testing= data.matrix(testing_data) %*% data.matrix(used_pcs)
reduced_testing = data.frame( reduced_testing ) 

predictions = predict(tree_fit, newdata = reduced_testing)
predictions = colnames(predictions)[apply(predictions, 1, which.max)]
test_error = categoricalError(testing_outcomes, predictions)


#bootstrap
# bootstrap
bs_error_v = rep(0, B)
bs_conf_mat_v = c(rep(0, 36))

for( b in 1:B){
  idx = sample(nrow(reduced_training),  .9 * nrow(reduced_training) )
  sample_data = reduced_training[ idx,  ]
  truth = training_outcomes[idx]
  
  tree_fit = tree(as.factor(truth) ~ ., data = sample_data)
  
  truth = training_outcomes[-idx]
  eval_data = reduced_training[ -idx,  ]
  predictions = predict(tree_fit, newdata = eval_data)
  
  #extract the actual predictions
  predictions = colnames(predictions)[apply(predictions, 1, which.max)]
  error = categoricalError(truth, predictions)
  
  bs_error_v[b] = categoricalError(truth, predictions)
}


