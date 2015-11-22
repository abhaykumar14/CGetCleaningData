# Project for *Coursera* [Getting and Cleaning Data](https://www.coursera.org/course/getdata) Class

The data set to use in the project is described here: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Pre-requisite to run the script

1. Download the data set from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Unzip the file into a `dir path` in order to have the `UCI HAR Dataset` directory containing
	* `features.txt`
	* `subject_train.txt`
	* `subject_test.txt`
	* `test` dir
	* `train` dir
3. copy the script named ([run_analysis.R](run_analysis.R)) in `dir path` and execute it
4. the result will be in the `tidy_data.txt` file ([here the result](tidy_data.txt))

You can read more about the data and the analysis in the [code book](CodeBook.md).

## What run_analysis.R does

1. Loads TEST and TRAIN INDEPENDENT (=the same for TEST and TRAIN) DATA:
  * the *activity_labels* that represents the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
  * the *features* that are the descriptions of X_test$V1:$V561. Eg. V1 is tBodyAcc-mean()-X,.., V561 is angle(Z,gravityMean)
2. Loads the TEST and TRAIN DATA SETS:
  * *X_test*$V1:V561 represents the variables (observations)
  * *y_test*$V1 represents the activities (by ID). There is no description in it, to find them we have to look at *activity_labels*
  * *subject_test*$V1 and *subject_train*$V1 represent the observed persons grouped by test and train
    * here *dim(unique(subject_test))* = 9 x 1, in fact only 30% of 30 subjects are in test
    * here *dim(unique(subject_train))* = 21 x 1, in fact 70% of 30 subjects are in train
3. Puts TRAN and TEST data in one dataset
4. Extract the columns of interests
5. Adjusts the column labels
6. Binds data and calculates mean by variable, activity, subject
