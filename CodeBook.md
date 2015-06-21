Introduction
------------
This codebook has the following sections:

- General description of all variables in the original dataset; this
section is the *features_info.txt* file that came with the original
data

- Explanation of features selected from the original dataset for this assignment,
including the units

- Structure of the tidy dataset

- List of all variables in the tidy dataset produced for the assignment, with
some detailed descriptions

General description of all 561 variables in the original dataset
----------------------------------------------------------------
*features_info.txt* file that came with original data:

### Feature Selection ###

The features selected for this database come from the accelerometer
and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time
domain signals (prefix 't' to denote time) were captured at a constant
rate of 50 Hz. Then they were filtered using a median filter and a 3rd
order low pass Butterworth filter with a corner frequency of 20 Hz to
remove noise. Similarly, the acceleration signal was then separated
into body and gravity acceleration signals (tBodyAcc-XYZ and
tGravityAcc-XYZ) using another low pass Butterworth filter with a
corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector
for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y
and Z directions.

-tBodyAcc-XYZ

-tGravityAcc-XYZ

-tBodyAccJerk-XYZ

-tBodyGyro-XYZ

-tBodyGyroJerk-XYZ

-tBodyAccMag

-tGravityAccMag

-tBodyAccJerkMag

-tBodyGyroMag

-tBodyGyroJerkMag

-fBodyAcc-XYZ

-fBodyAccJerk-XYZ

-fBodyGyro-XYZ

-fBodyAccMag

-fBodyAccJerkMag

-fBodyGyroMag

-fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

-mean(): Mean value

-std(): Standard deviation

-mad(): Median absolute deviation

-max(): Largest value in array

-min(): Smallest value in array

-sma(): Signal magnitude area

-energy(): Energy measure. Sum of the squares divided by the number of values.

-iqr(): Interquartile range

-entropy(): Signal entropy

-arCoeff(): Autorregresion coefficients with Burg order equal to 4

-correlation(): correlation coefficient between two signals

-maxInds(): index of the frequency component with largest magnitude

-meanFreq(): Weighted average of the frequency components to obtain a mean frequency

-skewness(): skewness of the frequency domain signal

-kurtosis(): kurtosis of the frequency domain signal

-bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window

-angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal
window sample. These are used on the angle() variable:

-gravityMean

-tBodyAccMean

-tBodyAccJerkMean

-tBodyGyroMean

-tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Explanation of features included for the assignment
---------------------------------------------------

Based on the explanation above in *features_info.txt*, and the
complete list of 561 variables in 'features.txt" (not given here), I
selected 66 variables that had either "mean()" or "std()" in the name
for inclusion in the tidy dataset.  In the R script *run_analysis.R*
the names are changed slightly to conform to R naming conventions.  It
is useful to explain one of the variables in detail; explanations of
the other variables are similar.  The first variable name in the tidy
dataset is *tbodyaccmeanx* (corresponding to *tBodyAcc-mean()-X* in
the original dataset).  This name stands for the mean in the x
direction of body acceleration; the "t" at the beginning means it's
for the time domain as opposed to the frequency domain (frequency
domain requires a "Fourier transformation" to compute).  From
Paragraph 2 of the *README.txt* file with the original data (included
in my *README.md*), we are told that the accelerometer and gyroscope
signals from the smartphone were "sampled in fixed-width sliding
windows of 2.56 sec and 50% overlap (128 readings/window)."  So, it is
reasonable to suppose the "mean" in the name *tbodyaccmeanx* refers to
taking the mean of the 128 readings in a particular window, of the x
component of body acceleration in the time domain.  Similarly, for the
variable *tbodyaccstdx*, the "std" in the name indicates that the
standard deviation was taken of 128 measurements of body acceleration
in x direction in time domain in a particular 2.56-sec window.  One
would expect the units of both the variables *tbodyaccmeanx* and
*tbodyaccstdx* to be the units of acceleration (e.g. m/s^2), and also
for the *tbodyaccstdx* to be positive.  However, there are negative
values of *tbodyaccstdx* in the datasets.

### Note about the units for all the variables ###

A note at the end of the *README.txt* file with the original data says the following:

-  Features are normalized and bounded within [-1,1]

This note explains why you can and will get negative values for
features such as *tbodyaccstdx*; the data for the variable have the
overall mean subtracted out and then these "difference from the mean"
are likely divided by the maximum absolute value of the feature, in
order to get a range from -1 to 1.  The quantities in the original
dataset are thus unitless, similar in that respect to z-scores; a particular
data value tells how far that acceleration value was from some central
value, relative to a maximum value.  I could not find information on
numerical values used for normalization.

Just for the record regarding units of the variables in the original
dataset, although not needed for this assignment, it's good to note,
from the *README.txt* with the original data:

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration
  signal from the smartphone accelerometer X axis in standard gravity
  units 'g'.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity
  vector measured by the gyroscope for each window sample. The units
  are radians/second.

