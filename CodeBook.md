---
title: "CodeBook - Getting and Cleaning Data Course Project"
author:
date: "Tuesday, February 12, 2015"
output: html_document
---

## Introduction

This document describes any transformations performed with "run_analysis.R" script in order to clean up a raw data set and creating a tidy data set which would meet the requirements of the "Getting and Cleaning Data Course Project" assignment.

For more informations, see "README.md"

## General script description

* the libraries used by this script are "dplyr", "data.table" and "reshape2"
* the script starts with downloading, loading and merging the raw data
* descriptive activity names are used to label the activity in the data set
* mean and std columns are selected
* the columns are renamed with more descriptive names
* the variables measures are also renamed with more descriptive names
* the data set is melted in order to get the mean of each variable measures
* finally, all intermediate values are removed; "tidydataset", a five columns and 14220 rows data set, is returned and saved in a text file

Moreover, during the execution of this script two folders are created in the working directory:

* rawdataset: contains the raw data ziped and unziped files
* tidydataset: contains the text outputs 

The outputs at the end of the script are "tidydataset" loaded in R (required), "tidydataset.txt" (required) and "conv_rawtidy_names.txt" (not required).

## Processing from raw to tidy data

Step by step, the script does the following:

* checks if the required libraries are installed (if not asks to install them with install.packages()) using a for loop, a if statement and the function installed.packages()
* loads "dplyr", "data.table" and "reshape2" using library()
* checks if the resulting tidy data set "tidydataset" already exists (if not executes the processing, else signals that "tidydataset" already exists) using a if statement and the function exists()
* downloads the data only if not already downloaded, unzips it, and creates "tidydataset" and "rawdataset" in the working directory, using download.file(), unzip(), and dir.create(). Saves the date of downloading in "UCI_HAR_Dataset_downldate.txt" (rawdata folder) using writeLines() and date()
* reads test and train data sets, names the column "subject" and "activity", and creates a column "set", using fread(), rename() and mutate()
* reads the features labels (variable measures), reads the variable measures values and names the column with the features labels previously read for train and test data set, using fread(), read.table() with argument "col.names=featureslabel"
* merges the loaded data for each set (test and train) by column and then the results by rows, using cbind() and rbind()
* load activity names, correct typo "LAYING" (replace with "lying"), convert to lower cases, replace "_" by " ", using fread(), gsub(), and tolower()
* replace the value of the column "activity" (number) of the merged data set by the descriptive activity names, using mutate()
* extracts only the measurements on the mean and standard deviation for each measurement, using names(), grepl(), subset(), and select(). See "README.md" for more explaination on the mean and std measurements selection
* renames the selected columns with more descriptive names (cf table below) using names(), list(), a for loop on a list, gsub(), a second for loop, and setnames()
* creates "conv_rawtidy_names.txt" in "tidydata" folder using write.table()
* melts the merged data set using melt(), "subject" "set" and "activity" as "id.vars" argument, and all the rest as "measure.vars" argument
* renames the resulting variables with more descriptive names using rename()
* computes average of each variable for each activity and each subject using aggregate() and order the resulting data set using arrange() in ascending order, by subject, activity and signal variables measures
* finally, writes the resulting data set, "tidydataset", in "tidydataset.txt", "tidydata" folder, using write.table()
* additionaly, allong the process, this script prints messages for each main steps and the processing time in second at the end

## Signal variables measures names conversion table

This table presents the results of the for loop using gsub() in order to replace all the original signal variables measures short names with full length explicit text. This is from the content of "conv_rawtidy_names.txt" file.

--------------------------------------------------------------
           rawnames                       tidynames           
