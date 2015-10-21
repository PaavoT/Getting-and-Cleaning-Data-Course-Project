# Getting-and-Cleaning-Data-Course-Project
Coursera project

PLEASE NOTE
This solution does NOT produce tidy data set of 180 rows (as you might expect),
but only 35 rows. The reason is that this solution does NOT produce 
a row when the "subject & activity" cobination has no feature measures.

In other words, solutions with 30 * 6 = 180 combinations (#subjects * #activities) 
contains also rows with NA (or zero) valued feature measures.



The logic and transformations are described in the following chapters.

## SUBJECT into data frame 'subject_both'
Combine files "subject_train.txt" and "subject_test.txt"
Rename the column to a descriptive variable name 'subject'.


## ACTIVITY LABELS into data frame 'activity_labels'


## ACTIVITY into data frame 'y_both'
Combine files "y_train.txt" and "y_test.txt"
Use descriptive activity names (merge the names from 'activity_labels')


## FEATURE DATA (measures) into data frame 'X_both'
Combine files "X_train.txt" and "X_test.txt"
Use descriptive variable names in the features (names are derived from "features.txt")


## TIDY DATA, PHASE-1
Extract only the measurements on the mean and standard deviation for each measurement.
This is interpreted as follows: keep all variables whose name contains either 'mean' or 'std'. 



## TIDY DATA, PHASE-2
Combine ACTIVITY, SUBJECT and FEATURE DATA into a single data frame 'yX_both'.
Rename one column to a descriptive variable name 'activity'.

From the table (below) we can see that most subjects perform only  
one activity, and the rest perform only two activities.

As everybody is not taking part of every activity, we might not see 
the 30*8=180 combinations (or rows) in the tidy data set.
  * We are speaking about the *wide form* of the tidy data that has 
    all the measures as columns (in contrast to the *melted* data set
    with every measure on separate rows).


     LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
  1       0       0        0     347                  0                0
  2       0       0      302       0                  0                0
  3       0       0        0     341                  0                0
  4       0       0      317       0                  0                0
  5       0       0        0     302                  0                0
  6       0       0        0     325                  0                0
  7       0       0        0     308                  0                0
  8       0       0        0      99                  0              182
  9       0       0      288       0                  0                0
  10    198       0       96       0                  0                0
  11      0       0        0       0                  0              316
  12    320       0        0       0                  0                0
  13    327       0        0       0                  0                0
  14      0       0        0       0                  0              323
  15      0       0        0       0                  0              328
  16      0       0        0       0                  0              366
  17      0       0        0       0                339               29
  18    364       0        0       0                  0                0
  19      0       0        0       0                360                0
  20    354       0        0       0                  0                0
  21      0       0        0       0                408                0
  22      0      22        0       0                299                0
  23      0     372        0       0                  0                0
  24    381       0        0       0                  0                0
  25      0     409        0       0                  0                0
  26      0     392        0       0                  0                0
  27      0     376        0       0                  0                0
  28      0     206      176       0                  0                0
  29      0       0      344       0                  0                0
  30      0       0      383       0                  0                0



## TIDY DATA, PHASE-3
Crete an independent tidy data set 'tidy' with the 
a) *average* of each variable for b) each activity and c) each subject.

