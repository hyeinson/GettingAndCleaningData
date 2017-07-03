code book that describes the variables, the data, and any transformations or work that you performed 
to clean up the data called CodeBook.md

**The source files and brief descriptions of the data frames that appear in run_analysis.R are described below:**

features: “features.txt”
	lists 561 features (561 x 2)

act_labels: “activity_labels.txt” 
	lists 6 activities (6 x 2)


train_set: “train/X_train.txt” 
	training set (7352 x 561)

train_labels: “train/y_train.txt” 
	training labels (7352 x 1); 
	labels range 1-6 as seen in act_labels
	
test_set: “test/X_test.txt” 
	test set (2947 x 561)

test_labels: “test/y_test.txt”
	test labels (2947 x 1)
	labels range 1-6 as seen in act_labels


sub_train: “train/subject_train.txt” 
	identifies the subject (7352 x 1)
	range 1-30

sub_test: “test/subject_test.txt” 
	identifies the subject (2947 x 1)
	range 1-30


**Other variables are described below:**

new_set: combines 'train_set' and 'test_set' data frames by rows

mean_index: list of indices that contains "mean()" from the data frame 'features' (sought through the second column of 'features', V2)

std_index: list of indices that contains "std()" from the data frame 'features' (sought through the second column of 'features', V2)

mean_std_measurements: a subset of data frame 'new_set' that only contains the measurements on the mean and standard deviation for each measurement

comb_labels: combines 'train_labels' and 'test_labels' by rows; each observation matches that of 'new_set' and 'mean_std_measurements'

new_set_wlabels: combines the second column of 'comb_labels' with 'mean_std_measurements' by columns

final_dataset: a tidy form of data frame of 'new_set_wlabels'; summarises (averages) each variable for each activity and each subject


**Transformations**

'train_labels' was initially the original data frame read from "train/y_train.txt" but was transformed to have a second column 
that lists more descriptive names of activity for each entry of the first column. The new column is named 'activity_names'

'test_labels' was initially the original data frame read from "test/y_test.txt" but was transformed to have a second column 
that lists more descriptive names of activity for each entry of the first column. The new column is named 'activity_names'

The names of most columns of 'new_set_wlabels' were in the form of 'V###' where ### denote numerical values. 
The letter 'V' is removed from each where applicable in order to make the column names numerical. 
Then, each numerical column name was searched through the 'features' data frame to make each column name more descriptive.

The first column of 'final_dataset' was changed to 'Activity Names'

The 'final_dataset' was exported as a .txt file ('~/data/GettingAndCleaningDataProject.txt')
