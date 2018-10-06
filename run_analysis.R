library(dplyr)

## Data url and file name

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "Dataset.zip"

if(!file.exists(filename)) {
  download.file(fileurl,filename, mode="wb")
} else {print("Already downloaded")}

datapath <- "UCI HAR Dataset"
if(!file.exists(datapath)){
  unzip(filename)
} else {print("Already unzipped")}

## Read data

trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingValues <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt")

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testValues <- read.table("UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")

## Read the features and activity labels

features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## All preparatory data has been read
## Now start tidying the disparate sets of data into a single tidy set
## First, merge the training and test data sets

mergedDataset <- rbind(
  cbind(trainingSubjects, trainingValues, trainingLabels),
  cbind(testSubjects, testValues, testLabels)
)


## Next, need to assign column names to this merged data set
## source for these names should be from
## (a) Subjects column can just be named as "Subjects"
## (b) 561 variable names should come from the features dataset
## (c) Labels are the different activities detected which should come 
## the second column of activities data set, called V2

colnames(mergedDataset) <- c("Subject", features[,2], "Activity")

## Second point in assignment
## Extract only the columns which have mean and std dev values
## need to do a pattern search through the column names
## We still want the Subject and Activity columns of course

subsetColumns <- grepl("subject|activity|mean|std", colnames(mergedDataset),
                       ignore.case = TRUE)

## use this subset to trim the merged data set

mergedDataset <- mergedDataset[,subsetColumns]

## Third point in assignment
## Replace the activity identifiers with the descriptive activity names
## This should be from the activities data set

mergedDataset$Activity <- factor(mergedDataset$Activity, labels = activities[,2])


## Fourth point in assignment
## Appropriately label the data set with descriptive variable names
## One clear need is to remove special characters -() etc from the column names

# first fetch the col names
datacols <- colnames(mergedDataset)

# Remove special characters
datacols <- gsub("[\\(\\)-]","", datacols)

#Expand some abbreviations
datacols <- gsub("^t","time", datacols)
datacols <- gsub("^f","freq", datacols)
datacols <- gsub("Acc","Accelerometer", datacols)
datacols <- gsub("Gyro","Gyroscope", datacols)
datacols <- gsub("mean","Mean", datacols)
datacols <- gsub("std","StdDev", datacols)
datacols <- gsub("Mag","Magnitude", datacols)
datacols <- gsub("BodyBody","Body", datacols)

# Set the cleaned names back in the data set
colnames(mergedDataset) <- datacols

## Fifth task in assignment
## Create another tidy data set with the average of each variable
## for each activity and each subject

mergedAverages <- mergedDataset %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))

## Write this dataset to a txt file
write.table(file = "tidy_data.txt", mergedAverages, row.names = FALSE, quote = FALSE)






