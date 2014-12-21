# Code Book

This document describes the code segments inside of run_analysis.R

Note: the commenting inside of run_analysis.R is very complete and
therefore only the main segments are described in this file.

URL for dataset --- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

* download the zip file to the local data directory

* unzip the file

* load activity labels and load the feature (variable) labels : "UCI HAR Dataset"

* load data from test directory : "UCI HAR Dataset/test"

* load data from train directory : "UCI HAR Dataset/train"

* combine train and test data

* segment mean and standard deviation columns into new data frame

* get mean by subjects

* get mean by activity

* combine mean by subject and mean by activity

* use write.table to save "tidy" data as a text file

* get mean by subjects by activity

* use write.table to save "tidy" data 2 as a text file

