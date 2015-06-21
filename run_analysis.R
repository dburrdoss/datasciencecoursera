# run_analysis.R
#
# This is the R script which goes from the raw data in the directory UCIHAR-Dataset
# to a tidy dataset as outlined in the Getting and Cleaning Data Project assignment.
# The numbers in the comments refer to the five steps in the Project.txt file for that
# assignment.
###
###
### 1.  Merge the training and the test sets to create one dataset.
###
###
#     Read in the training data set of the 561 features for 21 subjects doing the 6 activities
#
#      Xtrain will have 7352 obs. of 561 vars
#      XtrainLabels will have 7352 obs. 1 var. of the activity labels
#      subj.train will have 7352 obs. 1 var. of subject labels
#
# Note: Reading in Xtrain takes 14.728 secs user time on MacBook Pro 2.2 GHz machine
#
#
Xtrain <- read.table("UCIHAR-Dataset/train/X_train.txt",quote="",header=FALSE)
XtrainLabels <- read.table("UCIHAR-Dataset/train/y_train.txt",quote="",header=FALSE)
subj.train <- read.table("UCIHAR-Dataset/train/subject_train.txt",quote="",header=FALSE)
#
#
# Create another variable "group.train" for purpose of merging train and test sets later,
# to identify these obs. are from training dataset
#
group.train <- rep("train",length(XtrainLabels[[1]]))
#
#     Read in the test data set of the 561 features for 9 subjects doing the 6 activities
#
#      Xtest will have 2947 obs. of 561 variables.
#      Xtestlabels will have 2947 obs. 1 var. of activity labels
#      subj.test will have 2947 obs. 1 var. of subject labels
#
# Note: Reading in Xtest takes 4.545 user time on MacBook Pro 2.2 GHz machine
#
#
Xtest <- read.table("UCIHAR-Dataset/test/X_test.txt",quote="",header=FALSE)
XtestLabels <- read.table("UCIHAR-Dataset/test/y_test.txt",quote="",header=FALSE)
subj.test <- read.table("UCIHAR-Dataset/test/subject_test.txt",quote="",header=FALSE)
#
# Create another variable "group.test" for purpose of merging train and test sets later,
#  to identify these obs. are from test dataset
#
group.test <- rep("test",length(XtestLabels[[1]]))
#
#
# Now we can merge the training and test datasets.
# Since there is no overlap of subjects between training and test datasets, we just
# concatenate the four objects, training set then test set in that order for each object,
# then combine all as variables in a single dataframe called "data"
#
# data has 10299 rows, 564 cols, last three cols are subject, activity labels, and group
#   It's formatted this way to make it easier to extract just the 66 mst. cols for
#   the purpose of this assignment
#
subj <- c(subj.train[[1]], subj.test[[1]])
XLabels <- c(XtrainLabels[[1]], XtestLabels[[1]])
X <- rbind(Xtrain,Xtest)  # X has dimensions 10299 rows by 561 cols
group <- c(group.train,group.test)
data <- cbind(X,subject=subj,XLabels=XLabels,group=group) # data dim 10299 x 564
#
# A little check on what's in data gave the following:
# names(data) # "V1" ..."V561" "subject" "XLabels" "group"
###
###
###  2. Extract only the measurements on the mean and standard deviation for each measurement.
###
###
# First read in the names of the 561 features.  I used this here to figure out what columns
# to extract from "data".  I also use the features object later for naming purposes.
#
#
features <- read.table("UCIHAR-Dataset/features.txt",quote="",header=FALSE)
names(features) <- c("id","feature")
features$feature <- as.character(features$feature) # contains all 561 names
#
#
# Create an index vector of which variables to extract from the 561 features.
# Consists of all the features with either "mean()" or "std()" in the name
# Not included are those features which had some sort of averaging done inherently,
#   i.e. those with "meanFreq()" in the name are not included.
# This is brute force approach, can be checked using features.txt in the raw data directory
# or from features$feature created above.
# Objects created below are:
#
#   ii: Vector, contains the relevant indices of the vector of 561 feature names
#   datar: reduced dataset, col. 1 subject, col. 2 XLabels(activity), col. 3 group,
#                           cols 4 - 69 msts consisting of all means and stds of measurements
#
#
ii <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,
        253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
