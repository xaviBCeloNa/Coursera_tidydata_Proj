## Below function creates tidy data set by making use of plyr and reshape2 packages.
## Tidy Datset requirements are each variable in one column, each observation on a different row, each table to consitute only one observation kind
## Firstly merges the training and test data sets to create one dataset.
## Create a list type of dataset with features, activity labels, test & train dataset in matrix form
## Measures data by using mean and standard deviation and merges the datasets
## Replaces with descriptive headers and writes into output text file

run_analysis <- function() {
  
  library(plyr)
  library(reshape2)
  

  run_analysis_folder <- "UCI HAR Dataset"
  data_set <- list()   ##Dataset Of List type
  
  ##Load Features into dataset
  data_set$features <- read.table(paste(run_analysis_folder, "features.txt", sep="/"), col.names=c('id', 'name'), stringsAsFactors=FALSE)
  
  ##Load Activity Features into datset
  data_set$activity_labels <- read.table(paste(run_analysis_folder, "activity_labels.txt", sep="/"), col.names=c('id', 'Activity'))
  
  
  ##Load Test Dataset
  data_set$test <- cbind(subject=read.table(paste(run_analysis_folder, "test", "subject_test.txt", sep="/"), col.names="Subject"),
                         y=read.table(paste(run_analysis_folder, "test", "y_test.txt", sep="/"), col.names="Activity.ID"),
                         x=read.table(paste(run_analysis_folder, "test", "x_test.txt", sep="/")))
  
  
  ##Load Train Dataset
  data_set$train <- cbind(subject=read.table(paste(run_analysis_folder, "train", "subject_train.txt", sep="/"), col.names="Subject"),
                          y=read.table(paste(run_analysis_folder, "train", "y_train.txt", sep="/"), col.names="Activity.ID"),
                          x=read.table(paste(run_analysis_folder, "train", "X_train.txt", sep="/")))
  
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement
  tidy_dataset <- rbind(data_set$test, data_set$train)[,c(1, 2, grep("mean\\(|std\\(", data_set$features$name) + 2)]
  
  ## Uses descriptive activity names
  names(tidy_dataset) <- c("Subject", "Activity.ID", replace_func(data_set$features$name[grep("mean\\(|std\\(", data_set$features$name)]))
  
  
  ## Merges data sets
  tidy_dataset <- merge(tidy_dataset, data_set$activity_labels, by.x="Activity.ID", by.y="id")
  tidy_dataset <- tidy_dataset[,!(names(tidy_dataset) %in% c("Activity.ID"))]
  
  ## Wite Output file
  write.csv(tidy_dataset, file = "tidy_dataset.txt",row.names = FALSE)
  
}



replace_func <- function(col_name) {
  col_name <- gsub("tBody", "Time.Body", col_name)
  col_name <- gsub("tGravity", "Time.Gravity", col_name)
  col_name <- gsub("fBody", "FFT.Body", col_name)
  col_name <- gsub("fGravity", "FFT.Gravity", col_name)
  col_name <- gsub("\\-mean\\(\\)\\-", ".Mean.", col_name)
  col_name <- gsub("\\-std\\(\\)\\-", ".Std.", col_name)
  col_name <- gsub("\\-mean\\(\\)", ".Mean", col_name)
  col_name <- gsub("\\-std\\(\\)", ".Std", col_name)
  
  
  return(col_name)
}

