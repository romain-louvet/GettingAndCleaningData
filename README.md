---
title: "README - Getting and Cleaning Data Course Project"
author: 
date: "Tuesday, February 10, 2015"
output: html_document
---

This document describes the inputs and outputs of the "run_analysis.R" script. 

## Repo content

This repository contains:

  - this "README.md" file, explaining this project, the inputs and outputs of "run_analysis.R" script
  - a "CodeBook.md" file, explaining "run_analysis.R" script processing
  - "run_analysis.R" script, including comments

## Project presentation

The documents in this repository were created in order to fulfil the course project assignment from "Getting and Cleaning Data" course on Coursera (See [Getting and Cleaning Data](https://www.coursera.org/course/getdata), by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD, from [Johns Hopkins Bloomberg School of public Health](http://www.jhsph.edu/), on [Coursera](https://www.coursera.org/)).

Data provided for this assignment belong to "one of the most exciting areas in all of data science": wearable computing. See for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). This area interests companies like "Fitbit, Nike, and Jawbone Up" which "are racing to develop the most advanced algorithms to attract new users."

"Wearable computers, also known as body-borne computers or wearables are miniature electronic devices that are worn by the bearer under, with or on top of clothing [...]." Wearable computer items have been initially developed for (amongst others applications) health care monitoring systems, and applied with, for instance, mobile phones ([Wikipedia](http://en.wikipedia.org/wiki/Wearable_computer)).

The data linked to from the course website represent data collected from a sensor on a mobile phone (the accelerometers from the Samsung Galaxy S smartphone) and are the results of experimental monitoring of acceleration and velocity during specific activities.

## Why is "tidydataset" tidy?


Originnally the data were "raw" (multiple files, non explicit variable names, ...) and the goal of this project was to make them "tidy" as if we were to perform analysis on them after. After executing the script "run_analysis.R", it returns a loaded data set called "tidydataset". This data set is tidy because:

* each column is a variable (see 'Output: "tidydataset" variables' below), each row an observation (the mean of a signal variable measure per subject), moreover there is no NA
* it's using activity name labels instead of original numbers (which was a requirement)
* it's correcting errors from original raw data set (laying instead of lying; non consistent separators in "X_test.txt" and "Y_test.txt")
* it's renaming columns with explicit names (which was a requirement)
* it's replacing original signal variables measures short names by full length text which I found easier to understand (even if they can be long)
* it's only using lower cases character, and no spaces in column names, which I found easier for selection and subsetting
* it's melting the raw data set, which I found easier for computing the mean in the last step
* it's ordering the final data set (by subject, activity and variable measure) which I found easier for reading the data set
* it's selecting specific variables measures (which was a requirement) and provides a justification (see more on that in "CodeBook.md")

## Assignment instructions

The goal was to prepare tidy data that can be used for later analysis (demonstrating the ability to collect, work with, and clean a data set).

**It was required to submit: **

1. a tidy data set as described below
2. a link to a Github repository with a R script for performing the analysis 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called "CodeBook.md"
4. also it was suggested to include a "README.md" in the repo

**Tidy data set definition:** the tidy dataset is created by a R script called "run_analysis.R" that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Rename with descriptive names:
    + Uses descriptive activity names to name the activities in the data set
    + Appropriately labels the data set with descriptive variable names.
4. From the previous tidy data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Informations about the raw data set

A full description is available at [the site where the data was obtained](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), and [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) were downloaded the data for the project.

See from "README.txt" file extracted from the raw data set zip file (Author: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. [www.smartlab.ws](www.smartlab.ws)) informations about how the data were collected, and license, terms and conditions for using these data: 

    The experiments have been carried out with a group of 30 volunteers within 
    an age bracket of 19-48 years. Each person performed six activities (WALKING, 
    WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
    smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
    and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
    velocity at a constant rate of 50Hz. The experiments have been video-recorded 
    to label the data manually. The obtained dataset has been randomly partitioned 
    into two sets, where 70% of the volunteers was selected for generating the 
    training data and 30% the test data.

    License:

    Use of this dataset in publications must be acknowledged by referencing the 
    following publication [1]

    [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
    Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
    Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
    Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

    This dataset is distributed AS-IS and no responsibility implied or explicit 
    can be addressed to the authors or their institutions for its use or misuse. 
    Any commercial use is prohibited.

    Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.*


## Inputs: raw data set folder "rawdata" content

"**rawdata**" folder is created in the working directory if the script is used. It originally contains:

  - a folder named "UCI HAR Dataset", which is extracted content from "getdata_projectfiles_UCI_HAR_Dataset.zip"
  - a zip file named "getdata_projectfiles_UCI_HAR_Dataset.zip"
  
**"UCI HAR Dataset"** folder contains:

  - a readme document, "README.txt"
  - "features_info.txt": shows information about the variables used on the feature vector

It also includes the following files which constitute the raw data set (source: "README.txt" in "UCI HAR Dataset"):

  - **"features.txt"**: List of all features (561 variables), or column names of "X_train.txt" and "X_test.txt"

  - **"activity_labels.txt"**: Links the class labels with their activity name, i.e. descriptive activity name corresponding with "y_train.txt" (7352 rows) and "y_test.txt" (2947 rows)

  - in "train" folder
    + **"X_train.txt"**: Training raw data set (561 columns, 2947 rows)
    + **"y_train.txt"**: Training labels (2947 rows)

  - in "test" folder
    + **"X_test.txt"**: Test raw data set (561 columns, 7352 rows)
    + **"y_test.txt"**: Test labels (7352 rows)

**Within test or train folders** are available the following files. Their descriptions are equivalent. 

  - **"subject_train|test.txt"**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 (one for each volonteer): 9 for training data (number 2, 4, 9, 10, 12, 13, 18, 20, and 24; 7352 rows), 21 for test data (other numbers, 2947 rows).
  
  - Whitin test or train folders are also the "Inertial Signals" folders, which weren't used for this analysis.

## Output: "tidydataset" variables

These variables are based on the values from the .txt files which are described above (inputs).

1. **subject** - from "subject_train.txt" and "subject_test.txt". Subject number values between 1 and 30.

2. **set** - based on which folder the data were from (test or train). There are 9 training subjects and 21 test subjects.

3. **activity** - from "y_train.txt and "y_test.txt", labels from "activity_labels.txt" values. Activities are: "lying", "sitting", "standing", "walking", "walking downstairs", "walking upstairs".

4. **signalvariablemeasure** - from features variables names from "X_train.txt", "X_test.txt" and "features.txt". There are 79 different variables measures (see "Signal variables measures name conversion table" in "CodeBook.md").

5. **signalnormalizedvaluesmean** - from "X_train.txt" and "X_test.txt". Normalized difference values (between -1 and 1) mean of signal variable measures values grouped by subject, activity and signal variable measure name.

## Outputs: "tidydata" and "rawdata" content after executing "run_analysis.R" 

"**tidydata**" folder is created in the working directory if the script is used. At the end of the processing, it contains:
  
  - "tidydataset.txt", contains the result of the script, ie "tidydataset" exported as a text file, using the write.table() command (separator " ")
  - "conv_rawtidy_names.txt", contains details about the transformation from original variables measures names into more descriptive names (seperator " ") (see "Signal variables measures names conversion table" in "CodeBook.MD")

Added to "**rawdata**" folder: a third text file is created after downloading the raw data: "UCI_HAR_Dataset_downldate.txt", saving the date and time of the downloading of "getdata_projectfiles_UCI_HAR_Dataset.zip"

## Mean and std measures selection

Based on the informations in "README.txt" and "feature_info.txt" files) the extraction was done by selecting specific columns, considering the signals and features based on the signals as the measurements, as following:

- I included the signals mean (mean()) and standard deviation (std())
- I included the mean of the frequency components of the signals (meanFreq())
- I didn't included the averaging signals in a signal window sample in angle variables, because they are angle values between vector values which are means, not means themselves

The result is 79 variables measures selected.
