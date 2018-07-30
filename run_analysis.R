## Load libraries
##Karen McCall
##July 29, 2018

library(dplyr)
library(stringr)

##read in the files into a table

  trainsubject <- read.table("train/subject_train.txt")
  trainx <- read.table("train/X_train.txt")
  trainy <- read.table("train/Y_train.txt")

  testsubject <- read.table("test/subject_test.txt")
  testy <- read.table("test/Y_test.txt")
  testx <- read.table("test/X_test.txt")
  
  features <- read.table("features.txt")
  activity <- read.table("activity_labels.txt")
  
##Add a common ID to each table for cross referencing
  idtest <- c(1:nrow(testx))
  testx <- mutate(testx, idtest)
  testy <- mutate(testy, idtest)
  testsubject <- mutate(testsubject, idtest)
  idtrain <- c(1:nrow(trainx))
  trainx <- mutate(trainx, idtrain)
  trainy <- mutate(trainy, idtrain)
  trainsubject <- mutate(trainsubject, idtrain)
  
##Add column names tables
  xcolumns <- as.character(features$V2)
  xcolnames <- c(xcolumns,"id")
  colnames(testx) <- c(xcolnames)
  colnames(trainx) <- c(xcolnames)
  colnames(trainy) <- c("labels", "id")
  colnames(testy) <- c("labels", "id")
  colnames(trainsubject) <- c("subjectid", "id")
  colnames(testsubject) <- c("subjectid", "id")

##1  
##Merge the tables
 ##Test
  testsubjecty <- merge(testsubject,testy)
  testsubjectyx <- merge(testsubjecty, testx)
 ##Train
  trainsubjecty <- merge(trainsubject,trainy)
  trainsubjectyx <- merge(trainsubjecty, trainx)
  
##Combine Test and Train tables
  test_train <- rbind(testsubjectyx, trainsubjectyx)
  
##Update id variable
  id1 <- c(1:nrow(test_train))
  test_train <- mutate(test_train, id = id1)
  
#2
## Extract the colunm names with mean and std
  meanstd_test_train <- select(test_train,id, subjectid, labels, grep("mean|std",names(test_train), value = TRUE))
  meanstd_test_train <- select(test_train,grep("mean|std",names(test_train), value = TRUE))
  
#3
##renamed the activity table columns to match the test_train labels column
  colnames(activity) <- c("labels","labelactivity")
##joined the test_train and activity tables to list the activity type based ont he labels column  
  test_trainactivity <- left_join(test_train,activity)
##Rearranged the columns to put the labels and labelsactivity next to each other
  test_trainactivity <- select(test_trainactivity,1:3, 565, 4:564)

##4
##modify the column names to be more descriptive and remove special characters
  currentcolnames <- names(test_trainactivity)
  testname1 <- gsub("^f","freq",currentcolnames)
  testname1 <- gsub("^t","time",testname1)
  testname1 <- gsub("\\(","",testname1)
  testname1 <- gsub("\\)","",testname1)
  testname1 <- gsub("\\,","",testname1)
  testname1 <- gsub("\\-","\\.",testname1)
 
##update table with the new column names 
  colnames(test_trainactivity) <- c(testname1)
  
  
#5
  ##Group data by subject id and then by activity
  test_trainbysubjectactivity <- group_by(test_trainactivity, subjectid, labelactivity)

  ##summarize the results and take the mean of each activity
  test_trainsummary <- summarise_all(test_trainbysubjectactivity, funs(mean))
  
  ##remove the id variable and rearranged the data by subjectid and labels
  test_trainsummary <- select(test_trainsummary,-id)
  test_trainsummary <- arrange(test_trainsummary, subjectid, labels)