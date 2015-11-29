library(caret)
library(lubridate)
library(tidyr)
library(ggplot2)
library(dplyr)

pml_write_files = function(x){
    n = length(x)
    for(i in 1:n){
        filename = paste0("test_predictions/problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
    }
}

# --------------------------------------------------------------------------------------------------
# ---- 1. Pre-processing + Exploratory Analysis
# --------------------------------------------------------------------------------------------------
# outcome variable: classe
raw_train <- read.csv("data/pml-training.csv")

# some problems:
# remove rows where new_window = "yes"
# remove metadata columns
#   X, user_name, raw_timestamp_part_1, raw_timestamp_part_2
#   cvtd_timestamp, new_window, num_window
raw_train <- raw_train %>% select(-(X:num_window))

# near zero variance features
# NA and NULL values
# #DIV/0! and missing values and collection errors?

# features with missing / incomplete data that arent marked as NA. in this case, these values
# are represented by an empty string: ""
featureMissing <- sapply(raw_train, function(x) {sum(x == "" & !is.na(x)) / length(x)})
missing_flag <- featureMissing >= .95
train_data <- raw_train[, !missing_flag]

# features that are mostly NA (>=95% NA)
featureSparsity <- sapply(train_data, function(x) { sum(is.na(x)) / length(x)})
na_flag <- featureSparsity >= .95
train_data <- train_data[, !na_flag]

# feature names that have new zero variance
nzv_idx <- nearZeroVar(train_data)
if(length(nzv_idx)) {
    train_data <- train_data[, -nzv_idx]
}

# remove the one outlier from the training data: X = 5373
# based on histogram analysis of heavily skewed variabes (gyros_dumbbell_z)
train_data <- train_data[-5373, ]

train_y <- train_data %>% select(classe)
train_X <- train_data %>% select(-classe)
input_features <- colnames(train_X)

# center and scale all data. the values in the raw data vary greatly in orders of magnitude with
# larger numbers having an disproportionate amount of influence within a model. we scale the data
# to solve this issue. centering simply gives every variable a mean of 0
standardize_params <- preProcess(train_X, method=c("center", "scale"))
train_X <- predict(standardize_params, train_X)

# there are no additional NA's to impute (fill in).

# now the the data is cleaned up and scaled, we can remove unneeded features by using PCA
pca_params <- preProcess(train_X, method="pca", thresh=.9)
pca_train_X <- predict(pca_params, train_X)

# --------------------------------------------------------------------------------------------------
# ---- 2. Model and Training Evaluation
# --------------------------------------------------------------------------------------------------
library(doParallel)
registerDoParallel(cores=4)
set.seed(12345)
pca_train_data <- cbind(pca_train_X, train_y)

K = 10
ctrl <- trainControl(method="cv", number=K, classProbs = T, allowParallel = T)
ctrl2 <- trainControl(method="oob", classProbs = T, allowParallel = T)
rf_model <- train(classe ~ ., data=pca_train_data, trControl=ctrl, method="rf")

# --------------------------------------------------------------------------------------------------
# ---- 3. Test Set Evaluation
# --------------------------------------------------------------------------------------------------
# apply training set transformations to test data
raw_test <- read.csv("data/pml-testing.csv")

problem_ids <- raw_test[, "problem_id"]

raw_test <- raw_test %>% select(-(X:num_window))                # remove metadata rows
test_X <- raw_test[, input_features]                            # only use features used by train set
test_X <- predict(standardize_params, test_X)                   # apply train set standardization params
pca_test_X <- predict(pca_params, test_X)                       # apply train set pca params
y_hat <- predict(rf_model, pca_test_X)                          # create predictions using trained model

answers <- data.frame(problem_id=problem_ids, prediction=y_hat) # answers for submission
pml_write_files(answers$prediction)