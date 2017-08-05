#########################################################################################################################################
##
##  Week 3 - Getting and Cleaning Data Course Project
## 
##  This script does the following:
##      - Merges the training and the test sets to create one data set.
##      - Extracts only the measurements on the mean and standard deviation for each measurement.
##      - Uses descriptive activity names to name the activities in the data set.
##      - Appropriately labels the data set with descriptive variable names.
##      - From the data set in step 4, creates a second, independent tidy data set with
##        the average of each variable for each activity and each subject.
##
#########################################################################################################################################

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
    
##  Output the summarized data set to the tidy_data_set.txt file.
    
    write.table(summarized_df,"./tidy_data_set.txt",row.names = FALSE)