------------------------------- ------------------------------
       tBodyAcc.mean...X        time domain body acceleration 
                                    X axial direction mean    

       tBodyAcc.mean...Y        time domain body acceleration 
                                    Y axial direction mean    

       tBodyAcc.mean...Z        time domain body acceleration 
                                    Z axial direction mean    

       tBodyAcc.std...X         time domain body acceleration 
                                  X axial direction standard  
                                          deviation           

       tBodyAcc.std...Y         time domain body acceleration 
                                  Y axial direction standard  
                                          deviation           

       tBodyAcc.std...Z         time domain body acceleration 
                                  Z axial direction standard  
                                          deviation           

     tGravityAcc.mean...X            time domain gravity      
                                acceleration X axial direction
                                             mean             

     tGravityAcc.mean...Y            time domain gravity      
                                acceleration Y axial direction
                                             mean             

     tGravityAcc.mean...Z            time domain gravity      
                                acceleration Z axial direction
                                             mean             

      tGravityAcc.std...X            time domain gravity      
                                acceleration X axial direction
                                      standard deviation      

      tGravityAcc.std...Y            time domain gravity      
                                acceleration Y axial direction
                                      standard deviation      

      tGravityAcc.std...Z            time domain gravity      
                                acceleration Z axial direction
                                      standard deviation      

     tBodyAccJerk.mean...X      time domain body acceleration 
                                 jerk X axial direction mean  

     tBodyAccJerk.mean...Y      time domain body acceleration 
                                 jerk Y axial direction mean  

     tBodyAccJerk.mean...Z      time domain body acceleration 
                                 jerk Z axial direction mean  

     tBodyAccJerk.std...X       time domain body acceleration 
                                    jerk X axial direction    
                                      standard deviation      

     tBodyAccJerk.std...Y       time domain body acceleration 
                                    jerk Y axial direction    
                                      standard deviation      

     tBodyAccJerk.std...Z       time domain body acceleration 
                                    jerk Z axial direction    
                                      standard deviation      

      tBodyGyro.mean...X         time domain body velocity X  
                                     axial direction mean     

      tBodyGyro.mean...Y         time domain body velocity Y  
                                     axial direction mean     

      tBodyGyro.mean...Z         time domain body velocity Z  
                                     axial direction mean     

       tBodyGyro.std...X         time domain body velocity X  
                                   axial direction standard   
                                          deviation           

       tBodyGyro.std...Y         time domain body velocity Y  
                                   axial direction standard   
                                          deviation           

       tBodyGyro.std...Z         time domain body velocity Z  
                                   axial direction standard   
                                          deviation           

    tBodyGyroJerk.mean...X      time domain body velocity jerk
                                    X axial direction mean    

    tBodyGyroJerk.mean...Y      time domain body velocity jerk
                                    Y axial direction mean    

    tBodyGyroJerk.mean...Z      time domain body velocity jerk
                                    Z axial direction mean    

     tBodyGyroJerk.std...X      time domain body velocity jerk
                                  X axial direction standard  
                                          deviation           

     tBodyGyroJerk.std...Y      time domain body velocity jerk
                                  Y axial direction standard  
                                          deviation           

     tBodyGyroJerk.std...Z      time domain body velocity jerk
                                  Z axial direction standard  
                                          deviation           

      tBodyAccMag.mean..        time domain body acceleration 
                                        magnitude mean        

       tBodyAccMag.std..        time domain body acceleration 
                                 magnitude standard deviation 

     tGravityAccMag.mean..           time domain gravity      
                                 acceleration magnitude mean  

     tGravityAccMag.std..            time domain gravity      
                                    acceleration magnitude    
                                      standard deviation      

    tBodyAccJerkMag.mean..      time domain body acceleration 
                                     jerk magnitude mean      

     tBodyAccJerkMag.std..      time domain body acceleration 
                                   jerk magnitude standard    
                                          deviation           

      tBodyGyroMag.mean..         time domain body velocity   
                                        magnitude mean        

      tBodyGyroMag.std..          time domain body velocity   
                                 magnitude standard deviation 

    tBodyGyroJerkMag.mean..     time domain body velocity jerk
                                        magnitude mean        

    tBodyGyroJerkMag.std..      time domain body velocity jerk
                                 magnitude standard deviation 

       fBodyAcc.mean...X            frequency domain body     
                                acceleration X axial direction
                                             mean             

       fBodyAcc.mean...Y            frequency domain body     
                                acceleration Y axial direction
                                             mean             

       fBodyAcc.mean...Z            frequency domain body     
                                acceleration Z axial direction
                                             mean             

       fBodyAcc.std...X             frequency domain body     
                                acceleration X axial direction
                                      standard deviation      

       fBodyAcc.std...Y             frequency domain body     
                                acceleration Y axial direction
                                      standard deviation      

       fBodyAcc.std...Z             frequency domain body     
                                acceleration Z axial direction
                                      standard deviation      

     fBodyAcc.meanFreq...X          frequency domain body     
                                acceleration X axial direction
                                        frequency mean        

     fBodyAcc.meanFreq...Y          frequency domain body     
                                acceleration Y axial direction
                                        frequency mean        

     fBodyAcc.meanFreq...Z          frequency domain body     
                                acceleration Z axial direction
                                        frequency mean        

     fBodyAccJerk.mean...X          frequency domain body     
                                  acceleration jerk X axial   
                                        direction mean        

     fBodyAccJerk.mean...Y          frequency domain body     
                                  acceleration jerk Y axial   
                                        direction mean        

     fBodyAccJerk.mean...Z          frequency domain body     
                                  acceleration jerk Z axial   
                                        direction mean        

     fBodyAccJerk.std...X           frequency domain body     
                                  acceleration jerk X axial   
                                 direction standard deviation 

     fBodyAccJerk.std...Y           frequency domain body     
                                  acceleration jerk Y axial   
                                 direction standard deviation 

     fBodyAccJerk.std...Z           frequency domain body     
                                  acceleration jerk Z axial   
                                 direction standard deviation 

   fBodyAccJerk.meanFreq...X        frequency domain body     
                                  acceleration jerk X axial   
                                   direction frequency mean   

   fBodyAccJerk.meanFreq...Y        frequency domain body     
                                  acceleration jerk Y axial   
                                   direction frequency mean   

   fBodyAccJerk.meanFreq...Z        frequency domain body     
                                  acceleration jerk Z axial   
                                   direction frequency mean   

      fBodyGyro.mean...X        frequency domain body velocity
                                    X axial direction mean    

      fBodyGyro.mean...Y        frequency domain body velocity
                                    Y axial direction mean    

      fBodyGyro.mean...Z        frequency domain body velocity
                                    Z axial direction mean    

       fBodyGyro.std...X        frequency domain body velocity
                                  X axial direction standard  
                                          deviation           

       fBodyGyro.std...Y        frequency domain body velocity
                                  Y axial direction standard  
                                          deviation           

       fBodyGyro.std...Z        frequency domain body velocity
                                  Z axial direction standard  
                                          deviation           

    fBodyGyro.meanFreq...X      frequency domain body velocity
                                 X axial direction frequency  
                                             mean             

    fBodyGyro.meanFreq...Y      frequency domain body velocity
                                 Y axial direction frequency  
                                             mean             

    fBodyGyro.meanFreq...Z      frequency domain body velocity
                                 Z axial direction frequency  
                                             mean             

      fBodyAccMag.mean..            frequency domain body     
                                 acceleration magnitude mean  

       fBodyAccMag.std..            frequency domain body     
                                    acceleration magnitude    
                                      standard deviation      

    fBodyAccMag.meanFreq..          frequency domain body     
                                    acceleration magnitude    
                                        frequency mean        

  fBodyBodyAccJerkMag.mean..        frequency domain body     
                                 acceleration jerk magnitude  
                                             mean             

   fBodyBodyAccJerkMag.std..        frequency domain body     
                                 acceleration jerk magnitude  
                                      standard deviation      

fBodyBodyAccJerkMag.meanFreq..      frequency domain body     
                                 acceleration jerk magnitude  
                                        frequency mean        

    fBodyBodyGyroMag.mean..     frequency domain body velocity
                                        magnitude mean        

    fBodyBodyGyroMag.std..      frequency domain body velocity
                                 magnitude standard deviation 

  fBodyBodyGyroMag.meanFreq..   frequency domain body velocity
                                   magnitude frequency mean   

  fBodyBodyGyroJerkMag.mean..   frequency domain body velocity
                                     jerk magnitude mean      

  fBodyBodyGyroJerkMag.std..    frequency domain body velocity
                                   jerk magnitude standard    
                                          deviation           

fBodyBodyGyroJerkMag.meanFreq.. frequency domain body velocity
                                jerk magnitude frequency mean 
--------------------------------------------------------------