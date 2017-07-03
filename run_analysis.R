### Download, Unzip, and Set working directory ###

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfil = '~/data/HumanActivityRecog.zip')
unzip('HumanActivityRecog.zip')
setwd('~/data/UCI HAR Dataset')


### Install dplyr if necessary and import dplyr ###

if ('dplyr' %in% rownames(installed.packages()) == FALSE) {install.packages('dplyr')}
library(dplyr)

### Name variables (data frames) ###

features = read.table('~/data/UCI HAR Dataset/features.txt')
act_labels = read.table('~/data/UCI HAR Dataset/activity_labels.txt')

train_set = read.table('~/data/UCI HAR Dataset/train/X_train.txt')
train_labels = read.table('~/data/UCI HAR Dataset/train/y_train.txt')
test_set = read.table('~/data/UCI HAR Dataset/test/X_test.txt')
test_labels = read.table('~/data/UCI HAR Dataset/test/y_test.txt')

sub_train = read.table('~/data/UCI HAR Dataset/train/subject_train.txt')
sub_test = read.table('~/data/UCI HAR Dataset/test/subject_test.txt')


### Questions ###

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### 1
new_set = rbind(train_set, test_set)

### 2
mean_index = grep('mean[()]', features$V2)
std_index = grep('std', features$V2)

mean_std_measurements = new_set[, c(mean_index, std_index)]

### 3
train_labels = mutate(train_labels, activity_names = act_labels$V2[V1])
test_labels = mutate(test_labels, activity_names = act_labels$V2[V1])
comb_act_labels = rbind(train_labels, test_labels)

comb_subjects = rbind(sub_train, sub_test)

new_set_wlabels = cbind('Activity Names' = comb_act_labels$activity_names, 'Subject Names' = comb_subjects$V1, mean_std_measurements)

### 4
names(new_set_wlabels) = gsub('V','', names(new_set_wlabels))

for (i in seq(1:(length(new_set_wlabels)-2))) {
  names(new_set_wlabels)[i+2] = as.character(features$V2[as.numeric(names(new_set_wlabels)[i+2])])
}

### 5

final_dataset = new_set_wlabels[,3:length(new_set_wlabels)] %>% group_by(new_set_wlabels$`Activity Names`, new_set_wlabels$`Subject Names`) %>% summarise_all(funs(mean))
names(final_dataset)[1] = 'Activity Names'
names(final_dataset)[2] = 'Subject Names'  

### Export as .txt file ###
write.table(final_dataset, file = '~/data/GettingAndCleaningDataProject.txt', row.names = FALSE)
  
  
