if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

# *** LOADING DATA... ***
# # TEST/TRAIN INDEPENDENT (=the same for TEST and TRAIN) DATA
# activity_labels represents the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
# Load the description of X_test$V1:$V561. Eg. V1 is tBodyAcc-mean()-X,.., V561 is angle(Z,gravityMean)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# # TEST/TRAIN DEPENDENT DATA
# X_test$V1:V561 represents the variables (observations)
# y_test$V1 represents the activities (by ID). There is no description in it, to find them we have to look at activity_labels
# subject_test$V1 and subject_train$V1 represent the observed persons grouped by test and train
# here dim(unique(subject_test)) = 9 x 1, in fact only 30% of 30 subjects are in test
# here dim(unique(subject_train)) = 21 x 1, in fact 70% of 30 subjects are in train
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# *** ALL TOGETHER ***
X_all <- rbind(X_test, X_train)
names(X_all) = features
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)

# We are interested only in mean and standard deviation
features_to_get <- grepl("mean|std", features)
X_all = X_all[,features_to_get]

# Adjust labels
y_all[,2] = activity_labels[y_all[,1]]
names(y_all) = c("Activity_ID", "Activity_Label")
names(subject_all) = "Subject_ID"

# Bind data
all_data <- cbind(as.data.table(subject_all), y_all, X_all)

id_labels   = c("Subject_ID", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(all_data), id_labels)
melt_data      = melt(all_data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, Subject_ID + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)
