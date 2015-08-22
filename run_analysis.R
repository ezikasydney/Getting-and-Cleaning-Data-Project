file <- "data.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_path <- "UCI HAR Dataset"
result_folder <- "results"

##Install required packages  
# checks if the packages are installed

if(!is.element("plyr", installed.packages()[,1])){
    print("Installing packages")
    install.packages("plyr")
}

library(plyr)

## Create data and folders   
# verifies the data zip file has been downloaded
if(!file.exists(file)){
    
##Downloads the data file
    print("downloading Data")
    download.file(url,file, mode = "wb")
    
}

if(!file.exists(result_folder)){
    print("Creating result folder")
    dir.create(result_folder)
} 

##reads a table from the zip data file and applies cols
getTable <- function (filename,cols = NULL){
    
    print(paste("Getting table:", filename))
    
    f <- unz(file, paste(data_path,filename,sep="/"))
    
    data <- data.frame()
    
    if(is.null(cols)){
        data <- read.table(f,sep="",stringsAsFactors=F)
    } else {
        data <- read.table(f,sep="",stringsAsFactors=F, col.names= cols)
    }
    
    
   data
    
}

##Reads and creates a complete data set
getData <- function(type, features){
    
    print(paste("Getting data", type))
    
    subject_data <- getTable(paste(type,"/","subject_",type,".txt",sep=""),"id")
    y_data <- getTable(paste(type,"/","y_",type,".txt",sep=""),"activity")    
    x_data <- getTable(paste(type,"/","X_",type,".txt",sep=""),features$V2) 
    
    return (cbind(subject_data,y_data,x_data)) 
}

##saves the data into the result folder
saveResult <- function (data,name){
    
    print(paste("Saving data", name))
    
    file <- paste(result_folder, "/", name,".csv" ,sep="")
    write.csv(data,file)
}



##get common data tables

#features used for col names when creating train and test data sets
features <- getTable("features.txt")

## Load the data sets
train <- getData("train",features)
test <- getData("test",features)

## 1. Merges the training and the test sets to create one data set. < DONE
# merge datasets
data <- rbind(train, test)

# rearrange the data using id
data <- arrange(data, id)



## 3. Uses descriptive activity names to name the activities in the data set < DONE
## 4. Appropriately labels the data set with descriptive activity names.  < DONE

activity_labels <- getTable("activity_labels.txt")

data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)



## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
dataset1 <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]


# save dataset1 into results folder
saveResult(dataset1,"dataset1")

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
dataset2 <- ddply(dataset1, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })

# Adds "_mean" to colnames
colnames(dataset2)[-c(1:2)] <- paste(colnames(dataset2)[-c(1:2)], "_mean", sep="")

# Save tidy dataset2 into results folder
saveResult(dataset2,"dataset2")


