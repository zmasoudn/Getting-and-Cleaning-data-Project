
library(data.table)

## reading the data

fp <- file.path("C:\\Users\\Zeynab\\Desktop\\project")
features<- data.table(read.table("features.txt"))
setnames(features, c("id", "names"))

dtXtest<- data.table(read.table("test\\X_test.txt", header=TRUE))
dtYtest<- data.table(read.table("test\\Y_test.txt", header=TRUE))

dtXtrain<- data.table(read.table("train\\X_train.txt", header=TRUE))
dtYtrain<- data.table(read.table("train\\Y_train.txt", header=TRUE))

dtSubjTrain<- data.table(read.table("train\\subject_train.txt", header=TRUE))
setnames(dtSubjTrain, c("subject"))						

dtSubjTest<- data.table(read.table("test\\subject_test.txt", header=TRUE))
setnames(dtSubjTest, c("subject"))						


## 1- Merges the training and the test sets to create one data set.

dataY<- rbind(dtYtest, dtYtrain)
setnames(dataY, "activityId")

dataS<- rbind(dtSubjTest, dtSubjTrain)

##assigning col names to our datasets
setnames(dtXtest, as.character(features$name))
setnames(dtXtrain, as.character(features$name))

dataX<- rbind(dtXtest, dtXtrain)

finaldata<- cbind(dataX, dataY, dataS)

## 2- Extracts only the measurements on the mean and standard deviation for each measurement. 

MeanStd <- grep("(mean|std)", as.character(features$name), value=TRUE)
subdata<- subset(finaldata, select=MeanStd)

## 3- Uses descriptive activity names to name the activities in the data set
dtactivity<- data.table(read.table("activity_labels.txt"))
setnames(dtactivity, c("activityId", "activityName"))

activityLabel<- factor(finaldata$activityId, labels=dtactivity$activityName)
finaldata<- cbind(finaldata, activityLabel)

## 4-Appropriately labels the data set with descriptive variable names. 

fixname<- gsub("\\(\\)","", names(finaldata))
fixname<- gsub("std","Std", fixname)
fixname<- gsub("mean","Mean", fixname)
fixname<- gsub("-","", fixname)
fixname<- gsub("fBody","FFT.Body.", fixname)
fixname<- gsub("tBody","Time.Body.", fixname)
fixname<- gsub("fGravity","FFT.Gravity.", fixname)
fixname<- gsub("tGravity","Time.Gravity.", fixname)
setnames(finaldata, fixname)

## 5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)

meltdata <- melt(finaldata, id.vars=c("activityId", "subject"))
meltdata$variable<- as.numeric(meltdata$variable)

tidydata <- dcast(meltdata, activityId + subject ~ variable, mean)

##creating submission file
write.table(tidydata, "tidydata.txt", sep=",", row.names = TRUE)
