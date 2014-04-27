mypearassignment
================

You can run script by calling source("run_analysis.R")

Make sure to set working directory first before calling the script

The script reads data from directory Samsung data so make sure it is not blank

Samsung data must contain UCI HAR Dataset and UCI HAR Dataset must contain test and train directory and other files which we all downloaded for implementing this task

source code is tested and documented properly

The source code is doing the following task

1) Reads all test, train, features, activities data
2) It combines all data into one big dataframe
3) assigs column names to the dataframe
4) creates column for activity name in the dataset
5) extracts mean, std, subject and output columns from dataset
6) creates tidy data set with the average of each variable for each activity and each subject
7) write the tidy data into tidydata.txt in current working directory