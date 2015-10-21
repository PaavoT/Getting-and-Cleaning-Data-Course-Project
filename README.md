# Getting and Cleaning Data

**Coursera project**

PLEASE NOTE
This solution does **not** produce tidy data set of 180 rows (as you might expect),
but only 35 rows. The reason is that this solution does not produce
a row when the "subject & activity" combination has no feature measures.

In other words, solutions with 30 x 6 = 180 combinations (#subjects x #activities) 
contains also rows with NAs (or maybe zeros) feature measures.




**The logic and transformations are described in the following chapters.** 

**See also** the code comments in **run_analysis.R**

## **Subject** into data frame 'subject_both'

**Subjects** are the people (coded with numbers 1-30) that take part in various activities (laying, sitting, standing, walking, walking downstairs, or walking upstairs) and their movements are being measured by various features.

**Action:** Subjects are combined from files "subject_train.txt" and "subject_test.txt" (and the column is renamed to a descriptive variable name 'subject').


## **Activity labels** into data frame 'activity_labels'

**Activity labels** are found in the file "activity_labels.txt" and they serve as mapping from numeric codes (1-6) to text information (laying, sitting, standing, walking, walking downstairs, or walking upstairs). The numeric code is used in files "y_train.txt" and "y_test.txt".

**Action:** Activity labels are read from "activity_labels.txt" and are used in the next step.

## **Activity** into data frame 'y_both'

**Activity** contains feature measurements.

**Action:** Activities are combined from  files "y_train.txt" and "y_test.txt". These measurements are given descriptive activity names, that is, names are merged from 'activity_labels'.


## **Feature data** (measures) into data frame 'X_both'

**Feature data** is almost the complete data set: it contains all the feature measurements and and all the observations (but not yet the subject nor activity).

**Action:** Feature data is constructed by combining files "X_train.txt" and "X_test.txt"

We use descriptive variable names in the features. The names are read from "features.txt" and processed to contain only alpha-numeric characters (to be better used as R variables).


## **Tidy data**, phase-1

**Action:** in this phase we eliminate many measures (columns) from the Feature data. 

We leave only the measurements on the mean and standard deviation for each measurement. 
This is interpreted as follows: keep all variables whose name contains either 'mean' or 'std'. 


## **Tidy data**, phase-2

**Action:** in this phase we finalize the data set by adding columns 'subject' and 'activity'. Now the data set is complete (but not tidy): it contains 

 - identifying information: 'subject' and 'activity'
 - the feature measurements that we are interested in (mead and std),
 - and all the observations (all rows).

Technically, we combine **Activity**, **Subject** and **Feature data** into a single data frame 'yX_both' (and rename one column to a descriptive variable name 'activity').

**Preview of the tidy data:** From the table (below) we can see that most subjects perform only
one activity, and the rest perform only two activities.

As everybody is not taking part of every activity, we might not see 
the 30x8=180 combinations (or rows) in the tidy data set.

Side note: We are speaking about the *wide form* of the tidy data that has 
all the measures as columns (in contrast to the *melted* data set
with every measure on separate rows).


    Subject  LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
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



## **Tidy data**, phase-3

**Action:** in this phase we squeeze the data set from 10299 rows to 180. We do this by aggregating / summing. We create an independent **tidy data** set 'tidy' with the a) *average* of each variable for b) each activity and c) each subject.

Actually, the tidy data set contains actually only 35 rows (far less than 180) as rows with missing (NA) aggregates are dropped. 


    > str(tidy)
    'data.frame':   35 obs. of  81 variables:
     $ activity                       : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 6 6 6 6 ...
     $ subject                        : int  1 3 5 6 7 8 8 11 14 15 ...
     $ tBodyAcc_mean___X              : num  0.266 0.273 0.279 0.272 0.27 ...
     $ tBodyAcc_mean___Y              : num  -0.0183 -0.0179 -0.0155 -0.0176 -0.0188 ...
     $ tBodyAcc_mean___Z              : num  -0.108 -0.106 -0.106 -0.116 -0.112 ...
     $ tBodyAcc_std___X               : num  -0.546 -0.623 -0.508 -0.505 -0.578 ...
     $ tBodyAcc_std___Y               : num  -0.368 -0.48 -0.403 -0.368 -0.546 ...
     $ tBodyAcc_std___Z               : num  -0.503 -0.654 -0.646 -0.673 -0.456 ...
     ...
 
 
