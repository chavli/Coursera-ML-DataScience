library(dplyr)

#   Instructions
#
# You should create one R script called run_analysis.R that does the following.
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement.
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names.
#   5 .From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject.

# load all the necessary data files
train_data_x = read.table("raw_data/train/X_train.txt")
test_data_x = read.table("raw_data/test/X_test.txt")

train_subjects = read.table("raw_data/train/subject_train.txt")
test_subjects = read.table("raw_data/test/subject_test.txt")

train_data_y = read.table("raw_data/train/y_train.txt")
test_data_y = read.table("raw_data/test/y_test.txt")

act_names = read.table("raw_data/activity_labels.txt")
features = read.table("raw_data/features.txt")


#   3. Uses descriptive activity names to label the activities in the data set
colnames(train_data_y) = c("activity_type")
colnames(test_data_y) = c("activity_type")
train_data_y = mutate(train_data_y, activity_type=act_names[activity_type, "V2"])
test_data_y = mutate(test_data_y, activity_type=act_names[activity_type, "V2"])

colnames(train_subjects) = c("subject_id")
colnames(test_subjects) = c("subject_id")


#   4. Appropriately labels the data set with descriptive variable names.
colnames(train_data_x) = features[, "V2"]
colnames(test_data_x) = features[, "V2"]


#   1. Merges the training and the test sets to create one data set.
#   all this is done by using the rbind and cbind functions on the necessary data frames.
all_subjects = rbind(train_subjects, test_subjects)
all_activities = rbind(train_data_y, test_data_y)

all_data = rbind(train_data_x, test_data_x)
colnames(all_data)
dim(all_data)

#   2. Extracts only the measurements on the mean and standard deviation for each measurement.
#       the regex pattern "std\\(\\)|mean\\(\\)" matches any feature name with "mean()" or "std()" in it
flags = grep(pattern = "std\\(\\)|mean\\(\\)", x = features$V2)
target_features = as.character(features$V2[flags])
all_data = all_data[, target_features]
colnames(all_data)

# add subject id and activity names to dataset
all_data = cbind(all_subjects, all_activities, all_data )

#   5 .From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject.
final_data = summarise_each(
                group_by(all_data, subject_id, activity_type)       # group measurements by subject and activity.
                , funs(mean)                                        # operation to perform on each accelerometer column.
               , `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)  # the accelormeter columns using the dplyr column range operator.

write.table(final_data, file ="results.txt", row.names=F)
