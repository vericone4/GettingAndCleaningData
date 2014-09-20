#                             README                                          


This is the markdown which file explains the analysis done in run_analysis.R 
script.

##REQUIREMENTS FOR THE SCRIPT

1. Data files for input data 
2. R packages for reshape2 and dplyr are installed on the machine where the script 
will run

##FILE STRUCTURE
1. Working_Directory/run_analysis.R --- the script which performs the analysis
2. Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset - Data file 
directory downloaded from the website
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. features_info , features describing the features and the feature vector variables
4. activity_labels indicating the activities performed by subjects
5. test directory underneath Data directory containing files test_X, y_test files,
subject_train
6. train directory underneath Data directory containing files train_X, y_train, 
subject_train files



##EXPLANATION ABOUT FILES

1. Sensor signal data captured as different observations while subjects performed 
certain activities is distributed via (URL ) .
2. The observations that were measured via sensor signalsare are represented as 
factors vectors and are listed in the features file
3. test folder contains the file X_test which has sensor signals for various 
observations that were measured while subjects carried certain activities
4.training folder contains the file X_train which has training data for various 
observations that were measured while subjects carried certain activities
5. subject_test and subject_train identify the subjects who performed the 
activities for which X_test and Y_test correspondingly represent the factors
data
6. y_test and y_train represents the activity that the subjects listed 
in the above files . The activities are represented as id's (integers) in the
file which correspond a unique activity label in the activity_labels files.
7. The inertial folders are ignored as these are processed to produce the X_test
and Y_test as per documentation 

## SUMMARY OF ANALYSIS
1. Reading all the independent files into R so that test, train ,subjects who 
performed an activity and activity are stored into individual data tables.
2. Assigning the columns of the test and train data to represent the factors in the
factors file
3.Assembly of these individual data tables into one table by identifying the common 
columns amongst them. 
3. The assembled data sets are filtered to have only columns with mean or std in
the column names. 
4. The column names of the merged data set is cleaned up to have descriptive names
only.
5. The average of the all the factor variables in the merged data set is 
caluclated by first making the data set long and skinny using melt function and 
casting it back to caluclate the average using dcast function of reshape2 library.
6. The final output is written to a file named dataset.


## DETAILED DESCRIPTION OF ANALYSIS 

### DATA LOADING INTO R - COURSE PROJECT PARTS 1- 4
This is the first part of the analysis where individual data files in the data 
folder are read into R as data tables.

1. The observations for the activities performed by the subject are read into R 
as data tables both from test and training data files as below
````
        # data table  for the test data
        test_dt<-read.table(file=test_file,sep="",header=FALSE)
        # data table for the train data 
        train_dt<-read.table(file=train_file, sep ="", header=FALSE)
````
2. The columns of the test_dt and train_dt are the factors listed in the factors
file , which is also read in to R as following . Further the column names of the 
test and train data tables are assigned from the column names of factors data 
table.

```
        # data table for the factors vector
        factors_dt<-read.table(file=features_file, sep = "", header=FALSE)

        # assign the factors as the columns for the test data
        names(test_dt)<-factors_dt[ ,2]

        # assign the factors as the columns for the train data
        names(train_dt)<-factors_dt[ ,2]
```
3.The corresponding subjects who performed the activities in both test and train
data setsare read into R as the data table.
```
        # read the test subject data into a data table
        test_subject_dt<-read.table(test_subject_file, sep = "", header= FALSE)

        # read the train subject data into a data table
        train_subject_dt<-read.table(train_subject_file, sep = "", 
        header= FALSE)
```
4.  The activities that are represented in the test and training data sets are 
identified in the test_y and training_y files which are also read into R as the 
data tables.
```
        # read the test activity  data into a data table 
        test_y_dt<-read.table(file=test_y_file, sep = "", header=FALSE)

        # read the train activity data into a data table 
        train_y_dt<-read.table(file=train_y_file, sep = "", header=FALSE)
```
5. The activity descriptions or labels are read into R as a data table 
```
         #read the activity file as a data table
        activity_dt<-read.table(activity_labels_file, sep = "",header=FALSE)
```
### DATA ANALYSIS -COURSE PROJECT PARTS 1- 4
Now that all individual pieces of data are loaded into separate data tables ,
the task is now to create links between these data tables and merge them together.
This is accomplished by series of steps which are listed below .

1. The first step would be is to create a "key column" for both the data tables 
which have the ids for the activities and metadata table that holds the labels
for the activity . This key by which all the both test_y_dt and train_y_dt would
be joined to activity_dt would be called as "activity_id ". 

```
        #assign column names for activity data table and test_y_dt
        names(test_y_dt)<-c("activity_id")
        names(train_y_dt)<-c("activity_id")
        names(activity_dt)<-c("activity_id", "activity")
```
2. The next few steps we start assembling the data into one final_test_dt and
final_train_dt tables and to be able to do that dplyr package would be used.

