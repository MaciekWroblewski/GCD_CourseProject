# GCD_CourseProject
##Course project assigment files

###Readme file for run_analysis.R
#### The aim of this README.md is to explain step by step how does the run_analysis.R file work

*At the beginning the code is reading the relevant raw data - the path to data is provided as relative paths so in order for the file to work the UCI HAR Dataset folder should be in your working directory and should be unzpipped
* Using cbind commands the script adds labels to test and training set
*Using rbind the script combines test and training sets
*script loads dplyr package and converts data frame into local data frame for further use in the script
*converting headers to descriptive 
*using inner_join to merge activity labels with records
*adding subjects using cbind and naming the new column properly
*using make.names to rename the headers (make them unique) in order to be able to use select function from dplyr package
*extracting columns containing "mean" and "std" as well as columns with activity names and subjects
*grouping data set by subject and activity name
*using summarise_each function in order to calculate mean for all measurements grouped by subject and data - which renders tidy data ser
*writing output of tidy data set into the text file 
* hint: to review the tidy data set I propose to use View() function from dplyr package
