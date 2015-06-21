Introduction
------------

This repo contains the work for the Getting and Cleaning Data course Project Assignment.
The files in the repo are:

* README.md: Describes what is in the repo, has instructions how to
download the raw data from UCI HAR experiment, gives background for the experiment
including the *README.txt* file that came with the original data, explains what the
script file does.
* run_analysis.R : R script file to go from the raw data to a tidy dataset called
*subjectactdata.txt* in wide format, fulfilling the requirements of the assignment.
* CodeBook.md : a codebook which describes the variables in the tidy dataset,
*subjectactdata.txt*.  Includes the *features_info.txt* file that came with the original
data.

Downloading the original data
-----------------------------

For the instructions in this README to work, you need to have
downloaded the data from the link given in the assignment.  The
dataset is in a large archive, a .zip format, so it needs to be
unzipped.  This may happen automatically when you download, but if not
you can use the unzip command.  Here is a step-by-step guide:

1. Right click on the link in the assignment,
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and choose Download LinkedFile.  It is a big file, and you may need to
wait about 10-30 seconds for it to finish downloading.  Look for a
zipped file called getdata-projectfiles-UCI HAR Dataset.zip in your
Downloads folder.

2. Rename the file projectfiles.zip.  On the command line do
```
 mv "getdata-projectfiles-UCI HAR Dataset.zip" projectfiles.zip
```

3.  Move this file to the folder where you will run the code

```
 mv projectfiles.zip /YourUserName/Project
```

4.  Unzip the file in that directory:
On the Mac,
```
unzip projectfiles.zip
```

5.  You should see a directory called UCI HAR Dataset.  Rename it to UCIHAR-Dataset.
```
 mv "UCI HAR Dataset" UCIHAR-Dataset
```

6.  You can go into the directory UCIHAR-Dataset to check that it has
four files and two directories, which are explained in the README.txt
file in that directory.

Usage of the script file
------------------------

The file run_analysis.R is an R script which reads in the appropriate
data from UCIHAR-Dataset described above and creates a tidy dataset,
in wide format, as prescribed by the Project assignment.  The tidy
dataset is written to the working directory and is called
subjectactdata.txt.  The automated way to run the code and see the
results is the following:

```
source("run_analysis.R")
subjectactdata <- read.table("subjectactdata.txt",header=TRUE); View(subjectactdata)
```

Background of the experiment
----------------------------

In the assignment it is stated that a full description of the
experiment is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
One thing I found very helpful at this site was the following 1.5
minute Youtube showing a subject going through the six activities of
the experiment in the order: sitting, standing, laying, walking,
walking downstairs, walking upstairs, while the smartphone and
gyroscope raw data is displayed in the upper left of the screen:

https://www.youtube.com/watch?v=XOEN9W05_4A

The files *README.txt* (README file with the original experiment) and
*features_info.txt* were crucial to figuring out what to do for the
assignment.  The file *README.txt* is duplicated below; the file
*features_info.txt* is included in *CodeBook.md*.

## Original README:##

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the
data manually. The obtained dataset has been randomly partitioned into
two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion
components, was separated using a Butterworth low-pass filter into
body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz
cutoff frequency was used. From each window, a vector of features was
obtained by calculating variables from the time and frequency
domain. See 'features_info.txt' for more details.

### For each record it is provided: ###

- Triaxial acceleration from the accelerometer (total acceleration)
  and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

### The dataset includes the following files: ###

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their
descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who
  performed the activity for each window sample. Its range is from 1
  to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration
  signal from the smartphone accelerometer X axis in standard gravity
  units 'g'. Every row shows a 128 element vector. The same
  description applies for the 'total_acc_x_train.txt' and
  'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration
  signal obtained by subtracting the gravity from the total
  acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity
  vector measured by the gyroscope for each window sample. The units
  are radians/second.

### Notes:###

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:###

Use of this dataset in publications must be acknowledged by
referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using
a Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or
explicit can be addressed to the authors or their institutions for its
use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Explanations of what is done, and why, in *run_analysis.R*
----------------------------------------------------------

