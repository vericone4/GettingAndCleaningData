run_analysis<-function(){        
        #**************I/O for all the given data files**********************#
        # set the wd
        setwd("~/Data/Venkata/Personal/Coursera/Getting_and _Cleaning_Data/Working_Directory")
        
        # identify the data directory
        data_dir<-"Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
        
        #identify the features file
        features_file<-paste(data_dir,"features.txt", sep="/")
        
        #identify the activities file
        activity_labels_file<-paste(data_dir,"activity_labels.txt", sep="/")
        
        # identify the test data directory
        test_dir<- paste(data_dir,"test", sep="/")
        
        #  identify the training test directory
        training_dir<-paste(data_dir,"train", sep = "/")
        
        # identify the test data file
        test_file<-paste(test_dir,"X_test.txt", sep ="/")
        
        # identify the file which has the activity for the test data
        test_y_file<-paste(test_dir,"y_test.txt", sep ="/")
        
        # identify the file which has the subjects for the test data 
        test_subject_file<-paste(test_dir,"subject_test.txt", sep ="/")
        
        # identify the training data file
        train_file<-paste(training_dir,"X_train.txt", sep ="/")
        
        # identify the file which has the activity for the test data
        train_y_file<-paste(training_dir,"y_train.txt", sep ="/")
        
        # identify the file which has the subjects for the test data 
        train_subject_file<-paste(training_dir,"subject_train.txt", sep ="/")
        
        # data table  for the test data
        test_dt<-read.table(file=test_file,sep="",header=FALSE)
        
        # data table for the train data 
        train_dt<-read.table(file=train_file, sep ="", header=FALSE)
        
        # data table for the factors vector
        factors_dt<-read.table(file=features_file, sep = "", header=FALSE)
        
        # assign the factors as the columns for the test data
        names(test_dt)<-factors_dt[ ,2]
        
        # assign the factors as the columns for the train data
        names(train_dt)<-factors_dt[ ,2]
        
        # read the test activity  data into a data table 
        test_y_dt<-read.table(file=test_y_file, sep = "", header=FALSE)
        
        # read the train activity data into a data table 
        train_y_dt<-read.table(file=train_y_file, sep = "", header=FALSE)
        
        # read the test subject data into a data table
        test_subject_dt<-read.table(test_subject_file, sep = "", header= FALSE)
        
        # read the train subject data into a data table
        train_subject_dt<-read.table(train_subject_file, sep = "", 
                                     header= FALSE)
        
        #read the activity file as a data table
        activity_dt<-read.table(activity_labels_file, sep = "",header=FALSE)

        
        #assign column names for activity data table and test_y_dt
        names(test_y_dt)<-c("activity_id")
        names(train_y_dt)<-c("activity_id")
        names(activity_dt)<-c("activity_id", "activity")
        
        
        #make sure the key column is numeric
        test_y_dt$activity_id<-as.numeric(test_y_dt$activity_id)
        train_y_dt$activity_id<-as.numeric(train_y_dt$activity_id)
        activity_dt$activity_id<-as.numeric(activity_dt$activity_id)
        
                
        #********************    DATA PROCESSING ******************************#
        #Merge the activity labels data table and test_y_dt by activity id               
        if(require(dplyr)){
                
                #Using dplyr package for inner join by activity_id 
                test_y_dt<-inner_join(activity_dt,test_y_dt ,by ="activity_id")
                train_y_dt<-inner_join(activity_dt,train_y_dt,by ="activity_id")
                
                #convert the test_y_dt into tbl_df and also store the result
                # a final test_df
                final_test_df<-tbl_df(test_y_dt)
               
                #convert the test_y_dt into tbl_df and also store the result
                # a final test_df
                final_train_df<-tbl_df(train_y_dt)
               
                #use mutate function to add the new column into the
                #final test based 
                #on values of subject test first column and also naming 
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
                
                #factors_dt<-tbl_df(factors_dt)                                
                #temp<-factors_dt[grepl("mean|std",factors_dt$V2),]
                
                # convert the test_dt into tbl_df
                test_dt<-tbl_df(test_dt)
                
                # select only columns having mean or std in the names
                test_dt <- select(test_dt,matches("mean|std"))
                
                #from the above result further select columns
                #which does not have angle in the name
                test_dt <- select(test_dt,-contains("angle"))

                # convert the train_dt into tbl_df
                train_dt<-tbl_df(train_dt)
                
                # select only columns having mean or std in the names
                train_dt <- select(train_dt,matches("mean|std"))
                
                #from the above result further select columns
                #which does not have angle in the name
                train_dt <- select(train_dt,-contains("angle"))
                
                #assembling all the cleaned and processed data 
                # first step is to column bind the test_dt & final_test
                final_test_df<-cbind(final_test_df,test_dt)
                
                #do the same above for train_dt and final_train_dt
                final_train_df<-cbind(final_train_df,train_dt)
                
                #step2 row bind both test and training data 
                final_df<-rbind(final_test_df,final_train_df)
                
                # clean up the names of the final data frame
                # remove the "-" (hyphen) in the column names using the gsub
                names(final_df)<-gsub("-","",names(final_df))
                
                # remove the "()" using the gsub 
                names(final_df)<-gsub("\\(\\)","",names(final_df))
                
                #finally making all the column names as lower case
                names(final_df)<-tolower(names(final_df))
                
                #use the arrange function to order the final data frame by 
                #$subject column
                final_df<-arrange(final_df,subject)
                
                
        }
        
        #************************ Part 5 *************************************
        # To accomplish the results for part 5 of the problem , the 
        # final_df from the above is taken and melted using the 
        # functions available in reshape2 package
        #**********************************************************************
        if(require (reshape2)){
                # first use  melt function to make the final_df long and 
                #skinny. We do this by melting the data frame so that the
                # resulting data frame captures the each measurement of mean
                #and std as a unique row for each combination of subject 
                #and activity
                
                result_df<-melt(final_df,id=c("subject","activity"), 
                                measure.vars=3:81)
                
                # cast the result_df so that we get the average of each variables
                # for the unique combination subject and activity                
                result_df<-dcast(result_df,subject+activity ~variable, mean)

                # Write the result to an output file.
                write.table(result_df, file = "dataset.txt", sep = " ", 
                            row.name = FALSE) 
        }       
        
}