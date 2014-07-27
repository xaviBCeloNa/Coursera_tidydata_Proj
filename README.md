### Human Activity Recognition Using Smartphones And Tidy Data
========================================================
### Licencing
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the
authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



### run_analysis.r

*run_analysis.r* contains the script that transform the following eight data sets: *activity_labels.txt*, *features.txt*
*subject_test.txt*, *subject_train.txt*, *X_test.txt*, *X_train.txt*, *y_test.txt*, *y_train.txt* into a single tidy data set

The script basically follows the approach recommended:
1.- Merges the training and the test sets to create one data set
2.- Extracts only the measurements on the mean and standard deviation for each measurement
3.- Uses descriptive activity names to name the activities in the data set
4.- Appropriately labels the data set with descriptive variable names
5.- Creates a independent tidy data set with the average of each variable for each activity and each subject.

Note: two libraries have been used:
1.- plyr to perform the join
2.- reshape to perform  melting and casting


### USAGE
1. Ensure the file "run_analysis.r" is in your working directory and the files used are in the same subdirectories as they came up
2. In your R console, type: 
```
source("run_analysis.r")
```


### OUTPUT EXAMPLE 
The Data set generated with the script gives a tidy data set with 68 columns and 180 rows. Here is an example output of how the dataset should look
using the head(reshapeDf)

|  activity |  subject | tBodyAcc-mean()-X    |  tBodyAcc-mean()-Y   |  tBodyAcc-mean()-Z   |
| :---------|:--------:| --------------------:| --------------------:| --------------------:|
|1   LAYING |      1   |       0.2347805      |  -0.04356225         |  -0.08520083         |
|2   LAYING |      2   |       0.2797076      |  -0.01915423         |  -0.11110411         | 
|3   LAYING |      3   |       0.2761829      |  -0.01861701         |  -0.10792901         |
|4   LAYING |      4   |       0.2811732      |  -0.01500005         |  -0.11381813         | 
|5   LAYING |      5   |       0.2740573      |  -0.02272917         |  -0.09466217         | 
