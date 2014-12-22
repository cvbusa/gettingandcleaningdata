## Code Book

This document describes the code inside of run_analysis.R

Note: The commenting inside of run_analysis.R is very complete and
therefore only the main segments are described in this file.

Dataset URL --- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

#### Main Segments  

1. Download the zip file to the local data directory : 'dataset.zip'

2. Unzip the zip file : 'UCI HAR Dataset/'

3. Load activity labels and load the feature (variable) labels from directory (UCI HAR Dataset/)
    + activity_labels.txt   : 'activitylabel'
    + features.txt          : 'festures'

4. Load data from test directory (UCI HAR Dataset/test) and create test data frame : 'dftest'
    + subject_text.txt  : 'testsubject'
    + y_test.txt        : 'testactivity'
    + X_test.txt        : 'testrecords'  

5. Load data from train directory (UCI HAR Dataset/train) & create train data frame : 'dftrain'
    + subject_train.txt : 'trainsubject'
    + y_train.txt       : 'trainactivity'
    + X_train.txt       : 'trainrecords'

6. Combine train and test data : 'dfall'

7. Segment mean and standard deviation columns (variables) into new data frame : 'dfmeanstd'

8. Get mean by subjects : 'dfAvgBySubject'

9. Get mean by activity : 'dfAvgByActivity'

10. Combine mean by subject and mean by activity into new data frame : 'dfAvgByActivityAndSubject'

11. Use write.table to save "tidy" data as a text file : 'tidydata.txt'

#### Extra

1. Get mean by subjects by activity : 'dfAvgByActivityBySubject'

2. Use write.table to save "tidy" data 2 as a text file : 'tidydata2.txt'

