Introduction
------------
This codebook has the following sections:

- General description of all variables in the original dataset; *features_info.txt*
file that came with the original data

- Explanation of features selected from the original dataset for this assignment

- List of all variables in the tidy dataset produced for the assignment, with
some detailed descriptions

General description of variables in the original dataset
--------------------------------------------------------
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
for inclusion in the tidy dataset.  In the R script *run_analysis.R* the names
are changed slightly to conform to R naming conventions.

The first two variables in the tidy dataset *subjectactdata* are

- *subject* which is an id ranging from 1 to 30

- *activity* a factor with six levels *walking*, *walkingupstairs*, *walkingdownstairs*,
    *sitting*, *standing*, *laying*

The 66 measurement variables included in *subjectactdata* are listed
below.  The explanations are for the original variables.  The data in
the tidy dataset *subjectactdata* contains the means of these
variables over several overlapping windows.  Also note that the means
are taken over a varying number of windows per subject/activity
combination.

### Note about the units for all the variables ###

From the original *README.txt*:

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration
  signal from the smartphone accelerometer X axis in standard gravity
  units 'g'.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity
  vector measured by the gyroscope for each window sample. The units
  are radians/second.

-  Features are normalized and bounded within [-1,1]

So, the original units are those of acceleration and angular velocity;
however, the data for the assignment has been normalized (a mean has
been subtracted from each observation), so all features including
"standard deviation" type will have some negative as well as some
positive values.  Since the tidy dataset only consists of means of
features, this will be the case for the tidy data values as well.

List of variables with some sample descriptions
-----------------------------------------------

1 tbodyaccmeanx
   - time domain, body acceleration in x direction, mean signal in a particular
    2.56 second window
   - normalized to be between -1 and 1

2 tbodyaccmeany
    - same as 1, in y direction

3 tbodyaccmeanz
    - same as 1, in z direction

4 tbodyaccstdx
    - like 1:  time domain, body accel. in x direction, standard deviation of signals
    in a particular 2.56 second window, normalized to be between -1 and 1

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



