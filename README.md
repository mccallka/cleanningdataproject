# cleanningdataproject
Course Project to clean and tidy a dataset
==================================================================
Clean up and Tidy project using the 
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Data was origially created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, data captured included 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The raw dataset included the following files:
=========================================
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Cleaning of the Data Process: 
============================
- Read in the files into a tables 
- Add a common id to each table for cross referencing
- Add column names tables
- Merge the tables
- Combine Test and Train tables
- Update id variable
- Extract the colunm names with mean and std
- Renamed the activity table columns to match the test_train labels column
- joined the test_train and activity tables to list the activity type based on the labels column 
- Rearranged the columns to put the labels and labelsactivity next to each other
- modify the column names to be more descriptive and removed special characters
- Group data by subject id and then by activity
- summarize the results and take the mean of each activity
- removed the id variable and rearranged the data by subjectid and labels

