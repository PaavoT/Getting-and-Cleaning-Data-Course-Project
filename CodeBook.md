# Getting and Cleaning Data

**Coursera project / Code Book** 


**The logic and transformations are described in the following chapters.** 

**See also** 

 - README.md
 - the code comments in "run_analysis.R"



## Input data files (raw data)

There are two *auxiliary* files

 - "activity_labels.txt" -- 
 - "features.txt" --

and six *actual* data files

 - "y_train.txt" and "y_test.txt" -- **Activity** for each observation
 - "subject_train.txt" and "subject_test.txt" -- **Subject** for each observation
 - "X_train.txt" and "X_test.txt" -- **Feature data** (measures/observations)

In the following pictures below the *actual* data files (and corresponding data frames) are presented *"in proportion"*. So, for example, note that the **"X_train.txt"** is both *wide* and *long*; and "y_train.txt" is of the same length but is very *narrow*.


     
            !---------------------!                           !------------------!
            ! activity_labels.txt !                           ! features.txt     !
            ! 6 rows              !                           ! 561 rows         !
            !---------------------!                           !------------------!


     !---!      !---!      !--------------------------------------------------------!
     ! y !      ! s !      !   X_train.txt                              561 columns !
     ! _ !      ! u !      !                                                        !
     ! t !      ! b !      !                                                        !
     ! r !      ! j !      !                                                        !
     ! a !      ! e !      !                                                        !
     ! i !      ! c !      !                                                        !
     ! n !      ! t !      !                                                        !
     ! . !      ! _ !      !                                                        !
     ! t !      ! t !      !                                                        !
     ! x !      ! r !      !                                                        !
     ! t !      ! a !      !                                                        !
     !   !      ! i !      !                                                        !
     !   !      ! n !      !                                                        !
     !   !      ! . !      !                                                        !
     !   !      ! t !      !                                                        !
     !   !      ! x !      !                                                        !
     !   !      ! t !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      ! 7352 rows                                              !   
     !---!      !---!      !--------------------------------------------------------!
      
      
     !---!      !---!      !--------------------------------------------------------!
     ! y !      ! s !      ! X_test.txt                                 561 columns !
     ! _ !      ! u !      !                                                        !
     ! t !      ! b !      !                                                        !
     ! e !      ! j !      !                                                        !
     ! s !      ! e !      !                                                        !
     ! t !      ! c !      !                                                        !
     ! . !      ! t !      !                                                        !
     ! t !      ! - !      !                                                        !
     ! x !      ! t !      !                                                        !
     ! t !      ! e !      !                                                        !
     !   !      ! s !      !                                                        !
     !   !      ! t !      !                                                        !
     !   !      ! . !      !                                                        !
     !   !      ! t !      ! 2947 rows                                              !   
     !---!      !---!      !--------------------------------------------------------!
     

## Raw data files into Data frames 'subject_both', 'y_both' and 'X_both'

**Subject** into *data frame* **'subject_both'**. 
Subjects *for each observation* (coded with numbers 1-30) are combined from files **"subject_train.txt"** and **"subject_test.txt"** (and the column is renamed to a descriptive variable name 'subject').


**Activity labels** into *data frame* **'activity_labels'**.
Activity labels are found in the file **"activity_labels.txt"** and they serve as mapping from numeric codes (1-6) to text information (laying, sitting, standing, walking, walking downstairs, or walking upstairs). The numeric code is used in files "y_train.txt" and "y_test.txt".
Activity labels are used in the next step to replace the codes (1-6) with readable values.


**Activity** into *data frame* **'y_both'**. 
Activity codes (1-6) *for each observation* are combined from  files **"y_train.txt"** and **"y_test.txt"**. These activities are given **descriptive activity values** (laying, sitting, standing, walking, walking downstairs, or walking upstairs) by merging from 'activity_labels', and the activity code (1-6) is dropped.


