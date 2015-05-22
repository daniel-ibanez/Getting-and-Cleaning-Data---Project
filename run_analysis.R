setwd("C:/Users/daniel.ibanez/Google Drive/Coursera/Getting Data/Project/UCI HAR Dataset")

# Load Train tables
subject_Train <- read.table("./train/subject_train.txt", header=FALSE)
label_Train <- read.table("./train/y_train.txt", header=FALSE)
set_Train <- read.table("./train/X_train.txt", header=FALSE)

# Load Test tables
subject_Test <- read.table("./test/subject_test.txt", header=FALSE)
label_Test <- read.table("./test/y_test.txt", header=FALSE)
set_Test <- read.table("./test/X_test.txt", header=FALSE)

# Load headers for variables in set
header_Set <- read.table("./features.txt",head=FALSE)

# Rename column labels for Train tables
# subject and activity tables were labeled manually
# set table labeled from header_set 
names(subject_Train) <- c("Subject")
names(label_Train) <- c("Activity")
names(set_Train) <- header_Set[,2]

# Rename column labels for Test tables
# subject and activity tables were labeled manually
# set table labeled from header_set 
names(subject_Test) <- c("Subject")
names(label_Test) <- c("Activity")
names(set_Test) <- header_Set[,2]

# Side Note:
# Possible improvement: Personally I would have added another column to identify the source of each row in the aggregated data.
# During deep analysis this could help identify the validity of each source (Test and Train).

# Merge all Train tables into data_Train
data_Train <- cbind(subject_Train, label_Train, set_Train)

# Merge all Test tables into data_Test
data_Test <- cbind(subject_Test, label_Test, set_Test)

# Combination  data_Train and data_Test into a single table
data_Full <- rbind(data_Test, data_Train)

# Use dplyr to clean data
library(dplyr)

# Fix column names to valid R names (dplyr select wont work otherwhise)
valid_colnames <- make.names(names=names(data_Full), unique=TRUE, allow_ = TRUE)
# Column names replaced with valid R names
names(data_Full) <- valid_colnames

# Filter only Subject, Activity anf varialbles dealing with mean and std.
# As suggested in the Discussion Forum, fields such as "angle(tBodyAccJerkMean),gravityMean)" were not considered
# Only fields which endedn in mean or std were considered.
data_Final <- select(data_Full, matches("Subject"), matches("Activity"), contains(".mean."), contains(".std."))

# The names for the activities are read into a table
names_Activity <- read.table("./activity_labels.txt",header = FALSE)
# The table is relabeled to allow for a easy merge with the data_Final
colnames(names_Activity) = c("Activity", "Activity.Name")

# Merge into the data_Fianl table the table with the Activity Names
data_Final <- merge(data_Final, names_Activity, by = "Activity")

# Redefine Column Names to more descriptive names
# Process automated by replacing acronyms and cleaning the names
# Maintanin valid R names to allow for further work in R
names(data_Final) <- gsub("[.]{2,3}",".",names(data_Final)) # Replaces ... and ... with .
names(data_Final) <- gsub("[.]$","",names(data_Final)) # Eliminate . when at end of column name
names(data_Final) <- gsub("^t","Time",names(data_Final)) # Replace names starting with t with Time
names(data_Final) <- gsub("^f","Frequency",names(data_Final)) # Replace names starting with f with Frequency
names(data_Final) <- gsub("Acc","Acceleration",names(data_Final)) # Replace Acc with Acceleration
names(data_Final) <- gsub("Mag","Magnitude",names(data_Final)) # Replace Mag with Magnitude
names(data_Final) <- gsub("Gyro","Gyroscope",names(data_Final)) # Replace Gyro with Gyroscope

# Tidy up data
# Group by Subject and Activity.Name to prepare data_Tidy
data_Tidy <- group_by(data_Final, Subject, Activity.Name, add=TRUE)
# Summarize for means of variables 
data_Tidy <- summarise_each(data_Tidy,funs(mean),matches("std"), matches("mean"))

#Generate tidy_data output file as requested in instruction
write.table(data_Tidy, "tidy_data.txt", row.name=FALSE)
