Getting-and-Cleaning-data-Project
=================================
My repository:
	CodeBook: describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

	Rscripts:  your script for performing the analysis

Data:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Aditional data info:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Files used:
	features.txt
	X_test.txt
	Y_test.txt
	X_train.txt
	Y_train.txt
	subject_train.txt
	subject_test.txt
	activity_labels.txt

R Packages used:
library(data.table)
library(reshape2)

Transformation:
1. Merges the training and the test sets to create one data set.
	Used cbind and r bind to merge X_test.txt, Y_test.txt, X_train.txt, Y_train.txt, subject_train.txt and subject_test.txt and create finaldata 

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	
3. Uses descriptive activity names to name the activities in the data set
Used factor command and activity_label file label the columns in the finaldata.

4. Appropriately labels the data set with descriptive variable names. 
Worked on fixing the colnames retrived from features files 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Used reshape2 to melt the data based on "activityId" and "subject" and used dcast command to the get the mean.



