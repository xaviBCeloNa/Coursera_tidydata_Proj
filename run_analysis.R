###############################################################
##
## run_analysis.R SCRIPT
##
###############################################################

## This script contains the following five steps

###############################################################
## Step 1: 
## Merges the training and the test sets to create one data set
## 
##    1.A Read train folder and get subject_train.txt, X_train.txt and y_train.txt
##    2.A Read test folder and get subject_test.txt, X_test.txt and y_test.txt

subjTrain<-read.table("train//subject_train.txt",col.names=c("subject")) ## Each row identifies the subject who performed the activity for each window sample
subjTest<-read.table("test//subject_test.txt",col.names=c("subject")) ## Each row identifies the subject who performed the activity for each window sample ## subjTrain and Test dimension 7352 X 1

## We merge all subject data in a single data frame
mydataSubject<-rbind(subjTrain,subjTest)

xTrain<-read.table("train//X_train.txt") ## Each column corresponds to a feature -> description in features.txt ## xTrain dimension 7352 X 561
xTest<-read.table("test//x_test.txt") ## Each Row corresponds to its Activity label (info provided in the Readme.txt) ## yTrain dimension 7352 X 1

## We merge all training and test data in a single data frame
mydata<-rbind(xTrain,xTest)



###############################################################
## Step 2: Extracts only the measurements on the mean and
##          standard deviation for each measurement.  

## We search for those feature labels with mean and std in 
featureList<-read.table("features.txt", colClasses = "character",col.names=c("ix", "labels"))["labels"] ## 561 x 
featureLabels<-featureList$labels
featureSubset<- grepl('mean\\(\\)|std\\(\\)',featureLabels)

## The definitive list only contains mean and std deviation (the other names are discarded)
featureDefList <- as.character(featureLabels[featureSubset])



###############################################################
## Step 3: Uses descriptive activity names to name the activities
##         in the data set
##  AND
##
## Step 4: Appropriately labels the data set with descriptive variable names
## 

library(plyr) ## Provide the join function

## Name the data and subset the data accordingly
colnames(mydata) <- featureLabels
mydata <- mydata[,featureSubset]

## Read in activities for train and test
activitiesTest <- read.table("test//Y_test.txt")
activitiesTrain <- read.table("train//Y_train.txt")

## We merge all training and test activity data in a single data frame
activities <- rbind(activitiesTest, activitiesTrain)
colnames(activities) <- "activityLabel"

## Recode activity values as descriptive names using the activity labels file
activityLabels<-read.table("activity_labels.txt",sep=" ",col.names=c("activityLabel","activity"))
activities<-join(activities,activityLabels,by="activityLabel",type="left")


###############################################################
## Step 5: Creates a second, independent tidy data set with the average
##         of each variable for each activity and each subject. 

library(reshape2) ## provide the melt and dcast functionality

## merge all data sets
allDataSets <- cbind(mydata, activities, mydataSubject)

## Melting data frame for reshaping
meltingDf <- melt(allDataSets, id=c("subject", "activity"), measure.vars=featureDefList)

## Reshape into tidy data frame by mean using the reshape2 package
## it is collapsed the different mean and std variables into one column then find the means for the
## variables that have the same activity and subject, then reexpand.
reshapeDf <- dcast(meltingDf, activity + subject ~ variable, mean)

## Write the tidy output file
write.table(reshapeDf,file="tidyDataset.txt")

