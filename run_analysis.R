################################################
## Data Science specialization, on Coursera   ##
## Getting and Cleaning Data: course project  ##
## Student : Romain Louvet,                   ##
## University of Avignon, France              ##
## first edition: 06/02/2015                  ##
## latest version : 11/02/2015                ##
################################################

## time script
T0 <- Sys.time()

###############
## libraries ##
###############
# check if already installed, else ask to install it

packs <- c("data.table","dplyr")

for(pack in packs){
  answer <- 0
  if(sum(installed.packages()==pack,na.rm=TRUE)==0){
    while(answer!="n" & answer!="y"){
      print(paste(pack, "package is not installed. Do you agree to install it? (type y/n)"))
      answer<-readline()
    }
    if(answer=="y"){install.packages(pkgs = as.character(pack))} 
  }    
}

# load library
library(dplyr)
library(data.table)
library(reshape2)

############################
## script main condition: ##
############################

print("1/4 - Loading data set...")

# it doesn't execute the script if the results already exist
if(!(exists("tidydataset"))){

  ## Variables for this script
  
  # path to 'rawdata' folder
  rawpath <- "./rawdata/UCI HAR Dataset" 
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  #############
  ## PART 0  ##
  #############
  # downloads and extracts file only if file doesnt exist
  # + saves date of downloading in a txt file
  
  if(!file.exists("./rawdata/getdata_projectfiles_UCI_HAR_Dataset.zip")){
    
    print("...downloading dataset...")
    
    # creates directories for raw and tidy data in the working directory
    dir.create("./rawdata")
    dir.create("./tidydata")
    
    # download and unzip file
    download.file(url,"./rawdata/getdata_projectfiles_UCI_HAR_Dataset.zip")
    unzip("./rawdata/getdata_projectfiles_UCI_HAR_Dataset.zip",exdir="./rawdata")
    
    # save downloading date
    file <- file("./rawdata/UCI_HAR_Dataset_downldate.txt")
    writeLines(date(), file)
    close(file)
  }
  
  ############
  ## PART 1 ##
  ############
  # load data
  
  # read subjects identified by rows, rename column 'subject', add 'set' column
  # for train and test data set
  subjecttest <- fread(paste(rawpath,"test","subject_test.txt",sep="/"))%>%
    rename(subject=V1)%>%
    mutate(set="test")
  
  subjecttrain <- fread(paste(rawpath,"train","subject_train.txt",sep="/"))%>%
    rename(subject=V1)%>%
    mutate(set="train")
  
  # read activity associated with subjects, rename column 'activity'
  activtest <- fread(paste(rawpath,"test","y_test.txt",sep="/"))%>%
    rename(activity=V1)
  
  activtrain <-fread(paste(rawpath,"train","y_train.txt",sep="/"))%>%
    rename(activity=V1)
  
  # read features labels and features values
  # (problem with separators, fread doesn't work with feature values, then
  # I used read.table);
  # labels the data set with original variable names
  
  featureslabel <- fread(paste(rawpath,"features.txt",sep="/"))$V2
  
  feattest <- read.table(paste(rawpath,"test","X_test.txt",sep="/"),
                         col.names=featureslabel)
  feattrain <- read.table(paste(rawpath,"train","X_train.txt",sep="/"),
                          col.names=featureslabel)
  
  ############
  ## PART 2 ##
  ############
  # Merges the training and the test sets to create one data set
  
  print("2/4 - Merging data set...")
  
  test <- cbind(subjecttest,activtest,feattest)
  train <- cbind(subjecttrain,activtrain,feattrain)
  
  mergedrawdataset <- rbind(test,train)
  
  ############
  ## PART 3 ##
  ############
  # tidying
  
  print("3/4 - Tidying data...")
  
  # load activity names
  activname <- fread(paste(rawpath,"activity_labels.txt",sep="/"))
  
  # correct typo (lying instead of laying) and convert to lower cases
  activname$V2<-gsub("LAYING","lying",activname$V2)%>%tolower()
  
  # replace "_" by " "
  activname$V2<-gsub("_"," ",activname$V2)
  
  # use descriptive activity names to name the activities in the data set
  mergedrawdataset <- mutate(activity=activname[][mergedrawdataset$activity]$V2,
                             mergedrawdataset)
  
  # Extracts only the measurements on the mean and 
  # standard deviation for each measurement
  
  var_rawnames <- names(mergedrawdataset)
  
  selIndex <- grepl("[Mm]ean|std",var_rawnames) & !grepl("angle",var_rawnames)
  
  colselec <- c("subject","set","activity",var_rawnames[selIndex])
  
  dataselec <- subset(mergedrawdataset, select=colselec)
  
  # appropriately labels the data set with descriptive variable names
  # (second: more descriptive variable names than original names)
  
  # get column names
  rawnames <- names(dataselec)
  tidynames <- names(dataselec)
  
  # create a list for gsub loop
  listrenames <- list(c("\\.mean\\.\\.\\.X"," X axial direction mean"),
                      c("\\.mean\\.\\.\\.Y"," Y axial direction mean"),
                      c("\\.mean\\.\\.\\.Z"," Z axial direction mean"),
                      
                      c("\\.meanFreq\\.\\.\\.X"," X axial direction frequency mean"),
                      c("\\.meanFreq\\.\\.\\.Y"," Y axial direction frequency mean"),
                      c("\\.meanFreq\\.\\.\\.Z"," Z axial direction frequency mean"),
                      
                      c("\\.std\\.\\.\\.X"," X axial direction standard deviation"),
                      c("\\.std\\.\\.\\.Y"," Y axial direction standard deviation"),
                      c("\\.std\\.\\.\\.Z"," Z axial direction standard deviation"),

                      c("tBodyBody","time domain body"),
                      c("fBodyBody","frequency domain body"),
                      
                      c("tBody","time domain body"),
                      c("fBody","frequency domain body"),
                      
                      c("tGravity","time domain gravity"),
                      
                      c("Acc"," acceleration"),
                      c("Gyro"," velocity"),
                      
                      c("Mag"," magnitude"),
                      c("\\.mean\\.\\."," mean"),
                      c("\\.std\\.\\."," standard deviation"),
                      c("Jerk"," jerk"),
                      
                      c("\\.meanFreq\\.\\."," frequency mean"),

                      c("angle\\.X\\.gravityMean\\.","angle gravity X axial direction mean"),
                      c("angle\\.Y\\.gravityMean\\.","angle gravity Y axial direction mean"),
                      c("angle\\.Z\\.gravityMean\\.","angle gravity Z axial direction mean"),
                      
                      c("\\.gravityMean\\."," gravity axial direction mean")
                      )
  
  # replace variable measure names with explicit descriptive names
  # using gsub in a for loop
  for(i in listrenames){tidynames<-gsub(i[1],i[2],tidynames)}

  # optionnal txt file: conversion table from raw names to tidy names
  # (in order to be able to check the results from previous loop)
  write.table(data.frame(rawnames,tidynames), 
              file = "./tidydata/conv_rawtidy_names.txt", row.names = FALSE)
  
  # rename colum with a for loop
  for(i in 1:length(tidynames)){setnames(dataselec,rawnames[i],tidynames[i])}
    
  # melt dataset, rename columns "variable" and "value"
  tidydataset <- melt(dataselec,id.vars=c("subject","set","activity"), 
                      measure.vars=names(dataselec)[4:length(tidynames)])%>%
    rename(signalvariablemeasure=variable)%>%
    rename(signalnormalizedvaluesmean=value)

  # From the tidy data creates a second, independent tidy 
  # data set with the average of each variable for each activity and each subject
  #
  # order result by subject, activity and signal measure variable
  # it's the final output submitted for part 1
  tidydataset <- aggregate(signalnormalizedvaluesmean~subject+set+activity+signalvariablemeasure, 
                           tidydataset, mean)%>%
    arrange(subject,activity,signalvariablemeasure)
  
  #################
  ## Final steps ##
  #################
  print("4/4 - Removing intermediate values and write tidy dataset")
  
  # write tidy dataset from previous steps, in "tidydata" folder
  write.table(tidydataset, file = "./tidydata/tidydataset.txt", row.names = FALSE)
  
  # message about the created files
  print("")
  print('conv_rawtidy_names.txt has been created in :',)
  print(paste0(getwd(),"/tidydata"))
  print("")
  print('tidydataset.txt has been created in :',)
  print(paste0(getwd(),"/tidydata"))
  
  # time script
  T1 <- Sys.time()
  print(paste("Processing lasted",round(as.numeric(T1-T0,units="secs"),2),"seconds"))
  
  # removing intermediate values
  rm(list=ls()[!(ls()=="tidydataset")])
  
}else{
  print("script result 'tidydataset' already exists")
}