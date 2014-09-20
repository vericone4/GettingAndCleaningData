# CODE BOOK DESCRIPTION
This code book describes the data set included in tidydata.text , which was in turn
produced as an output of the script run_analysis.R.

The data set contains 81 variables for observations that were collected using the
sensor signals. More information on how these signals were analysed and collected
visit

The following column names are derived based on the explanation given in the features info

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


##Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'


##The columns of the tidy data set are as following
The columns are derived from the explanation above (or modifying the original code book)

```
col     column names	                                        Description 
1       subject	     Subject identifier who performed the activity. This subject identifier is an integer from 1-30
2	activity	                Activity -describing the activity performed during measurement of the sensor signals.
3	tbodyaccmeanx	                X axial signal time domain accelerometer signal - mean
4	tbodyaccmeany	                Y axial signal time domain accelerometer signal - mean
5	tbodyaccmeanz	                Z axial signal time domain accelerometer signal - mean
6	tbodyaccstdx	                X axial signal time domain accelerometer signal - std
7	tbodyaccstdy	                Y axial signal time domain accelerometer signal - std
8	tbodyaccstdz	                Z axial signal time domain accelerometer signal - std
9	tgravityaccmeanx        	time domain Gravity acceleration for X direction -mean
10	tgravityaccmeany        	time domain Gravity acceleration for Y direction -mean
11	tgravityaccmeanz        	time domain Gravity acceleration for Z direction -mean
12	tgravityaccstdx	                time domain Gravity acceleration for X direction -std
13	tgravityaccstdy	                time domain Gravity acceleration for Y direction -std
14	tgravityaccstdz         	time domain Gravity acceleration for Z direction -std
15	tbodyaccjerkmeanx       	time domain Body acceleration for X direction -mean
16	tbodyaccjerkmeany       	time domain Body acceleration for Y direction -mean
17	tbodyaccjerkmeanz	        time domain Body acceleration for Z direction -mean
18	tbodyaccjerkstdx        	time domain Body acceleration for X direction -std
19	tbodyaccjerkstdy	        time domain Body acceleration for Y direction -std
20	tbodyaccjerkstdz        	time domain Body acceleration for Z direction -std
21	tbodygyromeanx	                time domain Body angular acceleration for X direction -mean
22	tbodygyromeany	                time domain Body angular acceleration for Y direction -mean
23	tbodygyromeanz	                time domain Body angular acceleration for Z direction -mean
24	tbodygyrostdx	                time domain Body angular acceleration for X direction -std
25	tbodygyrostdy	                time domain Body angular acceleration for Y direction -std
26	tbodygyrostdz	                time domain Body angular acceleration for Z direction -std
27	tbodygyrojerkmeanx      	time domain Body Jerk angular acceleration for X direction -mean
28	tbodygyrojerkmeany      	time domain Body Jerk angular acceleration for Y direction -mean
29	tbodygyrojerkmeanz      	time domain Body Jerk angular acceleration for Z direction -mean
30	tbodygyrojerkstdx	        time domain Body Jerk angular acceleration for X direction -std
31	tbodygyrojerkstdy	        time domain Body Jerk angular acceleration for Y direction -std
32	tbodygyrojerkstdz       	time domain Body Jerk angular acceleration for Z direction -std
33	tbodyaccmagmean	                time domain body acceleration magnitude - mean
34	tbodyaccmagstd	                time domain body acceleration magnitude - std
35	tgravityaccmagmean	        time domain gravity acceleration magnitude - mean
36	tgravityaccmagstd	        time domain  gravity  acceleration magnitude - std
37	tbodyaccjerkmagmean	        time domain body acceleration jerk magnitude - mean
38	tbodyaccjerkmagstd	        time domain body acceleration jerk magnitude - std
39	tbodygyromagmean	        time domain body angular acceleration magnitude - mean
40	tbodygyromagstd	                time domain body angular acceleration magnitude - std
41	tbodygyrojerkmagmean	        time domain body angular acceleration Jerk magnitude - mean
42	tbodygyrojerkmagstd	        time domain body angular acceleration Jerk magnitude - std
43	fbodyaccmeanx	                X axial signal frequency domain accelerometer signal - mean
44	fbodyaccmeany	                Y axial signal frequency domain accelerometer signal - mean
45	fbodyaccmeanz	                Z axial signal frequency domain accelerometer signal - mean
46	fbodyaccstdx	                X axial signal frequency domain accelerometer signal - std
47	fbodyaccstdy	                Y axial signal frequency domain accelerometer signal - std
48	fbodyaccstdz	                Z axial signal frequency domain accelerometer signal - std
49	fbodyaccmeanfreqx	        frequency domain body acceleration mean frquency along X direction 
50	fbodyaccmeanfreqy	        frequency domain body acceleration mean frquency along Y direction 
51	fbodyaccmeanfreqz	        frequency domain body acceleration mean frquency along Z direction 
52	fbodyaccjerkmeanx	        frequency domain body Jerk acceleration mean along X direction 
53	fbodyaccjerkmeany	        frequency domain body Jerk acceleration mean along Y direction 
54	fbodyaccjerkmeanz	        frequency domain body Jerk acceleration mean along Z direction 
55	fbodyaccjerkstdx	        frequency domain body Jerk acceleration std along X direction 
56	fbodyaccjerkstdy	        frequency domain body Jerk acceleration std along Y direction 
57	fbodyaccjerkstdz	        frequency domain body Jerk acceleration std along Z direction 
58	fbodyaccjerkmeanfreqx	        frequency domain Body Jerk acceleration mean frequency for X direction 
59	fbodyaccjerkmeanfreqy	        frequency domain Body Jerk acceleration mean frequency for Y direction 
60	fbodyaccjerkmeanfreqz   	frequency domain Body Jerk acceleration mean frequency for Z direction 
61	fbodygyromeanx	                frequency domain Body angular acceleration for X direction -mean
62	fbodygyromeany	                frequency domain Body angular acceleration for Y direction -mean
63	fbodygyromeanz	                frequency domain Body angular acceleration for Z direction -mean
64	fbodygyrostdx	                frequency domain Body angular acceleration for X direction -std
65	fbodygyrostdy	                frequency domain Body angular acceleration for Y direction -std
66	fbodygyrostdz	                frequency domain Body angular acceleration for Z direction -std
67	fbodygyromeanfreqx	        frequency domain Body  angular acceleration mean frequency for X direction -mean
68	fbodygyromeanfreqy      	frequency domain Body Jerk angular acceleration mean frequency for Y direction -mean
69	fbodygyromeanfreqz	        frequency domain Body Jerk angular acceleration for mean frequency Z direction -mean
70	fbodyaccmagmean 	        frequency domain Body acceleration magnitude mean 
71	fbodyaccmagstd	                frequency domain Body acceleration magnitude std
72	fbodyaccmagmeanfreq     	frequency domain Body acceleration magnitude mean frequency
73	fbodybodyaccjerkmagmean	        frequency domain Body acceleration jerk magnitude mean 
74	fbodybodyaccjerkmagstd	        frequency domain Body acceleration jerk magnitude std
75	fbodybodyaccjerkmagmeanfreq	frequency domain Body acceleration jerk magnitude mean frequency
76	fbodybodygyromagmean	        frequency domain  angular acceleration  magnitude mean 
77	fbodybodygyromagstd       	frequency domain  angular acceleration  magnitude std
78	fbodybodygyromagmeanfreq	frequency domain body acceleration  magnitude mean frequency
79	fbodybodygyrojerkmagmean	frequency domain body angular acceleration Jerk magnitude - mean
80	fbodybodygyrojerkmagstd	        frequency domain body angular acceleration magnitude - std
81	fbodybodygyrojerkmagmeanfreq	frequency domain body angular acceleration Jerk magnitud mean frequency



```

 
