#Getting and Cleaning Data Assignment
#my solution requires the dplyr package
library(dplyr)

#####################
#Step 1
######################
##Merge the training and the test sets to create one data set
#read in original test datasets
subj_test <- read.table("test/subject_test.txt")
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")

#so we need to add the subject column and the activites to the Xtest dataset
xtest <- cbind(xtest, ytest) #adding the ytest to xtest
xtest <- cbind(xtest, subj_test)
#now xtest has 561 movement variables, one activity variable and then the subj

#Same operations needed for the training set
#read in the data
subj_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

xtrain <- cbind(X_train, y_train, subj_train) #adding the ytrain and subj to xtrain
#now the two xdatasets need to be merged (total rows should be 7352+2947 and total columns should be 563)
fulldata <- rbind(xtrain, xtest)
dim(fulldata) #great 10299 x 563

#####################################
#Step 2
#####################################
##Extracts only the measurements on the mean and standard deviation for each measurement
#i.e. extract variables that have mean or sd in the names
#look through the variable names in the text file and write down the column number of columns to keep (ones with "mean" or "std" in the name)

#column #s to keep
#also want to keep activity (col 562) and subject (col 563) with the movement variables!
keep <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,543,552,555,556,557,558,559,560,561, 562, 563)

#now make a keepdata variable that has just these columns from the fulldataset
keepdata <- fulldata[,keep]
#great now keepdata just has variables that had mean or std in them

dim(keepdata)
#10299 obs x 88 variables
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

str(keepdata[,87])
#currently activity is coded as an integer

#change activity to factor
keepdata[,87] <- as.factor(keepdata[,87])

#re-code activities with names as detailed in the directions
levels(keepdata[,87])[levels(keepdata[,87])=="1"] <- "WALKING"
levels(keepdata[,87])[levels(keepdata[,87])=="2"] <- "WALKING_UPSTAIRS"
levels(keepdata[,87])[levels(keepdata[,87])=="3"] <- "WALKING_DOWNSTAIRS"
levels(keepdata[,87])[levels(keepdata[,87])=="4"] <- "SITTING"
levels(keepdata[,87])[levels(keepdata[,87])=="5"] <- "STANDING"
levels(keepdata[,87])[levels(keepdata[,87])=="6"] <- "LAYING"
levels(keepdata[,87])

####################################
#Step 4
#####################################
###Appropriately labels the data set with descriptive variable names

#create name vector from features.txt file
nam <- c(
        "tBodyAcc-mean()-X",
        "tBodyAcc-mean()-Y",
        "tBodyAcc-mean()-Z",
        "tBodyAcc-std()-X",
        "tBodyAcc-std()-Y",
        "tBodyAcc-std()-Z",
        "tGravityAcc-mean()-X",
        "tGravityAcc-mean()-Y",
        "tGravityAcc-mean()-Z",
        "tGravityAcc-std()-X",
        "tGravityAcc-std()-Y",
        "tGravityAcc-std()-Z",
        "tBodyAccJerk-mean()-X",
        "tBodyAccJerk-mean()-Y",
        "tBodyAccJerk-mean()-Z",
        "tBodyAccJerk-std()-X",
        "tBodyAccJerk-std()-Y",
        "tBodyAccJerk-std()-Z",
        "tBodyGyro-mean()-X",
        "tBodyGyro-mean()-Y",
        "tBodyGyro-mean()-Z",
        "tBodyGyro-std()-X",
        "tBodyGyro-std()-Y",
        "tBodyGyro-std()-Z",
        "tBodyGyroJerk-mean()-X",
        "tBodyGyroJerk-mean()-Y",
        "tBodyGyroJerk-mean()-Z",
        "tBodyGyroJerk-std()-X",
        "tBodyGyroJerk-std()-Y",
        "tBodyGyroJerk-std()-Z",
        "tBodyAccMag-mean()",
        "tBodyAccMag-std()",
        "tGravityAccMag-mean()",
        "tGravityAccMag-std()",
        "tBodyAccJerkMag-mean()",
        "tBodyAccJerkMag-std()",
        "tBodyGyroMag-mean()",
        "tBodyGyroMag-std()",
        "tBodyGyroJerkMag-mean()",
        "tBodyGyroJerkMag-std()",
        "fBodyAcc-mean()-X",
        "fBodyAcc-mean()-Y",
        "fBodyAcc-mean()-Z",
        "fBodyAcc-std()-X",
        "fBodyAcc-std()-Y",
        "fBodyAcc-std()-Z",
        "fBodyAcc-meanFreq()-X",
        "fBodyAcc-meanFreq()-Y",
        "fBodyAcc-meanFreq()-Z",
        "fBodyAccJerk-mean()-X",
        "fBodyAccJerk-mean()-Y",
        "fBodyAccJerk-mean()-Z",
        "fBodyAccJerk-std()-X",
        "fBodyAccJerk-std()-Y",
        "fBodyAccJerk-std()-Z",
        "fBodyAccJerk-meanFreq()-X",
        "fBodyAccJerk-meanFreq()-Y",
        "fBodyAccJerk-meanFreq()-Z",
        "fBodyGyro-mean()-X",
        "fBodyGyro-mean()-Y",
        "fBodyGyro-mean()-Z",
        "fBodyGyro-std()-X",
        "fBodyGyro-std()-Y",
        "fBodyGyro-std()-Z",
        "fBodyGyro-meanFreq()-X",
        "fBodyGyro-meanFreq()-Y",
        "fBodyGyro-meanFreq()-Z",
        "fBodyAccMag-mean()",
        "fBodyAccMag-std()",
        "fBodyAccMag-meanFreq()",
        "fBodyBodyAccJerkMag-mean()",
        "fBodyBodyAccJerkMag-std()",
        "fBodyBodyAccJerkMag-meanFreq()",
        "fBodyBodyGyroMag-mean()",
        "fBodyBodyGyroMag-std()",
        "fBodyBodyGyroMag-meanFreq()",
        "fBodyBodyGyroJerkMag-mean()",
        "fBodyBodyGyroJerkMag-std()",
        "fBodyBodyGyroJerkMag-meanFreq()",
        "angle(tBodyAccMean,gravity)",
        "angle(tBodyAccJerkMean),gravityMean)",
        "angle(tBodyGyroMean,gravityMean)",
        "angle(tBodyGyroJerkMean,gravityMean)",
        "angle(X,gravityMean)",
        "angle(Y,gravityMean)",
        "angle(Z,gravityMean)"
        )

#add name vector and "activity" and "subject" as column names to the keepdata dataset
colnames(keepdata) <- c(nam, "activity", "subject")
head(keepdata[,1:3])
head(keepdata[,86:88])

########################
#Step 5
#########################
##Create a second, independent tidy data set with the average of each variable for each activity and each subject

summary(keepdata$subject)
#30 subjects each doing 6 activities = 180 rows of 86 movement variables
#final dataset should have 180 rows and 88 columns

#I'll use functions located in the dplyr package
library(dplyr)

#group the dataset by activity and by subject
group <- tbl_df(keepdata)
names(group)
by_actandsubj <- group %>% group_by(activity, subject)
dim(by_actandsubj)

#then use summarise_each to get the mean of all columns by activity and subject
?summarise_each

newdf <- by_actandsubj %>% summarise_each(funs(mean))
dim(newdf) #180rows x 88columns -- that is GOOD
head(newdf[,1:4], 40)
#perfect

