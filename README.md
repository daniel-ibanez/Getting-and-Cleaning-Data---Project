# Getting and Cleaning Data - Project
## Wearable Computing - From Raw data to Tidy data

### Objective:
***
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

Source obtained from: 

>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

More information for source data:

>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Source data delivered as a collection of text files of which the following were used:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
***

The final objective of this project is to derive form this raw data a tidy data set that contains the means of the std and mean variables summarized by subject and activity name.

run_analysis.R takes in the raw data and follows the following steps:

+ Import the raw data to R

+ Merge both Train and Test data sets

+ Filter to include only variables pertaining to mean or standard deviation

+ Include a descriptive name for the Activities

+ Label the data set with descriptive variable names

+ Derive a tidy data set that contains only the Subject, Activity Name and mean for all variables

`dplyr` was extensively used throughout the process. During the process, several data sets were created from where and new data sets were built upon on further steps. This is an inefficient use of memory but was done so for clarity and to help with the understanding of the process. 

***
The attached Codebook contains a more detailed analysis of the process and the functions used as well as a descriptions of the data sets variables involved. Furthermore, the code was commented for clarity.