**Feature data** (measures) into *data frame* **'X_both'**.
Feature data contains **all** feature **measurements** and and all **observations** (but not yet the 'subject' nor 'activity').
Feature data *for each observation* is constructed by combining files **"X_train.txt"** and **"X_test.txt"**.

**Descriptive variable names** for Features are read from **"features.txt"** and processed to contain only alpha-numeric characters (to be better used as R variables). All columns ('V1' - 'V561') are renamed to the values in "features.txt".

**=> Read files into Data frames 'subject_both', 'y_both' and 'X_both'**

     !---!      !---!      !--------------------------------------------------------!
     ! y !      ! s !      !  X_both                                    561 columns !
     ! _ !      ! u !      !                                                        !
     ! b !      ! b !      !                                                        !
     ! o !      ! j !      !                                                        !
     ! t !      ! e !      !                                                        !
     ! h !      ! c !      !                                                        !
     !   !      ! t !      !                                                        !
     !   !      ! _ !      !                                                        !
     !   !      ! b !      !                                                        !
     !   !      ! o !      !                                                        !
     !   !      ! t !      !                                                        !
     !   !      ! h !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      !                                                        !
     !   !      !   !      ! 10299 observations                                     !   
     !---!      !---!      !--------------------------------------------------------!


## **Tidy data**, phase-1

In this phase we **drop many columns** (measures) from the Feature data **'X_both'**. 
We leave only the measurements on the mean and standard deviation for each measurement. 
This is interpreted as follows: keep all variables whose name contains either 'mean' or 'std'. 

**=> Change Data frame 'X_both'**

     !---!      !---!      !----------------------!
     ! y !      ! s !      !  X_both   79 columns !
     ! _ !      ! u !      !                      !
     ! b !      ! b !      !                      !
     ! o !      ! j !      !                      !
     ! t !      ! e !      !                      !
     ! h !      ! c !      !                      !
     !   !      ! t !      !                      !
     !   !      ! _ !      !                      !
     !   !      ! b !      !                      !
     !   !      ! o !      !                      !
     !   !      ! t !      !                      !
     !   !      ! h !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      !                      !
     !   !      !   !      ! 10299 observations   !   
     !---!      !---!      !----------------------!


## **Tidy data**, phase-2

In this phase we finalize the data set by adding columns 'activity' and 'subject'. Now the data set is complete (but not tidy): it contains 

 - identifying information: 'activity' and 'subject',
 - the feature measurements that we are interested in (mead and std),
 - and all observations (all rows).

Technically, we combine **Activity**, **Subject** and **Feature data** into a single data frame 'yX_both' (and rename one column to a descriptive variable name 'activity').

**=> Merge 3 Data frames into Data frame 'yX_both'**

     !-------------------------------------!
     !  yX_both             2 + 79 columns !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     !   .   .                             !
     ! 10299 observations                  !   
     !-------------------------------------!


## **Tidy data** into 'tidy'

In this phase we squeeze the data set from 10299 rows to 180. We do this by aggregating / summing. We create an independent **tidy data** set **'tidy'** with the a) *average* of each variable for b) each activity and c) each subject.

Actually, the tidy data set contains actually only 35 rows (far less than 180) as subject are taking part only in one or two activities.
So, rows with missing (NA) aggregates are dropped / non existing. 

**=> Aggregate Data frame 'yX_both' into Data frame 'tidy'**

     !-------------------------------------!
     !  tidy                2 + 79 columns !
     !   .   .                             !
     !   .   .                             !
     ! 35 rows                             !   
     !-------------------------------------!


As in R object:

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
     


**Preview of the tidy data:** From the table (below) we can see that most subjects perform only
one activity, and the rest perform only two activities.

As everybody is not taking part of every activity, we might not see 
the 30x8=180 combinations (or rows) in the tidy data set.

Side note: We are speaking about the *wide form* of the tidy data that has 
all the measures as columns (in contrast to the *melted* data set
with every measure on separate rows).

