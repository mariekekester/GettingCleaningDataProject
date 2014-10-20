GettingCleaningDataProject
==========================

Samsung movement data -- script, README file and codebook to clean the data

#my solution requires the dplyr package

#####################
#Step 1
######################
##Merge the training and the test sets to create one data set

#First, read in original test datasets
#add the ytest to xtest
#add the subj to the xtest

#Then, read in original training datasets
#add the ytrain and subj to xtrain

#now the two xdatasets need to be merged (total rows should be 7352+2947 and total columns should be 563)

#final dimensions of this step should be 10299 x 563

#####################################
#Step 2
#####################################
##Extracts only the measurements on the mean and standard deviation for each measurement
#i.e. extract variables that have mean or sd in the names
#look through the variable names in the features.txt text file and write down the column number of columns to keep (ones with "mean" or "std" in the name)

#now make a keepdata variable that has just these columns from the fulldataset
#keepdata variable has 10299 obs x 88 variables
#variables 1-86 are movements, 87=activity, 88=subject

####################################
#Step 3
#####################################
#Uses descriptive activity names to name the activities in the data set
#we want the following levels:
#1            WALKING
#2   WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4            SITTING
#5           STANDING
#6             LAYING

#currently activity is coded as an integer
#so change activity to factor
#then re-code activities with names

####################################
#Step 4
#####################################
###Appropriately labels the data set with descriptive variable names
#create name vector from features.txt file
#add name vector and "activity" and "subject" as column names to the keepdata dataset

########################
#Step 5
#########################
##Create a second, independent tidy data set with the average of each variable for each activity and each subject
#we have 30 subjects each doing 6 activities = 180 rows of 86 movement variables
#final dataset should have 180 rows and 88 columns -- because of activity and subj
#I'll use functions located in the dplyr package
#group the dataset by activity and by subject
#then use summarise_each to get the mean of all columns by activity and subject
#perfect