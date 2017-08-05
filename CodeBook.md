---
title: "CodeBook.md"
output: github_document
---

## Script name
run_analysis.R

## Summary
This document provides details for the run_analysis.R script that is used in Getting and Cleaning Data Course Project.
The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
This script assumes that the various input files are already downloaded to a working directory (./UCI HAR Dataset) and extracted as follows:  
    + ./UCI HAR Dataset/test/X_test.txt  
    + ./UCI HAR Dataset/test/y_test.txt  
    + ./UCI HAR Dataset/test/subject_test.txt  
    + ./UCI HAR Dataset/train/X_train.txt  
    + ./UCI HAR Dataset/train/y_train.txt  
    + ./UCI HAR Dataset/train/subject_train.txt  
    + ./UCI HAR Dataset/activity_labels.txt  
    + ./UCI HAR Dataset/features.txt

This project includes merges and manipulates various data sets that were collected from wearable computing accelerometer measurements as described here:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

This script also utilizes and loads the dplyr package to aid in the manipulation and cleaning of the raw data.

## Study Design

This script utilizes and loads the dplyr package to aid in the manipulation and cleaning of the raw data.
Several variables were used to store the paths to the various data sets that were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
These "path" variables were then used an input to the read.table functions that were used to store the data sets into data frames.  The raw data sets did not include headers and the data was separated by spaces, thus the read.table function was used to read in the raw data sets while using the "sep" and "col.names" options to provide headers as obtained from the features_labels.txt file.  "col.names" was also used to statically assign the column names of the "subjects" and "activity" data sets. The sub, as.list, and tolower functions were also used to clean, standardize, and provide more descriptive headers for the columns of the data sets. This script substitutes "Frequency." to all column headers that started with "f".  Similary, it substitutes "Time." to all column headers that started with "t".  The cbind function was used to merge the "test" data sets together (x_test.txt, y_test.txt, and subject_test.txt).  Similarly, the cbind function was used to merge the "train" data sets together (x_train.txt, y_train.txt, and subject_train.txt).  Once these two data sets (merge_test and merge_train) were created, the final step was to use the rbind function to merge the "test" and "train" data sets into one common data set called merge_all.  The dplyr select function was used to retreive only the columns that contained "mean" and "std" in the variable name.  These columns were also then combined with column headers containing "subjects" and "activity" using cbind. Indexing was also used to provide the mapping lookup assignments that were provided in the activity_labels.txt file.  The data frame values were replaced to more descriptive activity names. For example, "1" was mapped to "WALKING" within the data set.  The columns were also re-ordered so that the first column was "subjects", the second column was "activity" and the remaing columns contained the measurement data. "The result was a single, merged data set for all "means" and "standard deviation" related data that also consisted. descriptive column headers. Finally, chaining was used with the dplyr group_by and summarize_each functions to provide a tidy data set that contained the mean for each variable grouped by activity and group.  This tidy data set is stored in the summarized_df data frame.    

## Input
This link provides the raw data for the project.  This includes several data sets including x_test.txt, y_test.txt, x_train.txt, y_train.txt, subject_test.txt, subject_train.txt, activity_labels.txt, and features.txt files.  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
+ ./UCI HAR Dataset/test/X_test.txt  
    + ./UCI HAR Dataset/test/y_test.txt  
    + ./UCI HAR Dataset/test/subject_test.txt  
    + ./UCI HAR Dataset/train/X_train.txt  
    + ./UCI HAR Dataset/train/y_train.txt  
    + ./UCI HAR Dataset/train/subject_train.txt  
    + ./UCI HAR Dataset/activity_labels.txt  
    + ./UCI HAR Dataset/features.txt

## Output
The run_analysis.R script produces a tidy data set stored in the summarized_df data frame that accomplishes the following:  
    + Merges the various training and test sets into one data set (merge_all variable).  
    + Extracts only the measurements on the mean and standard deviation for each measurement.  
    + Uses descriptive activity names for each of the activities in the data set.  
    + Appropriately labels the data set with descriptive variable names.  
    + Creates a second, independent tidy data set (summarized_df) that contains the average (mean) of each variable for each activity and each subject.  

## Variables
This section describes the variables that were used within the r_analysis.R script.

Variable Name           | Variable Description / Purpose
------------------------|--------------------------------------------------------------------------------------------------------------------
x_test_data_path        | Contains the path to the x_test.txt file that was provided as one of the raw input files.  
y_test_data_path        | Contains the path to the y_test.txt file that was provided as one of the raw input files.  
subject_test_data_path  | Contains the path to the subject_test.txt file that was provided as one of the raw input files.  
x_train_data_path       | Contains the path to the x_train.txt file that was provided as one of the raw input files.  
y_train_data_path       | Contains the path to the y_train.txt file that was provided as one of the raw input files.  
subject_train_data_path | Contains the path to the subject_train.txt file that was provided as one of the raw input files.  
activity_labels_path    | Contains the path to the activity_labels.txt file that was provided as one of the raw input files.  
features_path           | Contains the path to the features.txt file that was provided as one of the raw input files.  
activity_labels         | Contains the data frame that stores the data set from activity_labels.txt file.  
features_labels         | Contains the list that stores the data set (variable headers) from the features.txt file.  
x_test_data_df          | Contains the data frame that stores the data set from the x_test.txt file.
y_test_data_df          | Contains the data frame that stores the data set from the y_test.txt file.
subject_test_df         | Contains the data frame that stores the data set from the subject_test.txt file.
x_train_data_df         | Contains the data frame that stores the data set from the x_train.txt file.
y_train_data_df         | Contains the data frame that stores the data set from the y_train.txt file.
subject_train_df        | Contains the data frame that stores the data set from the subject_train.txt file.
merge_test              | Contains the data frame that stores the merged data sets from x_test_data_df, y_test_data_df, and subject_test_df variables.
merge_train             | Contains the data frame that stores the merged data sets from x_train_data_df, y_train_data_df, and subject_train_df variables.
merge_all               | Contains the data frame that stores the merged data sets from the merge_test and merge_train variables.
merge_mean_std          | Contains the data frame that stores the merged data sets/columns from the merge_all variable that contains "mean" or "std" in the column header.
summarized_df           | Contains the data frame that stores the mean of all of the variables/measurements that are grouped by "subject" and "activity".

