# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The files

- `activity_labels.txt` represents the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
- `features.txt` is the descriptions of *X_test$V1:$V561*. Eg. V1 is tBodyAcc-mean()-X,.., V561 is angle(Z,gravityMean)
- `test`
  - `test\X_test.txt` contains the tests that are 30% of the total observations. Each row has 561 variables that are described in `features.txt`
  - `test\y_test.txt` contains the activites of the test data. So it has the same number of rows as `test\X_test.txt`. Each row reports the observed activity by ID, the related description is in `activity_labels.txt`
  - `test\subject_test.txt` contains the person IDs observed for the test reported in `test\X_test.txt`. So it has the same number of rows as `test\X_test.txt`.
- `train`
  - `train\X_train.txt` contains the trainings that are 70% of the total observations. Each row has 561 variables that are described in `features.txt`
  - `train\y_train.txt` contains the activites of the training data. So it has the same number of rows as `train\X_train.txt`. Each row reports the observed activity by ID, the related description is in `activity_labels.txt`
  - `train\subject_train.txt` contains the person IDs observed for the training reported in `train\X_train.txt`. So it has the same number of rows as `train\X_train.txt`.

## the process used in `run_analysis.R`

1. Loads TEST and TRAIN INDEPENDENT (=the same for TEST and TRAIN) DATA:
  * the *activity_labels* that represents the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
  * the *features* that are the descriptions of X_test$V1:$V561. Eg. V1 is tBodyAcc-mean()-X,.., V561 is angle(Z,gravityMean)
2. Loads the TEST and TRAIN DATA SETS:
  * *X_test*$V1:V561 represents the variables (observations)
  * *y_test*$V1 represents the activities (by ID). There is no description in it, to find them we have to look at *activity_labels*
  * the same for training data *X_train* and *y_train*
  * *subject_test*$V1 and *subject_train*$V1 represent the observed persons grouped by test and train
    * here *dim(unique(subject_test))* = 9 x 1, in fact only 30% of 30 subjects are in test
    * here *dim(unique(subject_train))* = 21 x 1, in fact 70% of 30 subjects are in train
3. Puts TRAN and TEST data in one dataset
4. Extract the columns of interests
5. Adjusts the column labels
6. Binds data and calculates mean by variable, activity, subject
