
* dataset1.csv - 10299 rows and 81 cols
* dataset2.csv - 180 rows and 81 cols

### Include dataset
The data is located in the results folder

dataset1 <- read.csv("results/dataset1.csv")
dataset2 <- read.csv("results/dataset2.csv")


run_analysis.R

 
-run_analysis <- function (){

file <- "data.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_path <- "UCI HAR Dataset"
result_folder <- "results"
 
##Install required packacets

##Install required packacets  
# looks if package is installed
 
if(!is.element("plyr", installed.packages()[,1])){
  print("Installing packages")
  install.packages("plyr")
}
 
library(plyr)


## Create data and folders

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


} 
 
##reads a table from the zip data file and applies cols
getTable <- function (filename,cols = NULL){
     
 print(paste("Getting table:", filename))
    
 f <- unz(file, paste(data_path,filename,sep="/"))
     
 data <- data.frame()
 
getTable <- function (filename,cols = NULL){

##Reads and creates a complete data set
 getData <- function(type, features){
     
 print(paste("Getting data", type))
   
subject_data <- getTable(paste(type,"/","subject_",type,".txt",sep=""),"id")
 y_data <- getTable(paste(type,"/","y_",type,".txt",sep=""),"activity")    
 x_data <- getTable(paste(type,"/","X_",type,".txt",sep=""),features$V2) 
 
getData <- function(type, features){
 
##saves the data into the result folder
saveResult <- function (data,name){
    
print(paste("Saving data", name))
   
file <- paste(result_folder, "/", name,".csv" ,sep="")
 write.csv(dataset1,file)
 write.csv(data,file)
}
 
 
colnames(dataset2[,-c(1:2)]) <- paste(colnames(dataset2[,-c(1:2)]), "_mean", sep
 
 saveResult(dataset2,"dataset2")
 
}
 
run_analysis()

