# "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
# "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

#dataDir <-"./data"
dataDir <-"."
if (!file.exists(dataDir)) {
        dir.create(path = dataDir)
}

# download file to the data directory
strURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
strFile <-"dataset.zip"
strPathFile <-file.path(dataDir, strFile, fsep = "/")
if(!file.exists(strPathFile)) {
        download.file(url = strURL, destfile = strPathFile, method = "curl", mode = "wb")
}

# unzip the file to the data directory
unzip(zipfile = strPathFile, exdir = dataDir)

### load activity labels and load the feature (variable) labels
subDir <-"UCI HAR Dataset"

pathfile <-file.path(dataDir, subDir, "activity_labels.txt")
activitylabel <-read.csv(file = pathfile, header = F, sep = " ")
names(activitylabel) <-c("activitylabel", "activitylabeldesc")
str(activitylabel)

pathfile <-file.path(dataDir, subDir, "features.txt")
features <-read.csv(file = pathfile, header = F, sep = " ", stringsAsFactors = F)
names(features) <-c("VarID","VarName")
features[,1] <-paste("V", features[,1], sep = "")
str(features)

### load data from test directory
subDir <-"UCI HAR Dataset/test"

# load subject id for test subjects
pathfile <-file.path(dataDir, subDir, "subject_test.txt", fsep = "/")
testsubject <-read.csv(file = pathfile, header = F)
names(testsubject) <-"subjectid"
# add type variable 
testsubject$subjecttype <-as.factor("test")
str(testsubject)

# load activity label
pathfile <-file.path(dataDir, subDir, "y_test.txt", fsep = "/")
testactivity <-read.csv(file = pathfile, header = F)
names(testactivity) <-"activitylabel"
str(testactivity)

activitylabel
table(testactivity)
# merge (add column) with activity labels
testactivity <-merge(x = testactivity, y = activitylabel, all.x = T )
table(testactivity)

# load observation records
pathfile <-file.path(dataDir, subDir, "X_test.txt", fsep = "/")
testrecords <-read.table(file = pathfile, header = F, colClasses = "numeric")
# merge  or add column for activity labels
testactivity <-merge(x = testactivity, y = activitylabel, all.x = T )

# create main data frame
dftest <-data.frame(testsubject,testactivity,testrecords)

### load data from train directory
subDir <-"UCI HAR Dataset/train"

# load subject id for train subjects
pathfile <-file.path(dataDir, subDir, "subject_train.txt", fsep = "/")
trainsubject <-read.csv(file = pathfile, header = F)
names(trainsubject) <-"subjectid"
# add type variable
trainsubject$subjecttype <-as.factor("train")
str(trainsubject)

# load activity label
pathfile <-file.path(dataDir, subDir, "y_train.txt", fsep = "/")
trainactivity <-read.csv(file = pathfile, header = F)
names(trainactivity) <-"activitylabel"
str(trainactivity)

activitylabel
table(trainactivity)
# merge  or add column for activity labels
trainactivity <-merge(x = trainactivity, y = activitylabel, all.x = T )
table(trainactivity)

# load observation records
pathfile <-file.path(dataDir, subDir, "X_train.txt", fsep = "/")
trainrecords <-read.table(file = pathfile, header = F, colClasses = "numeric")

# create main data frame
dftrain <-data.frame(trainsubject,trainactivity,trainrecords)

### combine train and test data
dfall <-rbind(dftrain,dftest)
str(dfall)

# update variable names
names(dfall)
names(dfall)[5:565] <-features$VarName
names(dfall)

### segment mean and standard deviation columns into new data frame dfmeanstd
meanstdcolumns <-grep("mean|std", names(dfall), ignore.case = T)
dfmeanstd <-dfall[, c(1:4,meanstdcolumns)]

names(dfmeanstd)
str(dfmeanstd)

# get mean by subjects
dfAvgBySubject <-aggregate(x = dfmeanstd[,c(-1:-4)],
                                by = list(dfmeanstd$subjectid),
                                FUN = mean)
# update name of Group.1 variable
names(dfAvgBySubject)[1] <-"RecordID"
# convert Record ID (Subject ID) to factor
dfAvgBySubject[,1] <-as.factor(dfAvgBySubject[,1])
# add Record Type variable of Subject
dfAvgBySubject <-cbind(RecordType ="Subject", dfAvgBySubject)
dfAvgBySubject[,1] <-as.factor(dfAvgBySubject[,1])