3. An inner join on test_y_dt and activity_dt and similarly an inner join on 
train_y_dt and activity_dt is performed. The resulting data sets have activities
identified by labels.

```
        #Using dplyr package for inner join by activity_id 
        test_y_dt<-inner_join(activity_dt,test_y_dt ,by ="activity_id")
        train_y_dt<-inner_join(activity_dt,train_y_dt,by ="activity_id")
                
        #convert the test_y_dt into tbl_df and also store the result
        # a final test_df
        final_test_df<-tbl_df(test_y_dt)
               
        #convert the test_y_dt into tbl_df and also store the result
        # a final test_df
        final_train_df<-tbl_df(train_y_dt)```

```
4. Intoducing the subject column into final_test and final_train with values 
from the corresponding rows in subject_dt . This is done using mutate function
as below.

5. Also selecting only activity and subject columns from the resulting tables .
This steps essentially drops the activity id column introduced for joining the 
tables by inner join.

```
        #use mutate function to add the new column into the
        #final test based on values of subject test first column and also naming 
        #the resulting column as subject id
        final_test_df<-mutate(final_test_df,
                                      subject=test_subject_dt[,1])
                
        # select only the columns of interest
        final_test_df <-select(final_test_df,activity:subject)
                
        #use mutate function to add the new column into the
        #final test based 
        #on values of subject test first column and also naming 
        #the resulting column as subject id
        final_train_df <- mutate(final_train_df,
                                         subject=train_subject_dt[,1])
                
        # select only the columns of interest
        final_train_df <-select(final_train_df,activity:subject)
        
```
6. Next steps would be do some data cleaning on train and test data tables . 
In order to do this only columns containing mean or std in the column names are
selected as per the requirement of the assignment.

7. This step however results in selecting columns which measure angles with means , 
they are dropped from the tables as this is a derived variable . Also we column
bind the final data tables with test and train data to assemble the subject ,
activity and observations data into one data set.

```
        # select only columns having mean or std in the names
        train_dt <- select(train_dt,matches("mean|std"))
                
        #from the above result further select columns which does not have angle
        #in the name
        train_dt <- select(train_dt,-contains("angle"))
                
        #assembling all the cleaned and processed data first step is to column 
        #bind the test_dt & final_test
        final_test_df<-cbind(final_test_df,test_dt)
                
        #do the same above for train_dt and final_train_dt
        final_train_df<-cbind(final_train_df,train_dt)
```
8. Both test and train data tables assembled in the previous section have the same
columns now . These two data tables are appended together using row bind function.
The column names of the final table are cleaned up so that they are easily readable
(columns have descriptive names).The cleaned up final table is ordered by the
subject column.

```
         #step2 row bind both test and training data 
        final_df<-rbind(final_test_df,final_train_df)
                
        # clean up the names of the final data frame remove the "-" (hyphen) 
        #in the column names using the gsub
        names(final_df)<-gsub("-","",names(final_df))
                
        # remove the "()" using the gsub 
        names(final_df)<-gsub("\\(\\)","",names(final_df))
                
        #finally making all the column names as lower case
        names(final_df)<-tolower(names(final_df))
                
        #use the arrange function to order the final data frame by 
        #$subject column
        final_df<-arrange(final_df,subject)        
```
##CREATION OF INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR
## EACH ACTIVITY AND EACH SUBJECT ---COURSE PROJECT PART 5 
1. We are asked to create an indepenedent tidy data set from the above. This data
set is melted by using the melt function in reshape2 library. The melt function
takes the tidy data set retains the columns subject and activity and creates the
measure variable from the remaining factor varaible .  The resulting data table
is a long and skinny table where each row represents for a given subject and activity
the factor variable name and the value as the columns.

```
        # first use  melt function to make the final_df long and 
        #skinny. We do this by melting the data frame so that the
        # resulting data frame captures the each measurement of mean
        #and std as a unique row for each combination of subject 
        #and activity
                
        result_df<-melt(final_df,id=c("subject","activity"), 
                                measure.vars=3:81)
                
```
2. We take the long and skinny table from the above and use the dcast function 
in the reshape2 library to re-cast the table so that we have average of each 
factor for a each unique combination of the subject and activity


```
        # cast the result_df so that we get the average of each variables
        # for the unique combination subject and activity                
        result_df<-dcast(result_df,subject+activity ~variable, mean)
```

3. The result from the above is written to test file which is then uploaded to 
coursera project page.

```
        # Write the result to an output file.
        write.table(result_df, file = "dataset.txt", sep = " ", 
              row.name = FALSE) 

```
