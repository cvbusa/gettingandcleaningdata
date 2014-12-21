# Code Book

This document describes the code inside of run_analysis.R
Note: the commenting inside of run_analysis.R is very complete and
therefore only the highlights are described in this file.

URL for dataset ---
### "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

### download file to the data directory

### unzip the file to the data directory

### load activity labels and load the feature (variable) labels

### load data from test directory

### load data from train directory

### combine train and test data

### segment mean and standard deviation columns into new data frame dfmeanstd

### get mean by subjects

### get mean by activity

### combine mean by subject and mean by activity

### use write.table to save "tidy" data as a text file (without row names)

### get mean by subjects by activity

### use write.table to save "tidy" data as a text file (without row names)

# Seems that most subjects (1 thru 30) performed only 1 activity
# and that no subjects performed more than 2 activities.

table(dfmeanstd$subjectid, dfmeanstd$activitylabeldesc)

    LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
 1       0       0        0     347                  0                0
 2       0       0        0     302                  0                0
 3       0       0        0     341                  0                0
 4       0       0        0     194                  0              123
 5       0       0        0     302                  0                0
 6       0       0        0     236                  0               89
 7       0       0        0       0                  0              308
 8       0       0        0       0                  0              281
 9       0       0        0       0                  0             2883
 10      0       0        0       0                234               60
 11      0       0        0       0                  0              316
 12      0     134        0       0                186                0
 13      0     327        0       0                  0                0
 14      0       0        0       0                244               79
 15      0       0        0       0                328                0
 16      0       0        0       0                366                0
 17      0     320        0       0                 48                0
 19      0     360        0       0                  0                0
 20    156       0      198       0                  0                0
 21      0     408        0       0                  0                0
 22      0     198      123       0                  0                0
 23      0       0      372       0                  0                0
 24    381       0        0       0                  0                0
 25      0       0      409       0                  0                0
 26      0       0      392       0                  0                0
 27    298       0       78       0                  0                0
 28    382       0        0       0                  0                0
 29    344       0        0       0                  0                0
 30    383       0        0       0                  0                0

table(dftrain$activitylabeldesc, dftrain$subjectid)
                      1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30
 LAYING               0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 298 382 344 383
 SITTING              0   0   0   0   0   0   0   0   0   0 320 360 408 198   0   0   0   0   0   0   0
 STANDING             0   0   0   0   0   0   0   0   0   0   0   0   0 123 372 409 392  78   0   0   0
 WALKING            347 341 302 236   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
 WALKING_DOWNSTAIRS   0   0   0   0   0   0   0 244 328 366  48   0   0   0   0   0   0   0   0   0   0
 WALKING_UPSTAIRS     0   0   0  89 308 281 316  79   0   0   0   0   0   0   0   0   0   0   0   0   0

table(dftest$activitylabeldesc, dftest$subjectid)
                      2   4   9  10  12  13  18  20  24
 LAYING               0   0   0   0   0   0   0 156 381
 SITTING              0   0   0   0 134 327  30   0   0
 STANDING             0   0   0   0   0   0 334 198   0
 WALKING            302 194   0   0   0   0   0   0   0
 WALKING_DOWNSTAIRS   0   0   0 234 186   0   0   0   0
 WALKING_UPSTAIRS     0 123 288  60   0   0   0   0   0