## Code
The run_analysis.R code is shown below with comments in-line:

```
##  Load the dplyr package manipulate data as needed.
    
    library(dplyr)
    
##  Assign directory path to the files of each of the test and training data sets.
##  Assumes all data sets are within the "HCI HAR Dataset/test" and "HCI HAR Dataset/train" folders of the current working directory.   

    x_test_data_path <- "./UCI HAR Dataset/test/X_test.txt"
    y_test_data_path <- "./UCI HAR Dataset/test/y_test.txt"
    subject_test_data_path <- "./UCI HAR Dataset/test/subject_test.txt"
    x_train_data_path <- "./UCI HAR Dataset/train/X_train.txt"
    y_train_data_path <- "./UCI HAR Dataset/train/y_train.txt"
    subject_train_data_path <- "./UCI HAR Dataset/train/subject_train.txt"

##  Assign directory path to the activity_labels.txt file that contains the activity labels as follows:
##      1 = WALKING
##      2 = WALKING_UPSTAIRS
##      3 = WALKING_DOWNSTAIRS
##      4 = SITTING
##      5 = STANDING
##      6 = LAYING  
##  Assumes the data set is within the "HCI HAR Dataset" folder of the current working directory.    

    activity_labels_path <- "./UCI HAR Dataset/activity_labels.txt"

##  Assign directory path to the features.txt file that contains the feature labels to be used for the data set headers.
##  Assumes the data set is within the "HCI HAR Dataset" folder of the current working directory.    
        
    features_path <- "./UCI HAR Dataset/features.txt"
        
##  Assign data frame variables for the activity_labels and features labels.
##  Only interested in the 2nd column of the features.txt file.

    activity_labels <- read.table(activity_labels_path, sep = "")
    features_labels <- read.table(features_path, sep = "")[,2]
        
##  Assign descriptive labels to the variable names found in the features.txt file
##  Modify the variables starting with "f" in the name and replace with "Frequency."
##  Modify the variables starting with "t" in the name and replace with "Time."        
##  Convert the feature label headers to all lower case for consistency and readability
        
    features_labels <- sub("^f","Frequency.", features_labels)
    features_labels <- sub("^t","Time.", features_labels)
    features_labels <- as.list(tolower(features_labels))
        
##  Assign data frame variables for each of the test and training data sets. 
##  Set header = FALSE since the raw data does not contain headers.  Also set sep = BLANK since the data is separated by spaces.
        
    x_test_data_df <- read.table(x_test_data_path, sep = "",col.names = features_labels)
    y_test_data_df <- read.table(y_test_data_path, sep = "",col.names = c("activity"))
    subject_test_df <- read.table(subject_test_data_path, sep = "",col.names = c("subjects"))
    x_train_data_df <- read.table(x_train_data_path, sep = "",col.names = features_labels)
    y_train_data_df <- read.table(y_train_data_path, sep = "",col.names = c("activity"))
    subject_train_df <- read.table(subject_train_data_path, sep = "",col.names = c("subjects"))
        
##  Perform a column bind to merge the test and train data sets with the subject test and train data sets to combine the measurement and subject data.
##  Perform a row bind to merge the test and train data sets with the activity data set to combine all of the data into one data set called merge_all.         
    merge_test = cbind(x_test_data_df, subject_test_df,y_test_data_df)
    merge_train = cbind(x_train_data_df, subject_train_df,y_train_data_df)
    merge_all = rbind(merge_test,merge_train)
       
##  Use the dplyr package with the select function to get the columns that contain "mean" or "std" in the column header.
##  Perform a column bind and select functions to merge columns that contain "mean" or "std" or "subjects" or "activity" to create the merge_mean_std data frame.
        
    merge_mean_std = cbind(select(merge_all, contains("mean")),select(merge_all, contains("std")), select(merge_all, contains("subjects")),select(merge_all, contains("activity")))
        
##  Use indexing to create descriptive names for each of the activity labels.
        
    merge_mean_std$activity[merge_mean_std$activity=="1"] <- "WALKING"
    merge_mean_std$activity[merge_mean_std$activity=="2"] <- "WALKING_UPSTAIRS"
    merge_mean_std$activity[merge_mean_std$activity=="3"] <- "WALKING_DOWNSTAIRS"
    merge_mean_std$activity[merge_mean_std$activity=="4"] <- "SITTING"
    merge_mean_std$activity[merge_mean_std$activity=="5"] <- "STANDING"
    merge_mean_std$activity[merge_mean_std$activity=="6"] <- "LAYING"
        
##  Re-order the columns so that the "subjects" column is first and the "activity" column isn 2nd.
        
    merge_mean_std <- merge_mean_std[,c(87,88,3:ncol(merge_mean_std)-2)]
  
##  Use the merge_mean_std data set to create a second independent tidy data set with the average of each variable for each activity and each subject.
##  Use chaining and summarize the data by subject and activity for each variable in the merge_mean_std data set using the summarize_each function.
    
    summarized_df <- merge_mean_std %>%
        group_by(subjects,activity) %>%
        summarize_each(funs(mean))
```