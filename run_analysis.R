
library(plyr)
library(dplyr)


# Step 0: Import the data sets

data <- list()

datadir <- ("UCI HAR Dataset")

for (dir in c("train", "test")) {
  
  file <- file(file.path(datadir,dir, paste0("subject_", dir, ".txt")), "r")
  subject <- as.numeric(readLines(file))
  close(file)
  
  file <- file(file.path(datadir, dir, paste0("X_", dir, ".txt")), "r")
  feature <- read.table(file, colClasses = c("numeric"), stringsAsFactors = FALSE)
  close(file)
  
  file <- file(file.path(datadir, dir, paste0("y_", dir, ".txt")), "r")
  activity <- as.numeric(readLines(file))
  close(file)

  data[[dir]] <- cbind(subject, activity, feature)

}


# Step 1: Merge the data sets together

data <- rbind(data$train, data$test)


# Step 2: Extract measurements on mean and standard deviation
# Note that the inclusion of meanFreq is completely intentional (see README)

featurelist <- read.table(file.path(datadir, "features.txt"), col.names = c("columnname", "measurement"), colClasses = c("character"), stringsAsFactors = FALSE)

featurelist$columnname <- paste0("V", featurelist$columnname)

featurelist <- filter(featurelist, grepl("(mean|std)", measurement))

data <- select(data, subject, activity, featurelist$columnname)


# Step 3: Give descriptive names for the activities within the data set

activitylist <- read.table(file.path(datadir, "activity_labels.txt"),  col.names = c("identifier", "activityname"), colClasses = c("character"), stringsAsFactors = FALSE)

activitylist$activityname <- gsub("_", " ", activitylist$activityname)

for (i in 1:nrow(activitylist)) {
  data$activity <- gsub(i, activitylist$activityname[[i]], data$activity)
}


# Step 4: Label data set with descriptive variable names

keyword <- c("Body", "Gravity", "Acc", "Gyro", "Jerk", "^t", "^f")
keyword <- c(keyword, "Mag", "mean\\(\\)", "std\\(\\)", "meanFreq\\(\\)", "X$", "Y$", "Z$")

label <- c("Body", "Gravity", "Acceleration", "AngularVelocity", "Jerk", "TimeSignal", "FrequencySignal")
label <- c(label, "Magnitude", "Mean", "StandardDeviation", "MeanFrequency", "X-Axis", "Y-Axis", "Z-Axis")

lookuptable <- data.frame(keyword = keyword, label = label)

featurelist$label <- character(1)

for (i in 1:nrow(lookuptable)) {
  
  keywordmatch <- grepl(lookuptable$keyword[[i]], featurelist$measurement)
  featurelist$label[keywordmatch] <- paste(featurelist$label[keywordmatch], lookuptable$label[[i]], sep = "")
  
}

data <- rename_with(data, function(argument) featurelist$label, featurelist$columnname)

# Step 5: Create independent, tidy data set, with average 
# of each variable for each activity and each subject

tidydata <- ddply(data, .(subject, activity), colwise(mean))


# Export the tidy data with the required parameter

write.table(tidydata, "tidydata.txt", row.name = FALSE)