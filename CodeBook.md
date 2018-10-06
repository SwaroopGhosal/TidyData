
# Code Book for the *Getting and Cleaning Data* course project

This is the Code Book for the data set 'tidy_data.txt' attached to this repo. 

The structure of the data is described in the [Data] section, and the [Variables] section has information on the variables. The [Transformations] section specifies the transformations carried out on the original data set to obtain the final tidy data.

## Data
The 'tidy_data.txt' is a text file with space separated values. The first row has the names of the variables, and following rows contain the values. 

This data provides the average measurement for each subject on each of the activities performed. 

## Variables

The first two columns indicate the Subject ID and the Activity. 

The remaining columns indicate the Average values for the subject and activity on various different parameters. 

## Transformations
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


The input data set consisted of the following:

- 'Training data'
This data is collected from the subjects intended for training

- 'Test data'
This was collected as test data.

Following transformations were done - 

- The training and test data was merged into a single data set.
- The columns which contained mean and std deviation data was extracted, all other measurements were discarded.
- The activity identifiers were replaced with descriptive activity names.
- The column names were cleaned up to make them more readable. 
- From this data set, average values for each of the measurements for each subject and activity was calculated and another data set created.
- This data set was written to the tidy_data.txt file. 

## Output File format
The output file 'tidy_data.txt' is space separated. The first line contains the names of the columns. 