# get mean by activity
dfAvgByActivity <-aggregate(x = dfmeanstd[,c(-1:-4)],
                           by = list(dfmeanstd$activitylabeldesc),
                           FUN = mean)
# update name of Group.1 variable
names(dfAvgByActivity)[1] <-"RecordID"
# add Record Type variable of Activity
dfAvgByActivity <-cbind(RecordType ="Activity", dfAvgByActivity)

# combine mean by subject and mean by activity
dfAvgByActivityAndSubject <-rbind(dfAvgByActivity,dfAvgBySubject)

### use write.table to save "tidy" data as a text file (without row names)
strFile <-"tidydata.txt"
strPathFile <-file.path(strFile)
write.table(x = dfAvgByActivityAndSubject, file = strPathFile, row.names = F)



################################################################################## 

# get mean by subjects by activity
dfAvgByActivityBySubject <-aggregate(x = dfmeanstd[,c(-1:-4)], 
                           by = list(dfmeanstd$activitylabeldesc,dfmeanstd$subjectid),
                           FUN = mean)
# update name of Group.1 variable and Group.2 variable
names(dfAvgByActivityBySubject)[1:2] <-c("Activity","RecordID")

### use write.table to save "tidy" data as a text file (without row names)
strFile <-"tidydata2.txt"
strPathFile <-file.path(strFile)
write.table(x = dfAvgByActivityBySubject, file = strPathFile, row.names = F)

#### Seems that most subjects (1 thru 30) performed only 1 activity
#### and that no subjects performed more than 2 activities.
#### Is this a good dataset to work on???

table(dfmeanstd$subjectid, dfmeanstd$activitylabeldesc)

#    LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
# 1       0       0        0     347                  0                0
# 2       0       0        0     302                  0                0
# 3       0       0        0     341                  0                0
# 4       0       0        0     194                  0              123
# 5       0       0        0     302                  0                0
# 6       0       0        0     236                  0               89
# 7       0       0        0       0                  0              308
# 8       0       0        0       0                  0              281
# 9       0       0        0       0                  0             2883
# 10      0       0        0       0                234               60
# 11      0       0        0       0                  0              316
# 12      0     134        0       0                186                0
# 13      0     327        0       0                  0                0
# 14      0       0        0       0                244               79
# 15      0       0        0       0                328                0
# 16      0       0        0       0                366                0
# 17      0     320        0       0                 48                0
# 19      0     360        0       0                  0                0
# 20    156       0      198       0                  0                0
# 21      0     408        0       0                  0                0
# 22      0     198      123       0                  0                0
# 23      0       0      372       0                  0                0
# 24    381       0        0       0                  0                0
# 25      0       0      409       0                  0                0
# 26      0       0      392       0                  0                0
# 27    298       0       78       0                  0                0
# 28    382       0        0       0                  0                0
# 29    344       0        0       0                  0                0
# 30    383       0        0       0                  0                0

table(dftrain$activitylabeldesc, dftrain$subjectid)
#                      1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30
# LAYING               0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 298 382 344 383
# SITTING              0   0   0   0   0   0   0   0   0   0 320 360 408 198   0   0   0   0   0   0   0
# STANDING             0   0   0   0   0   0   0   0   0   0   0   0   0 123 372 409 392  78   0   0   0
# WALKING            347 341 302 236   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
# WALKING_DOWNSTAIRS   0   0   0   0   0   0   0 244 328 366  48   0   0   0   0   0   0   0   0   0   0
# WALKING_UPSTAIRS     0   0   0  89 308 281 316  79   0   0   0   0   0   0   0   0   0   0   0   0   0

table(dftest$activitylabeldesc, dftest$subjectid)
#                      2   4   9  10  12  13  18  20  24
# LAYING               0   0   0   0   0   0   0 156 381
# SITTING              0   0   0   0 134 327  30   0   0
# STANDING             0   0   0   0   0   0 334 198   0
# WALKING            302 194   0   0   0   0   0   0   0
# WALKING_DOWNSTAIRS   0   0   0 234 186   0   0   0   0
# WALKING_UPSTAIRS     0 123 288  60   0   0   0   0   0

