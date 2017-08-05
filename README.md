---
title: "README.md"
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
These "path" variables were then used an input to the read.table functions that were used to store the data sets into data frames.  The raw data sets did not include headers and the data was separated by spaces, thus the read.table function was used to read in the raw data sets while using the "sep" and "col.names" options to provide headers as obtained from the features_labels.txt file.  "col.names" was also used to statically assign the column names of the "subjects" and "activity" data sets. The sub, as.list, and tolower functions were also used to clean, standardize, and provide more descriptive headers for the columns of the data sets. This script substitutes "Frequency." to all column headers that started with "f".  Similary, it substitutes "Time." to all column headers that started with "t".  The cbind function was used to merge the "test" data sets together (x_test.txt, y_test.txt, and subject_test.txt).  Similarly, the cbind function was used to merge the "train" data sets together (x_train.txt, y_train.txt, and subject_train.txt).  Once these two data sets (merge_test and merge_train) were created, the final step was to use the rbind function to merge the "test" and "train" data sets into one common data set called merge_all.  The dplyr select function was used to retreive only the columns that contained "mean" and "std" in the variable name.  These columns were also then combined with column headers containing "subjects" and "activity" using cbind. Indexing was also used to provide the mapping lookup assignments that were provided in the activity_labels.txt file.  The data frame values were replaced to more descriptive activity names. For example, "1" was mapped to "WALKING" within the data set.  The columns were also re-ordered so that the first column was "subjects", the second column was "activity" and the remaing columns contained the measurement data. "The result was a single, merged data set for all "means" and "standard deviation" related data that also consisted. descriptive column headers. Finally, chaining was used with the dplyr group_by and summarize_each functions to provide a tidy data set that contained the mean for each variable grouped by activity and group.  This tidy data set is stored in the summarized_df data frame which is written to the ./tidy_data_set.txt file.    

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
    + This tidy data set is stored in the summarized_df data frame which is written to the ./tidy_data_set.txt file.  
