## Download data
library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="phone.zip")
unzip("phone.zip")
setwd("./UCI HAR Dataset")
test <- read.table("./test/X_test.txt", sep="")
test_activity = read.table("./test/y_test.txt", sep = "")
test_subjects = read.table("./test/subject_test.txt", sep = "")
train <- read.table("./train/X_train.txt", sep="")
train_activity = read.table("./train/y_train.txt", sep = "")
train_subjects = read.table("./train/subject_train.txt", sep = "")
activity <- read.table("./activity_labels.txt")

## Create column to indicate train vs test subject
test$Subject_From <- 1
train$Subject_From <- 0

## Combine the files
combined <- rbind(test, train)
combined_activity <- rbind(test_activity, train_activity)
combined_subjects <- rbind(test_subjects, train_subjects)
final0 <- cbind(combined_subjects, combined_activity, combined)

## Clean up dataset names
feature <- read.table("./features.txt")
names(final0) <- c("subjectid", "activity", as.character(feature$V2), "Subject_From")

## Keep only subject ID, activity, and the features capturing means and std
final1 <- select(final0, subjectid, activity, Subject_From, contains("mean"), contains("std"))

## Merge activity labels on to data for descriptive names
final2 <- merge(final1, activity, by.x = "activity", by.y= "V1")

## Clean up the variable column labels
names(final2) <- gsub("^t", "Time", names(final2))
names(final2) <- gsub("^f", "Frequency", names(final2))
names(final2) <- gsub("V2", "ActivityDescription", names(final2))
names(final2) <- gsub("Acc", "Accelerometer", names(final2))
names(final2) <- gsub("Gyro", "Gyroscope", names(final2))
names(final2) <- gsub("Mag", "Magnitude", names(final2))
names(final2) <- gsub("-mean[(][)]-X", "MeanOfX", names(final2))
names(final2) <- gsub("-mean[(][)]-Y", "MeanOfY", names(final2))
names(final2) <- gsub("-mean[(][)]-Z", "MeanOfZ", names(final2))
names(final2) <- gsub("-mean[(][)]", "Mean", names(final2))
names(final2) <- gsub("-meanFreq[(][)]-X", "MeanFrequencyOfX", names(final2))
names(final2) <- gsub("-meanFreq[(][)]-Y", "MeanFrequencyOfY", names(final2))
names(final2) <- gsub("-meanFreq[(][)]-Z", "MeanFrequencyOfZ", names(final2))
names(final2) <- gsub("-meanFreq[(][)]", "MeanFrequency", names(final2))
names(final2) <- gsub("-std[(][)]-X", "StandardDeviationOfX", names(final2))
names(final2) <- gsub("-std[(][)]-Y", "StandardDeviationOfY", names(final2))
names(final2) <- gsub("-std[(][)]-Z", "StandardDeviationOfZ", names(final2))
names(final2) <- gsub("-std[(][)]", "StandardDeviation", names(final2))

## Average each variable for each subject and activity
final3 <- aggregate(final2, by=list(final2$subjectid, final2$ActivityDescription, final2$Subject_From), FUN=mean)

## Order the dataset by subjectid and activity
final3 <- arrange(final3, subjectid, activity)
final3 <- select(final3, -Group.1, -ActivityDescription, -Subject_From)
names(final3) <- gsub("Group.2", "ActivityDescription", names(final3))
names(final3) <- gsub("Group.3", "SubjectFrom", names(final3))

## Output the final dataset
write.csv(final3, "smartphone_tidy.csv")
