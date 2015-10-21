# ============================================================================
# Getting and Cleaning Data (in Data Science Specialization)
# ============================================================================
# 
# PLEASE NOTE
#    This solution does NOT produce tidy data set of 180 rows (as you might expect),
#    but only 35 rows. The reason is that this solution does NOT produce 
#    a row when the "subject & activity" cobination has no feature measures.
#
#    In other words, solutions with 30 * 6 = 180 combinations (#subjects * #activities) 
#    contains also rows with NA (or zero) valued feature measures.
# 
# ============================================================================
# By PaavoT
# ============================================================================

#setwd("D:/coursera/R/getdata-012 project/Github/Getting-and-Cleaning-Data-Course-Project")

#URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#setInternet2(use = TRUE) # https requirement on Windows
#destfile <- "UCI HAR Dataset.zip"
#download.file(URL, destfile, mode="wb") # binary file

# Clear the workspace (=delete all variables).
rm(list = ls())

# Unzip the data file.
unzip("UCI HAR Dataset.zip")

# Using packege "data.table") 
#install.packages("data.table")
library(data.table)

# ---------------------
# SUBJECT into data frame 'subject_both'
#    - Combine files "subject_train.txt" and "subject_test.txt"
#    - Rename the column to a descriptive variable name 'subject'.
# ---------------------

# Combine files "subject_train.txt" and "subject_test.txt"
subject_both <- as.data.frame(rbind(
                  fread("UCI HAR Dataset/train/subject_train.txt"), 
                  fread("UCI HAR Dataset/test/subject_test.txt")))
# Rename column to a descriptive variable name 'subject'.
colnames(subject_both) <- "subject"
str(subject_both)

# ---------------------
# ACTIVITY LABELS into data frame 'activity_labels'
# ---------------------

activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
str(activity_labels)

# ---------------------
# ACTIVITY into data frame 'y_both'
#    - Combine files "y_train.txt" and "y_test.txt"
#    - Use descriptive activity names (merge the names from 'activity_labels')
# ---------------------

# Combine files "y_train.txt" and "y_test.txt"
y_both <- as.data.frame(rbind(
                fread("UCI HAR Dataset/train/y_train.txt"), 
                fread("UCI HAR Dataset/test/y_test.txt")))
str(y_both)

# Use descriptive activity names (merge the names from 'activity_labels')
y_both <- merge(y_both,activity_labels,by.x="V1",by.y="V1",all.x=TRUE)
str(y_both)
y_both <- as.factor(y_both$V2)
str(y_both)

# ---------------------
# FEATURE DATA (measures) into data frame 'X_both'
#    - Combine files "X_train.txt" and "X_test.txt"
#    - Use descriptive variable names in the features (names are derived from "features.txt")
# ---------------------

# Combine files "X_train.txt" and "X_test.txt"
X_both <- as.data.frame((rbind(
                fread("UCI HAR Dataset/train/X_train.txt"), 
                fread("UCI HAR Dataset/test/X_test.txt"))))

#write.table(X_both, file= "X_both_RAW_1.csv", sep="\t", row.names = FALSE)

# Use descriptive variable names in the features.
# The names are read from "features.txt" ...
feature_no_and_name <- fread("UCI HAR Dataset/features.txt")
feature_no_and_name
# .. and non-alfanumeric characters are replaced with underscores.
for (i in 1:nrow(feature_no_and_name)) {
    feature_no_and_name[i]$V2 <- gsub("[^[:alnum:] ]","_",feature_no_and_name[i]$V2)
}
feature_no_and_name

# Rename all of the 561 features.
for (i in 1:nrow(feature_no_and_name)) {
    colnames(X_both)[i] <- feature_no_and_name[i]$V2
}
str(X_both)

#write.table(X_both, file= "X_both_RAW_2.csv", sep="\t", row.names = FALSE)


# ---------------------
# TIDY DATA, PHASE-1
#    - Extract only the measurements on the mean and standard deviation for each measurement.
#      This is interpreted as follows: keep all variables whose name contains either 'mean' or 'std'. 
# ---------------------
X_both_all_names <- names(X_both)
X_both_chosen_names <- X_both_all_names[grepl("mean", names(X_both)) | grepl("std", names(X_both))]

X_both <- X_both[,X_both_chosen_names,drop=FALSE]

str(X_both)

#write.table(X_both, file= "X_both_RAW_3.csv", sep="\t", row.names = FALSE)

# ---------------------
# TIDY DATA, PHASE-2
#    - Combine ACTIVITY, SUBJECT and FEATURE DATA into a single data frame 'yX_both'.
#    - Rename one column to a descriptive variable name 'activity'.
# ---------------------

yX_both <- cbind(y_both, subject_both, X_both)
str(yX_both)

colnames(yX_both)[1] <- "activity"
str(yX_both)

# ---------------------
# Lets inspect the the result so far..
#    - From the table (below) we can see that most subjects perform only  
#      one activity, and the rest perform only two activities.
#
#    - As everybody is not taking part of every activity, we might not see 
#      the 30*8=180 combinations (or rows) in the tidy data set.
#        * We are speaking about the *wide form* of the tidy data that has 
#          all the measures as columns (in contrast to the *melted* data set
#          with every measure on separate rows).
# ---------------------
table(yX_both$subject, yX_both$activity)

#write.table(yX_both, file= "yX_both_PHASE_2.csv", sep="\t", row.names = FALSE)

# ---------------------
# TIDY DATA, PHASE-3
#    - Crete an independent tidy data set 'tidy' with the 
#      a) *average* of each variable for b) each activity and c) each subject.
# ---------------------

# Use lapply to calculate 
#    - means (.SD, mean) 
#    - of every feature column (.SDcols),
#    - grouped by 'activity' and 'subject' (by=)
tidy <- setDT(yX_both)[, lapply(.SD, mean), by=.(activity, subject), .SDcols=X_both_chosen_names]

# setDF convert data.frames to data.table (by reference)
setDF(tidy)

# Produce the result file 'tidy_data_set.txt'.
write.table(tidy, file= "tidy_data_set.txt", sep="\t", row.names = FALSE)

str(tidy)

# ============================================================================
# PLEASE NOTE
#    This solution does NOT produce data set of 180 rows (as you might expect),
#    but only 35 rows. The reason is that this solution does NOT produce 
#    a row when the "subject & activity" cobination has no feature measures.
#
#    In other words, solutions with 30 * 6 = 180 combinations (#subjects * #activities) 
#    contains also rows with NA (or zero) valued feature measures.
