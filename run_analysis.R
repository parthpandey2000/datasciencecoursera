##Including Libraries of Packages we are going to use

library(dplyr)

##Checking whether the file already exists. 
##If not, it will download the file from the given link.
##It will also unzip the compressed file.

if (!file.exists("UCI HAR Dataset")) { fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
}

##Now we will read the required datasets from the downloaded folder,
##and assign it to variables

feature <- read.table("UCI HAR Dataset/features.txt", col.names = c("no.","funct"))
subTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "sub")
subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "sub")
##setting column names as the functions read from features.txt
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature$funct)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature$funct)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

##Now we merge the training and tests data table to form a single data table.
##Row-binding training and tests data to generate a single data set for each of X,Y and Subjects of X&Y.

Sub <- rbind(subTrain, subTest)
xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)

##Column-binding the Subject,X&Y data to form a single large merged data table
mergedData <- cbind(Sub, yData, xData)

##selecting only required columns from merged data and look for terms "mean" and "std".
mergedData2 <- mergedData %>% select(sub, id, contains("mean"), contains("std"))

##Changing Id of merged data to corresponding activity
mergedData2$id <- activity[mergedData2$id, 2]

##Changing column names from abbreviations or shortcut forms to more readable and descriptive names
names(mergedData2)[2] = "Activity"
names(mergedData2)<-gsub("gravity", "Gravity", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("Acc", "Accelerometer", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("Gyro", "Gyroscope", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("-freq()", "Frequency", names(mergedData2), ignore.case = T)
names(mergedData2)<-gsub("BodyBody", "Body", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("Mag", "Magnitude", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("-std()", "STD", names(mergedData2), ignore.case = T)
names(mergedData2)<-gsub("^t", "Time", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("-mean()", "Mean", names(mergedData2), ignore.case = T)
names(mergedData2)<-gsub("^f", "Frequency", names(mergedData2),ignore.case = T)
names(mergedData2)<-gsub("tBody", "TimeBody", names(mergedData2),ignore.case = T )
names(mergedData2)<-gsub("angle", "Angle", names(mergedData2),ignore.case = T)

##Grouping data on the basis of Subjects and corresponding activities.
##Then summarizing according to mean of each Subjects and Activities
Ready_DataSet <- mergedData2 %>%
  group_by(sub, Activity) %>%
  summarise_all(list(mean))

##looking at final Tidy data 
str(Ready_DataSet)

write.table(Ready_DataSet, "G&CD_Week4_Final.txt", row.name=FALSE)


