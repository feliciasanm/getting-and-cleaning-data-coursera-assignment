# Getting and Cleaning Data - Week 4 (Final) Assignment

The repository is created for a peer-graded assignment in Johns Hopkins University's Getting and Cleaning Data course at Coursera.

There are three topics that this README will cover: the content of the repository, how the analysis script works, and other matters related to the assignment. Furthermore, there will be a partial bibliography at the end of the README file.


## Content of the Repository

This repository contains three files: analysis script, code book, and this README file. 

### Analysis Script
The analysis script file is named run_analysis.R, and it will take data that are to be processed by the assignment, which are ["Human Activity Recognition Using Smartphones Data Set" Version 1.0](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto from [Smartlab - Non Linear Complex Systems Laboratory](www.smartlab.ws). 

The goal of the script is process the aforementioned data set to create a tidy data set with the average of mean and standard deviation-related variables for each subject and each activity. The script is made according to the requirement of the assignment, which includes the assumption that it can be run if the input data set is in working directory. 

Simply unzip the input data set in the same directory and run the analysis script to obtain the result in the form of a txt file titled "tidydata.txt". More details of how the script works will be described in another section later.

### Code Book
The code book file is named "codebook.md", and it includes summary of the experimental study design, choices that impact the dataset, and processes undergone by the data set, traced from the creation of the original data set until the processed data set made by the analysis script, and description of each variable (including name, brief explanation of each variable, type of data imported in R, and possible range of the variable's values).

### README File
The README file is named "README.md", and as described above, will describe the content of the repository, how the analysis script works, and other matters related to the assignment.


##  How the Analysis Script Works

The analysis script is written according to the steps outlined in the assignment (with an addition of step 0 to import the file), and the steps are also marked and commented on the run_analysis.R file. As such, this section will be structured around the steps as well.

### Step 0: Import the data sets
As mentioned previously, the script incorporates the assumption outlined in the assignment, which is that it can be run if the input data set is in the working directory. 
Using a loop, it will import data from test and train folder in the input data set (subject, measurement, and activity data to be exact), combine the imported data into a single data frame for each folder, and store them in as elements in a list named "data".

### Step 1: Merge the data sets together
In this step, a unified data set is created by merging the two data set present in the list together into a single data frame, assigned to "data" variable to overwrite the old list.

### Step 2: Extract measurements on mean and standard deviation
A feature list from "features.txt" is imported into a data frame. Variables pertaining to mean and standard deviation are selected using regular expression in the feature list. Since the feature list maps to measurement data columns in the previously imported data set, the feature list that has been selected for variables on mean and standard deviation can be used to select only measurement data columns that are connected to mean and standard deviation, which is exactly what the script does. 

Note that the regular expression-selected features are the ones measuring mean, standard deviation, and also mean frequency. This is intentional and will be explained in another section further below.

### Step 3: Give descriptive names for the activities within the dataset
An activity label list from "activity_labels.txt" is imported into a data frame, which has the mapping between the activity data coded in the data set data frame and its more human readable and descriptive labels. The labels are still in the form of variables separated by underscore, which is removed by the script before the activity data are substituted with the labels.

### Step 4: Label data set with descriptive variable names
From the feature list imported in step 2, the script already has the variable names of each measurement data column. However, the name is still too short and abbreviated. 

To remedy this, a new column is created on the feature list data frame to store a highly descriptive variable name next to the current variable name first. Then, another data frame is created that maps between sections of the old variable name (such as "acc", "std", "X" at the end of the variable name) and more descriptive counterparts (such as "Acceleration", "StandardDeviation", "X-Axis"). The sections are carefully ordered so that when iterated to fill the new column in the feature list data frame, it would make a new and more descriptive variable name that are appropriately word order-wise. After doing so, using the newly-populated descriptive variable name column, the data set's column names are replaced with the new descriptive variable names.

Another section later will explain why the new variable names should be considered descriptive.

### Step 5: Create independent, tidy data set, with average of each variable for each activity and each subject  
Each step up until now are already deliberately designed to lead to the tidy data set that will be created in this set, so there are only a few things left to accomplish step 5. To create this second, independent, tidy data set, the data set is averaged group-wise using ddply, where thr grouping should be based on activiy and subject (one group for each combination of activity and subject), and done column-wise (each variable is averaged separately of other variables). This data set is assigned to a a variable named "tidydata", thus completing step 5.


Finally, the data is exported using the specified function and parameter in the Coursera assignment page, which is write.table and row.name = FALSE.


## Other Matters Related to the Assignment

### Why Is It Descriptive Variable Names?
**Step 4 of the assignment presents a problem: how to create a descriptive variable name?** To find out what a descriptive variable name looks like, I read slide number 4 of Week 1, The Components of Tidy Data. The example presented was changing AgeDx into AgeAtDiagnosis. I attempt to follow the example given in the course to the best and most unambigous extent possible. In creating the descriptive variable names required in the assignment, I followed suit in terms of space (no space between words), capitalization (capitalizing the first letter of each word), and combining words to create descriptive variable names. 

To figure out what the variable means, I read the various text files attached with the original data set, read several additional articles to figure out what the terms mean (the articles will be included in the partial bibliography) so I can name, order the variable names properly, and write the codebook. I am aware that the descriptive variable names are very long, in fact I would not have created such a long name anywhere else other than this assignment, but I want to assure you beyond any doubt that the name is indeed descriptive :) 

It may seems obvious to us what the variable means now (even if we read the unmodified descriptive name we are supposed to replace) as we deal with them so much during this assignment we end up knowing them pretty well, but it is difficult to determine how descriptive the names would have to be for new users of the data to know what they mean. I certainly drew a diagram to figure the original unmodified names out!

### Why Is It Tidy Data?
**Step 5 of the assignment requested for tidy data**, which essentially mean reshaping the data as needed to create tidy data. In order to answer this requirement, I read the [Tidy Data paper by Hadley Wickham (2014)](https://vita.had.co.nz/papers/tidy-data.pdf) and [a blog post that describes the data using set theory](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment) to try to figure out what tidy data actually means. There are two possible forms for the data set, either narrow or wide, and determining which one is tidy data can be tricky. I would not argue which one is the best one for this assignment (as the blog post pointed out, we do not even know for what problem our data set will be put to use, actually), but I would like to argue I believe that the form I have here can be considered as tidy.

There are three rules for tidy data from the course, which are:

1. Each variable forms a column  
2. Each observation forms a row  
3. Each type of observational unit forms a table  

To figure out whether the data set fits the rules of tidy data, **we must define first (at least) what are variable and observation**. Depending on how we see the data (according to the limited information that is present to us), what form the tidy data should take can be different. Note that observational unit is not discussed because we must submit the result as one txt file containing our data set, and a txt file should contain only one table, right? There is less ambiguity involved in observational unit. Therefore, let us go over the rest one by one:


#### Variable
According to Wickham (2014), "a variable contains all values that measure the same underlying attribute (like height, temperature, duration) across units". If it is a variable, it should have its own column in tidy data set. For this assignment, I argue that it can be said that **the variables are subject, activity, and each measurement feature**. Why is that so? It makes more sense when we also look at the definition of observation below...

#### Observation
According to Wickham (2014), "An observation contains all values measured on
the same unit (like a person, or a day, or a race) across attributes". In this case, especially because we have to average the variables on the last step, I argue that the observation is every time we record a person doing an activity. 

From the data set description, it seems the experiment that generated the original data set was intended to measure numerically how each subject performs each activity. Furthermore, the instruction for Step 5 is to have the average for each subject and activity. Therefore, it is reasonable to conclude that **the observation is each subject doing each activity and the measurements that are generated from there**.

#### Conclusion
If the definition of observation in the data set is as I have described, then it makes sense that **the variables would be the features that become the attribute of each person as he/she does each activity**. For example, that the x-axis average (mean/standard deviation/mean frequency) body angular velocity in frequency signal domain of a certain subject is a particular number, when doing a certain activity, can be seen as **an attribute of the subject when the subject does that certain activity**.

To recap, seeing the data in this manner, the tidy data result would have columns be subject, activity, and the measurement features, while the observation would be each time a person does an activity and the features it generate, all made in a table. If the submitted tidy data set is checked, that is exactly how the data is constructed!

Perhaps a question would arise: what if we deconstruct the variables, cutting up the original variable names into sections and create more columns? While we have been taught how to do it, it can introduce many NAs in the columns, because we receive the data already in a relatively "baked" form. We could calculate the data from the raw data in Inertial Signals folder, but we were told in Step 2 to extract only measurements related to mean and standard deviation, which would have eliminated the data we need to do it early in the process (because we have to follow the steps and using data in Step 4 to work on Step 5).


### What Is Included as Measurements Related to Mean and Standard Deviation?
**In essence, I am aware that there are two choices: either include mean() and std() features, or include mean(), std(), and meanFreq() features**. The problem is, the statements on the assignment and the txt files from the data set on this are quite vague, enough that there are many people asking about it in the course forum. Despite multiple iterations of the course, the language remains delightfully vague, and it is very trivial to clear it should the course creators actually want it. It does reflect the ambiguity that we would see when we work on something like this later, and perhaps that is the reason behind the ambiguity. 

I decide to include meanFreq(), too, intentionally. I think it depends on how we interpret the data set, and there are definitely not enough information to say conclusively which option is the right one. People can possibly submit each of the possible choices, and as long as they are aware that it is ambiguous and do things intentionally (not by accident) I guess it is okay. 

To ascertain what meanFreq (mean frequency) supposed to mean and decide, I look to the internet to figure it out. As I research, I find [this paper](dx.doi.org/10.5772/50639) that seems to be about measuring muscle fatigue to tell activities apart from each other, and it mentions mean frequency (something that sounds around the ballpark/field of the experiment that creates the original data set seems to be!). As best as I understand from reading the paper and other sources (which will be in the partial bibliography), mean frequency is something in frequency signal domain only (so only for for features with f- at the begininng of their name), the equation involves some form of averaging attributes, and it is potentially useful for assessing muscle. 

**Therefore, I infer that mean frequency is indeed related with mean, something that seems special for frequency signal domain (note that features with t-, the ones that are in time signal domain, do not have meanFreq), and useful for muscle-related things**. As a result, I think it makes sense to include meanFreq due to the possibility of it being useful in the usage of the data set, so **I include mean frequency in the data set in Step 2**.

### Code to Import the Data Set

Here is a nice code snippet to help import the data set to your R terminal nicely. Credit to David Hood in his [blog post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) guiding on this assignment (also included in the partial bibliography).

`data <- read.table("tidydata.txt", header = TRUE)`  
`View(data) # Additional line, works best in R Studio`


## Partial Bibliography

Rather than being an official bibliography, this section is intended to be a place to give a shoutout for articles that I recall contributing a lot in the creation of this README and in my working on the assignment. I am well aware that the things I cite might not be thesis-worthy (my lecturer has regularly told me not to use Wikipedia as a source, for example), and this bibliography, being partial, is also not thesis-worthy, but I intend to give credit and show what articles have contributed to this README assignment. All of them will be written below in APA style, except for google searches.

**

Google search on keywords related to Jerk, Mean Frequency, Magnitude, Fourier Transforms.

Hood, D. (2015, September 9). *Getting and Cleaning the Assignment*. Retrieved 19 August 2020, from https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

Jain, A. [Arpit Jain]. (2017, January 27). The weighted average "(sum over (fourier coefficient index * amplitude of that coefficient)) / number of fourier coefficients" does not seem very [Comment on the online forum post *Measuring the average frequency of signals*]. Stack Exchange. https://dsp.stackexchange.com/questions/37229/measuring-the-average-frequency-of-signals

Jerk (physics). (n.d.). In *Wikipedia*. Retrieved 19 August 2020, from https://en.wikipedia.org/wiki/Jerk_(physics)

Kinsellagh, J. (2020, August 16). *What is a Frequency Spectrum?*. Retrieved 9 August 2020, from https://www.wisegeek.com/what-is-a-frequency-spectrum.htm

Phinyomark, A., Thongpanja, S., Hu, H., Phukpattaranont, P., & Limsakul, C. (2012). *The Usefulness of Mean and Median Frequencies in Electromyography Analysis. Computational Intelligence in Electromyography Analysis - A Perspective on Current Applications and Future Challenges*. doi:10.5772/50639

user3494047. (2017, January 27). *Measuring the average frequency of signals* [Online forum post]. Stack Exchange. https://dsp.stackexchange.com/questions/37229/measuring-the-average-frequency-of-signals