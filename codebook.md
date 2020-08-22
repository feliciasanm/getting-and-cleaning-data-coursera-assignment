# Code Book


## General Description
The data set is a processed data set made from ["Human Activity Recognition Using Smartphones Data Set" Version 1.0](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto from [Smartlab - Non Linear Complex Systems Laboratory](www.smartlab.ws). 

Quoting from the [data set web page](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), the original data set is "Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors". The smartphone's accelerometer and gyroscope recorded the activities and the data are processed to produce 561 data features in the original data set. Out of the features available, features related to mean and standard deviation are extracted, averaged and arranged into the processed tidy data set described in this code book.


## Study Design

This section will be divided into two parts, a part each for the original data set and the process creating the processed data set.

### Original Data Set

Below are the relevant excerpts on study design from the data set web page:

> "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelero  meter and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

> "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain ..."

Furthermore, for the sake of describing the design of the processed data set, it is relevant to note further on how the aforementioned vector of features, totalling 561 features, are created from the sensor signals. Here are the relevant excerpts from "features_info.txt" file included with the data set distribution:

> "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz."

> "Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)."

> "Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)."

> "These signals were used to estimate variables of the feature vector for each pattern:"  
> "'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag"

From these signals, several variables were estimated, producing the original data set's 561 features. The variables, according to "features_info.txt" are listed below:

- mean (mean)
- standard deviation (std) 
- median absolute deviation (mad)
- minimum value (min)
- maximum value (max)
- signal magnitude area (sma)
- energy measure (sum of squares divided by number of values) (energy)
- interquartile range (iqr)
- signal entropy (entropy)
- autogression coefficients (with Burg order equal to 4) (arCoeff)
- correlation coefficient (between two signals) (correlation)
- index of frequency component with largest magnitude (maxInds)
- mean frequency (weighted average of frequency components) (meanFreq)
- skewness of frequency domain signal (skewness)
- kurtosis of frequency domain signal (kurtosis)
- energy of frequency interval (within 64 bins of FFT of each window) (bandsEnergy)
- angle between vectors (angle)

The data set is stored separately for each subject group: train and test. The storage for each group is identical, just with different name for the files and folders. For the sake of illustration, using the train group, "X_train.txt" will contain the value of the features, one feature vector per line. "subject_train.txt" will contain which subject is associated with each feature vector line in the "X_train.txt". "y_train.txt" will contain which activity is associated to each feature vector line in "X_train.txt". Note that all three files contain numeric data, and more human-readable labels are stored in separate files: "activity_labels.txt and features.txt". 

Lastly, the captured signal which has not been calculated into features are stored in a folder called "Inertial Signals", not discussed further here because it is not being involved in creating the processed data set. 


### Processed Data Set

From the original data set which are divided into two groups, a unified data set is recreated by merging the two data set group, resulting in 10299 rows of feature vector line. Data from each file storing the data for each group are combined from "subject_train.txt" containing the subject generating the data, "y_train.xt" containing the activity generating the data, and "X_train.txt" containing the features created from the generated data. As noted in the previous section, the "Inertial Signals" folder is not used and thus the folder is excluded in creating the processed data set.


After combining the unified data set with the human-readable labels, only features related to mean and standard deviation are extracted. These are mean, standard deviation, and mean frequency (where available) for each signal, resulting in 79 variables out of 561 features in total. These variables are renamed to give them very descriptive human-readable names. At this point, there are multiple feature vector line for each combination of subject and activity (because there are 30 subjects and 6 activities, there should be 180 combination of subject and activity). To produce the final data set, values of the same variable that are associated to the same subject and activity are averaged. Putting it another way, the values of these variables are now the average of its previous values, and the average are done with values that share the same subject and activity. The final data set has 180 rows for each combination of subject and activity and 81 columns to accomodate the variables (subject, activity, and 79 variables related to mean and standard deviation).

More details on the processed data set can also be seen in the README.md file of this data set available in the repo.


## Code Book

Each variable contained in this data set will be described below. 

A note about unit: values for variable number 3 onwards are normalized, which means that regardless of the actual unit used in the measurements, it has been normalized so the value is bounded between -1 and 1.

1. subject  
The subject who generated the data  
Type: numeric  
Range:  
  1 until 30

2. activity  
The activity which generated the data  
Type: character  
Range:  
    - LAYING
    - SITTING
    - STANDING
    - WALKING
    - WALKING DOWNSTAIRS
    - WALKING UPSTAIRS
  
3. BodyAccelerationTimeSignalMeanX-Axis  
The average mean of body acceleration in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

4. BodyAccelerationTimeSignalMeanY-Axis  
The average mean of body acceleration in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

5. BodyAccelerationTimeSignalMeanZ-Axis  
The average mean of body acceleration in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

6. BodyAccelerationTimeSignalStandardDeviationX-Axis  
The average standard deviation of body acceleration in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

7. BodyAccelerationTimeSignalStandardDeviationY-Axis  
The average standard deviation of body acceleration in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

8. BodyAccelerationTimeSignalStandardDeviationZ-Axis  
The average standard deviation of body acceleration in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

9. GravityAccelerationTimeSignalMeanX-Axis  
The average mean of gravity acceleration in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

10. GravityAccelerationTimeSignalMeanY-Axis  
The average mean of gravity acceleration in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

11. GravityAccelerationTimeSignalMeanZ-Axis  
The average mean of gravity acceleration in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

12. GravityAccelerationTimeSignalStandardDeviationX-Axis  
The average standard deviation of gravity acceleration in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

13. GravityAccelerationTimeSignalStandardDeviationY-Axis  
The average standard deviation of gravity acceleration in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

14. GravityAccelerationTimeSignalStandardDeviationZ-Axis  
The average standard deviation of gravity acceleration in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

15. BodyAccelerationJerkTimeSignalMeanX-Axis  
The average mean of body acceleration jerk in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

16. BodyAccelerationJerkTimeSignalMeanY-Axis  
The average mean of body acceleration jerk in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

17. BodyAccelerationJerkTimeSignalMeanZ-Axis  
The average mean of body acceleration jerk in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

18. BodyAccelerationJerkTimeSignalStandardDeviationX-Axis  
The average standard deviation of body acceleration jerk in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

19. BodyAccelerationJerkTimeSignalStandardDeviationY-Axis  
The average standard deviation of body acceleration jerk in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

20. BodyAccelerationJerkTimeSignalStandardDeviationZ-Axis  
The average standard deviation of body acceleration jerk in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

21. BodyAngularVelocityTimeSignalMeanX-Axis  
The average mean of body angular velocity in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

22. BodyAngularVelocityTimeSignalMeanY-Axis  
The average mean of body angular velocity in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

23. BodyAngularVelocityTimeSignalMeanZ-Axis  
The average mean of body angular velocity in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

24. BodyAngularVelocityTimeSignalStandardDeviationX-Axis  
The average standard deviation of body angular velocity in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

25. BodyAngularVelocityTimeSignalStandardDeviationY-Axis  
The average standard deviation of body angular velocity in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

26. BodyAngularVelocityTimeSignalStandardDeviationZ-Axis  
The average standard deviation of body angular velocity in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

27. BodyAngularVelocityJerkTimeSignalMeanX-Axis  
The average mean of body angular velocity jerk in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

28. BodyAngularVelocityJerkTimeSignalMeanY-Axis  
The average mean of body angular velocity jerk in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

29. BodyAngularVelocityJerkTimeSignalMeanZ-Axis  
The average mean of body angular velocity jerk in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

30. BodyAngularVelocityJerkTimeSignalStandardDeviationX-Axis  
The average standard deviation of body angular velocity jerk in time domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

31. BodyAngularVelocityJerkTimeSignalStandardDeviationY-Axis  
The average standard deviation of body angular velocity jerk in time domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

32. BodyAngularVelocityJerkTimeSignalStandardDeviationZ-Axis  
The average standard deviation of body angular velocity jerk in time domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

33. BodyAccelerationTimeSignalMagnitudeMean  
The average mean of body acceleration magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

34. BodyAccelerationTimeSignalMagnitudeStandardDeviation  
The average standard deviation of body acceleration magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

35. GravityAccelerationTimeSignalMagnitudeMean  
The average mean of gravity acceleration magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

36. GravityAccelerationTimeSignalMagnitudeStandardDeviation  
The average standard deviation of gravity acceleration magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

37. BodyAccelerationJerkTimeSignalMagnitudeMean  
The average mean of body acceleration jerk magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

38. BodyAccelerationJerkTimeSignalMagnitudeStandardDeviation  
The average standard deviation mean of body acceleration jerk magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

39. BodyAngularVelocityTimeSignalMagnitudeMean  
The average mean of body angular velocity magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

40. BodyAngularVelocityTimeSignalMagnitudeStandardDeviation  
The average standard deviation of body angular velocity magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

41. BodyAngularVelocityJerkTimeSignalMagnitudeMean  
The average mean of body angular velocity jerk magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

42. BodyAngularVelocityJerkTimeSignalMagnitudeStandardDeviation  
The average standard deviation of body angular velocity jerk magnitude in time domain signal  
Type: numeric  
Range:  
  -1 until 1

43. BodyAccelerationFrequencySignalMeanX-Axis  
The average mean of body acceleration in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

44. BodyAccelerationFrequencySignalMeanY-Axis  
The average mean of body acceleration in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

45. BodyAccelerationFrequencySignalMeanZ-Axis  
The average mean of body acceleration in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

46. BodyAccelerationFrequencySignalStandardDeviationX-Axis  
The average standard deviation of body acceleration in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

47. BodyAccelerationFrequencySignalStandardDeviationY-Axis  
The average standard deviation of body acceleration in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

48. BodyAccelerationFrequencySignalStandardDeviationZ-Axis  
The average standard deviation of body acceleration in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

49. BodyAccelerationFrequencySignalMeanFrequencyX-Axis  
The average mean frequency of body acceleration in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

50. BodyAccelerationFrequencySignalMeanFrequencyY-Axis  
The average mean frequency of body acceleration in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

51. BodyAccelerationFrequencySignalMeanFrequencyZ-Axis  
The average mean frequency of body acceleration in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

52. BodyAccelerationJerkFrequencySignalMeanX-Axis  
The average mean of body acceleration jerk in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

53. BodyAccelerationJerkFrequencySignalMeanY-Axis  
The average mean of body acceleration jerk in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

54. BodyAccelerationJerkFrequencySignalMeanZ-Axis  
The average mean of body acceleration jerk in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

55. BodyAccelerationJerkFrequencySignalStandardDeviationX-Axis  
The average standard deviation of body acceleration jerk in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

56. BodyAccelerationJerkFrequencySignalStandardDeviationY-Axis  
The average standard deviation of body acceleration jerk in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

57. BodyAccelerationJerkFrequencySignalStandardDeviationZ-Axis  
The average standard deviation of body acceleration jerk in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

58. BodyAccelerationJerkFrequencySignalMeanFrequencyX-Axis  
The average mean frequency of body acceleration jerk in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

59. BodyAccelerationJerkFrequencySignalMeanFrequencyY-Axis  
The average mean frequency of body acceleration jerk in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

60. BodyAccelerationJerkFrequencySignalMeanFrequencyZ-Axis  
The average mean frequency of body acceleration jerk in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

61. BodyAngularVelocityFrequencySignalMeanX-Axis  
The average mean of body angular velocity in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

62. BodyAngularVelocityFrequencySignalMeanY-Axis  
The average mean of body angular velocity in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

63. BodyAngularVelocityFrequencySignalMeanZ-Axis  
The average mean of body angular velocity in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

64. BodyAngularVelocityFrequencySignalStandardDeviationX-Axis  
The average standard deviation of body angular velocity in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

65. BodyAngularVelocityFrequencySignalStandardDeviationY-Axis  
The average standard deviation of body angular velocity in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

66. BodyAngularVelocityFrequencySignalStandardDeviationZ-Axis  
The average standard deviation of body angular velocity in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

67. BodyAngularVelocityFrequencySignalMeanFrequencyX-Axis  
The average mean frequency of body angular velocity in frequency domain signal for x-axis  
Type: numeric  
Range:  
  -1 until 1

68. BodyAngularVelocityFrequencySignalMeanFrequencyY-Axis  
The average mean frequency of body angular velocity in frequency domain signal for y-axis  
Type: numeric  
Range:  
  -1 until 1

69. BodyAngularVelocityFrequencySignalMeanFrequencyZ-Axis  
The average mean frequency of body angular velocity in frequency domain signal for z-axis  
Type: numeric  
Range:  
  -1 until 1

70. BodyAccelerationFrequencySignalMagnitudeMean  
The average mean of body acceleration magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

71. BodyAccelerationFrequencySignalMagnitudeStandardDeviation  
The average standard deviation of body acceleration magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

72. BodyAccelerationFrequencySignalMagnitudeMeanFrequency  
The average mean frequency of body acceleration magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

73. BodyAccelerationJerkFrequencySignalMagnitudeMean  
The average mean of body acceleration jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

74. BodyAccelerationJerkFrequencySignalMagnitudeStandardDeviation  
The average standard deviation of body acceleration jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

75. BodyAccelerationJerkFrequencySignalMagnitudeMeanFrequency  
The average mean frequency of body acceleration jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

76. BodyAngularVelocityFrequencySignalMagnitudeMean  
The average mean of body angular velocity magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

77. BodyAngularVelocityFrequencySignalMagnitudeStandardDeviation  
The average standard deviation of body angular velocity magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

78. BodyAngularVelocityFrequencySignalMagnitudeMeanFrequency  
The average mean frequency of body angular velocity magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

79. BodyAngularVelocityJerkFrequencySignalMagnitudeMean  
The average mean of body angular velocity jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

80. BodyAngularVelocityJerkFrequencySignalMagnitudeStandardDeviation  
The average standard deviation of body angular velocity jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1

81. BodyAngularVelocityJerkFrequencySignalMagnitudeMeanFrequency  
The average mean frequency of body angular velocity jerk magnitude in frequency domain signal  
Type: numeric  
Range:  
  -1 until 1
