# assign-smartphone
Getting and cleaning data assignment, week 4

Run run_analysis.R to perform the following steps:
1) Loads library(dplyr)
2) Smartphone data is downloaded locally from the online data repository located https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3) The required locally downloaded data is loaded into R, inlcuding:
	+ X_test.txt (results for test subjects)
	+ y_test.txt (record of activity performed for test)
	+ subject_test.txt (test subject identifier)
	+ X_train.txt (results for train subjects)
	+ y_train.txt (record of activity performed for train)
	+ subject_train.txt (train subject identifier)
	+ activity_labels.txt (description of numeric activity values)
4) Creates a  column to identify if the individual comes from the test or train dataset. Column name is temporarily Subject_From, but is later renamed to SubjectFrom which is what is output on the final tidy dataset.
5) Sets together following dataset:
	- train and test data set together using rbind()
	- train and test activity data set together using rbind()
	- train and test subject data set together using rbind()
6) Merges together the 3 datasets from step 5 using cbind(). The temporary dataset is named final0.
7) The names of the 561 features are pulled on to the final0 dataset.
8) The variables subjectid, activity, subject_from are retained, along with any features that capture a mean or standard deviation. The temporary dataset that is output is named final1. ALl feature names come from:
	+ features.txt
9) final1 has the activity referenced using a numeric identifier. To instead include a description of the activity, the labels are merged on to final1 using the file activity_labels.txt. The data final2 is output.
10) The variable names are cleaned up to be more easily readable.
11) The aggregate function is used on the final2 dataset to create mean results for all variables grouped by:
	+ subjectid, ActivityDescription, Subject_From
The output of this step is the data final3
12) Some final cleaning is completed, dropping duplicate columns and renaming:
	+ Group.2 to ActivityDescription
	+ Group.3 to SubjectFrom
13) The final3 dataset is output locally using the write.csv() function to a file named "smartphone_tidy.csv".