Structure of the tidy dataset
-----------------------------

The first two variables in the tidy dataset *subjectactdata.txt* are

- *subject* which is an id ranging from 1 to 30

- *activity* a factor with six levels *walking*, *walkingupstairs*, *walkingdownstairs*,
    *sitting*, *standing*, *laying*

The assignment was to create a second, independent tidy data set with
the average of each variable for each activity and each subject.
There are 180 subject/activity combinations, but there are around
13000 rows in the original dataset with training and test sets
combined.  Each row in the original data corresponds to a single
2.56-sec window; from the YouTube video of the experiment we see that
it took about 90 secs for one subject to do all six activities, and
also the windows had 50% overlap; hence, there are potentially several
dozen rows of observations for each subject.  The tidy dataset will
reduce the original data from say 80 or 100 rows for a subject (it
varies), to six rows per subject, one per activity. 

In the course lecture on Tidy Data it was stressed that for a dataset
to be tidy, there should be one observation per row and one variable
per column.  This is illustrated with examples by Hadley Wickham in his
paper [Tidy Data][dl]

[dl]: http://vita.had.co.nz/papers/tidy-data.pdf

When you open up the dataset *subjectactdata.txt* in an ordinary
editor, it looks very "messy" because there are long names and 68
columns with many digits in the numbers.  However, this is a tidy
dataset by the definition.  (And, it looks a lot better if you read it
into R and use View() to look at it---thanks to community TA David
Hood for this tip, and many other useful posts.)

The 66 measurement variables included in *subjectactdata.txt* are
listed below.  The explanations are for the original variables.  The
data in the tidy dataset *subjectactdata.txt* consists of the means of
these variables over several overlapping windows.  Also note that the
means are taken over a varying number of windows per subject/activity
combination.


List of variables in the tidy dataset with some descriptions
------------------------------------------------------------

1 tbodyaccmeanx
   - time domain, body acceleration in x direction, mean signal in a particular
    2.56-sec window, normalized to be between -1 and 1

2 tbodyaccmeany
    - same as 1, in y direction

3 tbodyaccmeanz
    - same as 1, in z direction

4 tbodyaccstdx
    - like 1:  time domain, body acceleration in x direction, 
      standard deviation of signals in a particular 2.56-sec window, 
      normalized to be between -1 and 1

5 tbodyaccstdy

6 tbodyaccstdz

7 tgravityaccmeanx

8 tgravityaccmeany

9 tgravityaccmeanz

10 tgravityaccstdx

11 tgravityaccstdy

12 tgravityaccstdz

13 tbodyaccjerkmeanx

14 tbodyaccjerkmeany

15 tbodyaccjerkmeanz

16 tbodyaccjerkstdx

17 tbodyaccjerkstdy

18 tbodyaccjerkstdz

19 tbodygyromeanx

20 tbodygyromeany

21 tbodygyromeanz

22 tbodygyrostdx

23 tbodygyrostdy

24 tbodygyrostdz

25 tbodygyrojerkmeanx

26 tbodygyrojerkmeany

27 tbodygyrojerkmeanz

28 tbodygyrojerkstdx

29 tbodygyrojerkstdy

30 tbodygyrojerkstdz

31 tbodyaccmagmean
     time domain, body acceleration mean magnitude (combines all three directions)
     in a particular 2.56-sec window, normalized to be between -1 and 1

32 tbodyaccmagstd

33 tgravityaccmagmean

34 tgravityaccmagstd

35 tbodyaccjerkmagmean

36 tbodyaccjerkmagstd

37 tbodygyromagmean

38 tbodygyromagstd

39 tbodygyrojerkmagmean

40 tbodygyrojerkmagstd

41 fbodyaccmeanx
     frequency domain, body acceleration mean in x direction,
     normalized to be between -1 and 1

42 fbodyaccmeany

43 fbodyaccmeanz

44 fbodyaccstdx

45 fbodyaccstdy

46 fbodyaccstdz

47 fbodyaccjerkmeanx

48 fbodyaccjerkmeany

49 fbodyaccjerkmeanz

50 fbodyaccjerkstdx

51 fbodyaccjerkstdy

52 fbodyaccjerkstdz

53 fbodygyromeanx

54 fbodygyromeany

55 fbodygyromeanz

56 fbodygyrostdx

57 fbodygyrostdy

58 fbodygyrostdz

59 fbodyaccmagmean

60 fbodyaccmagstd

61 fbodybodyaccjerkmagmean

62 fbodybodyaccjerkmagstd

63 fbodybodygyromagmean

64 fbodybodygyromagstd

65 fbodybodygyrojerkmagmean

66 fbodybodygyrojerkmagstd



