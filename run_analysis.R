#reading the unzipped data from working directory

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

#adding labels to X_test and X_train

test_set<-cbind(X_test,y_test)
train_set<-cbind(X_train,y_train)

#combining train and test records (rows)

merged_data<-rbind(test_set,train_set)

library(dplyr)

merged_table<-tbl_df(merged_data)

# changing headers to descriptive
header<-c(as.character(features$V2),"activity")
names(merged_table)=header

#adding activity labels to the data set

merged_final<-inner_join(merged_table,activity_labels,by=c("activity"="V1"))
names(merged_final)[563]<-"activity_name"

#adding subject

subject<-rbind(subject_test,subject_train)
merged_fin<-cbind(merged_final,subject)
names(merged_fin)[564]<-"subject"

#extracts only the measurements on the mean and standard deviation for each measurement. 

valid_column_names <- make.names(names=names(merged_fin), unique=TRUE, allow_ = TRUE)
names(merged_fin) <- valid_column_names

extracted<-select(merged_fin,subject,activity_name,contains("mean"),contains("std"))
extracted_tbl<-tbl_df(extracted)

#grouping by subject and activity

extracted_gr<-group_by(extracted_tbl,subject,activity_name)

#calculating means for all extracted measurements

master<-summarise_each(extracted_gr,funs(mean))

#writing as a table

write.table(master,"./UCI HAR Dataset/tidydata.txt",row.name=FALSE)