I read carefully the *README.txt* and *features_info.txt* file, and
tried several ways of reading the data files into R.  From the
assignment instructions, we are told to deal with mean and standard
deviation only, of each measurement.  This type of data only occurs in
the datasets which contain the features; these are the datasets called
'train/X_train.txt', 'test/X_test.txt'.  The beginning of the R script
file *run_analysis.R* gives the code that resulted in 561 columns
being read in for these datasets.  I also read in the dataset
'train/Inertial Signals/total_acc_x_train.txt' and discovered this
dataset had 128 columns which means it's the acceleration signals for
the 128 readings in a window described in the above, original README
file, and it isn't the data we need for the assignment.  So I don't
work with this dataset, or the other similar ones, in the directory
*Inertial Signals*.

Next I give some general explanation of what the code in
*run_analysis.R* does, organized by the five steps outlined in the
assignment.

(1) Merge the training and the test sets to create one dataset.

From the above README it is clear that the *train* and *test* datasets
contain distinct subjects.  There are 21 subjects in the training
dataset, and 9 subjects in the test dataset; in fact in reading in the
data, it takes about three times as long to read in the training
dataset (about 15 seconds).  Step 1 of the assignment is to merge
these datasets, and since the subjects are distinct between the two
sets, this means we just need concatenation, or operations such as
"rbind" or "cbind" in R; it would be incorrect to try to merge
datasets by a common id.  In *run_analysis.R*, the comments in Step
1. spell out the details.

(2) Extract only the measurements on the mean and standard deviation for each measurement.

I referred to *features_info.txt* which gives a general description of
the features and to *features.txt* which lists them all out.  Some of
the features have "mean" in the name but apparently aren't what is
asked for, i.e. those which have "meanFreq" in the name.  I only
included the features with either "mean()" or "std()" in the name and
extracted them using an explicit list all the indices out of the 561
features with either of these strings; this is a "brute force"
approach.  I checked the results by printing out several pieces of the
result.

(3) Use descriptive activity names to name the activities in the data
set.

The ordering of the activity names came from the file
*activity_labels.txt* in the original data.  Use of a factor object
seems the natural way to carry the names along with the whole dataset.

(4) Appropriately label the data set with descriptive variable names.

I used the feature names from the list in *features.txt* as they are descriptive;
I just modified them using some string manipulation commands so they are valid R
names.  I also reordered the dataset at this point, in increasing numerical order,
first on subject, then on activity.

(5)  Create a second, independent tidy data set with the average of each variable for
each activity and each subject.

The dataset I create is called *subjectactdata*.  It has 180 rows and
68 columns; thus it is in the short, wide form.  This seemed
appropriate if the use of the data would be to explore features that
would distinguish among the activities, according to Hadley Wickham in
his *Tidy Data* paper.

The tidy dataset will have 180 rows for 30 subject x 6
activities/subject.  It has 68 columns, of which 66 columns are
average measurements corresponding to the 66 variables which were
retained from the original 561.  Each subject/activity combination has
a certain number of rows of measurements in the original data,
corresponding to however many windows of acceleroment/gyroscope data
were collected for that subject and activity.  In order to compress
each of these sets of rows into one row giving just the mean over the
rows, the R code uses melt() and dcast() from the reshape2 package.

 The resulting dataset is a tidy dataset, in wide form, where each row
 corresponds to an observation of a subject doing one activity, and
 each column contains a single variable.  After the first two columns
 for subject and activity, each column contains a mean(2) of either a
 mean(1) or standard deviation(1) of a feature:

(1) The mean and standard deviation of a feature are of measurements taken
 within a window; these values were extracted from the original datasets
 Xtrain and Xtest.

(2) The mean in the tidy dataset is an average over all the windows
   for a particular subject/activity of the mean and std from (1);
   each of the 180x66 values is such a mean, and is a summary
   statistic and a modification of the raw data.