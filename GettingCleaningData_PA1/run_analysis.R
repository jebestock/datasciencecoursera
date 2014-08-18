#run_analysis.R
# Script for Course Project of GettingAndCleaningData-course
#
#url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#
#
#
# loading required packages
#
library(reshape2)
#
#setting directories
#
dir     <-"C:/Users/jb/Documents/R/UCI HAR Dataset/"
dir_test<-"C:/Users/jb/Documents/R/UCI HAR Dataset/test/"
dir_trai<-"C:/Users/jb/Documents/R/UCI HAR Dataset/train/"
#
# reading test data sets
#
testX<-read.table(paste(dir_test,"X_test.txt",sep=""))
testS<-read.table(paste(dir_test,"subject_test.txt",sep=""))
testA<-read.table(paste(dir_test,"y_test.txt",sep=""))
#
# reading train data sets
#
traiX<-read.table(paste(dir_trai,"X_train.txt",sep=""))
traiS<-read.table(paste(dir_trai,"subject_train.txt",sep=""))
traiA<-read.table(paste(dir_trai,"y_train.txt",sep=""))
#
# reading actvity Label names/mapping and feature names 
#
actLabels<- read.table(paste(dir,"activity_labels.txt",sep=""))
features <- read.table(paste(dir,"features.txt",sep=""))
#
# Giving columns of dataset the names from the feature file
#
colnames(testX) <- as.vector(features$V2)
colnames(traiX) <- as.vector(features$V2)
#
# now merging the 2 datasets
#
X<-rbind(testX,traiX)
#
# adding activity-label column and subject-column to respective data sets
# convertion into numeric required otherwise added column remains data.frame
#
X$Subject <- as.numeric(rbind(testS,traiS)[[1]])
X$Act     <- as.numeric(rbind(testA,traiA)[[1]])
#
# find those columns in X having the pattern "mean", "Mean" or "std" as col names
#
#meanIds <- grep("mean|Mean",features$V2)
#stdIds  <- grep("std", features$V2)
#Ids     <- sort(c(meanIds,stdIds))
Ids <- grep("mean|Mean|std",features$V2)
# don't forget the last 2 columns for subject and activity
Ids     <- c(Ids,562,563)
#
# extract respective mean/std columns
#
X_ms <- X[,Ids]
#
# replace activity integer labels in X_ms$ACT by descriptive strings
# by first converting integer range into factor variable
#
mylevels          <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
X_ms$Act          <- as.factor(X_ms$Act)
levels(X_ms$Act)  <- mylevels
#
# Now creating tidy set by averaging for each activity and each subject
#
#
# First melt data frame into 4 column dataset where the activity and subject
# columns are kept.
# The new 2 columns contain the names of the melted column-variable and 
# its variable value, respectively.
#
X_ms_melt <- melt(X_ms,id=c("Act","Subject"))
#
# compute means over each variable having a constant activity and subject value
# and reshape dataset as to have one column for each variable again.
# dcast() can do the job for us here.
#
X_ms_tidy <- dcast(X_ms_melt,Act + Subject ~ variable,mean)
#
# writing to file
#
write.table(X_ms_tidy,"./GetAndCleanCourseProjTidyData.txt",row.names=F, sep=" ")
#
# reading data back
#
#X_ms_r<-read.table("./GetAndCleanCourseProjTidyData.txt", header=T, check.names=FALSE, sep="\t")
#

