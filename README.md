==================================================================
Human Activity Recognition Using Smartphones Dataset 
Getting and Cleaning Script (run_analysis.R)
==================================================================
Author: Weichen Wang
==================================================================
This document aims to explain underlying assumption and logic behind run_analysis.R.
==================================================================
Assumption:
1. run_analysis.R file will read UCI HAR Dataset under the condition that current working directory has "UCI HAR Dataset" folder. Inside the folder, "train" and "test" folders are also present.
2. Mean and standard deviation extracted does not include those variables of meanFreq(). Only mean() and std() are included in the final tidy data set.
==================================================================
run_analysis.R:
1. Read raw data files into memory (features.txt, activity_labels.txt, X_train.txt, y_train.txt, X_test.txt, y_test.txt, subject_train.txt, subject_test.txt)
2. Add subject and label columns into training and testing sets.
3. Merge training and testing sets.
4. Changing column names into descriptive feature names.
5. Extract mean and std columns from merged table.
6. Calculate average of each feature variable in merged table for each subject and each activity.
7. Export the final tidy data table into .txt file for future processing and analysis.