datar <- data[,c(562,563,564,ii)] # reduced dataset with 66 mst variables
# summary(datar)
# dim(datar) # 10299 69
###
###
### 3. Use descriptive activity names to name the activities in the data set.
###
###
# Convert datar$XLabels to a factor with levels given by the
# activity_labels.txt file in the raw data directory UCIHAR-Dataset.
#
#
activities.levels <-
    c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying")
activities <- character(length = length(datar$XLabels))
activities[datar$XLabels == 1] <- "walking"
activities[datar$XLabels == 2] <- "walkingupstairs"
activities[datar$XLabels == 3] <- "walkingdownstairs"
activities[datar$XLabels == 4] <- "sitting"
activities[datar$XLabels == 5] <- "standing"
activities[datar$XLabels == 6] <- "laying"
# Next replace the XLabels component of datar with the factor object containing
#  descriptive activity names:
#
datar$XLabels <- factor(activities, levels=activities.levels)
#
# Check:
# table(datar$XLabels) # no. of rows per each activity
# table(unclass(datar$XLabels)) # table with numbers for activities instead of labels
#
###
###
### 4. Appropriately label the dataset with descriptive variable names.
###
###
# The names in features.txt in UCIHAR-Dataset are interpretable as explained in
# the CodeBook.md file but need to have some invalid characters removed; also
# will change the names to all lowercase.
# Note: See Week 4 Lecture 1 Editing text variables;  functions gsub() and tolower()
#
feature.original <- features$feature[ii] # original 66 variable names, need to be modified
#
feature1 <- gsub("-","",feature.original)
feature2 <- gsub("\\()","",feature1)
feature3 <- tolower(feature2)
names(datar) <- c("subject","activity","group",feature3)
#
# Reorder the dataset "datar" first by subject, then by activity within subject
#
datar <- datar[order(datar$subj,datar$activity),]
#
#
#str(datar)# to look at a summary of what is created so far
###
###
### 5. Create a second, independent tidy data set with the average of each variable for
###    each activity and each subject.
###
###
# The tidy dataset will have 180 rows for 30 subject x 6
# activities/subject.  It has 68 columns, of which 66 columns are
# average measurements corresponding to the 66 variables which were
# retained in the reduced dataset datar.  Each subject/activity
# combination has a certain number of rows of measurements,
# corresponding to however many windows of acceleroment/gyroscope data
# were collected for that subject and activity.  In order to compress
# each of these sets of rows into one row giving just the mean over
# the rows, we will use melt() and dcast() from the reshape2 package.
#
#  This is a tidy dataset, in wide form, where each row corresponds to an observation of a
#  subject doing one activity, and each column contains a single variable.
#  Each column contains a mean(2) of either a mean(1) or standard deviation(1) of a feature
#   (1) The mean and standard deviation of a feature are of msts taken within a window;
#     these values were extracted above from the datasets Xtrain and Xtest and are
#     part of the original, sort of raw data (not as raw as data in Inertial directory).
#
#   (2) The mean in the tidy dataset is an average over all the
#     windows for a particular subject/activity of the mean and std
#     from (1); this is the summary statistic computed in this R
#     script which modifies the raw data.
#
library(reshape2)
#
datarMelt <- melt(datar,id=c("subject","activity","group"),measure.vars=feature3)
# head(datarMelt)
# tail(datarMelt)
subjectactdata <- dcast(datarMelt, subject + activity ~ variable,mean)
#str(subjectactdata) # 180 obs. of 68 variables
# subjectactdata[1:12,1:5] # to look at first few rows and columns
write.table(subjectactdata,row.names=FALSE,file="subjectactdata.txt") # save in text file
###
###
### Clean up
###
###
rm(Xtrain,XtrainLabels,subj.train,group.train,Xtest,XtestLabels,subj.test,group.test,
   X,XLabels,subj,group,activities,activities.levels)
rm(features,feature.original,feature1,feature2,feature3)
rm(data,ii,datar,datarMelt,subjectactdata)
