#This script combined test and training data sets, makes tidy, and outputs a summary table of mean and sd average by subject, by activity. To run, all test and train files must be in separate directories with no other .txt files present. You must set you working directory to the main UCI HAR Dataset folder using the setwd() command prior to running the script.

library(dplyr)
library(qdap)

##import data files

#read in the main label files

path<-getwd()

f_labels<-read.table("features.txt",stringsAsFactors = FALSE) #features labels
f_labels<-f_labels[,2] #retain only the label column
a_labels<-read.table("activity_labels.txt") #activity labels
names(a_labels)<-c("activity_number","activity_label") #relabel with descriptive names

#combine test data files

dir<-paste(path,"/test/",sep="") #set directory where all training data files to be merged are located
files<-list.files(dir,".txt") #create list of files to be merged

combo<-vector(mode="numeric") #set empty vector to be filled
for (file in files){ #loop to bind all files together
  data<-read.table(paste(dir,file,sep=""))
  if (length(combo)==0){
    combo<-vector(mode="numeric",length=nrow(data))
  }
  combo<-cbind(combo,data)
}

test<-combo[,-1] #remove extra column
names(test)<-c("subject",f_labels,"activity") #apply labels

#combine training data files

dir<-paste(path,"/train/",sep="") #set directory where all training data files to be merged are located
files<-list.files(dir,".txt") #create list of files to be merged

combo<-vector(mode="numeric") #set empty vector to be filled
for (file in files){ #loop to bind all files together
  data<-read.table(paste(dir,file,sep=""))
  if (length(combo)==0){
    combo<-vector(mode="numeric",length=nrow(data))
  }
  combo<-cbind(combo,data)
}

train<-combo[,-1] #remove extra column
names(train)<-c("subject",f_labels,"activity")

#merge test and train data sets

all<-bind_rows(test,train)

#find columns that either have "mean()" or "std()" in them
ms_cols<-grep("mean()|std()",names(all))

sd_df<-all[,c(1,479,ms_cols)] #select only mean/sd columns, plus subject and activity info
sd_df$activity<-lookup(sd_df$activity,a_labels) #replace activity numbers with their labels
sd_df$subject<-as.factor(sd_df$subject) #make subject numbers factors

#make data set with subject means for each variable
subj_df<- sd_df %>% 
  group_by(subject,activity) %>% #group by subject, then activity
  summarise_each(funs(mean)) #means for each variable

write.table(subj_df,"subj_output.txt",row.names=FALSE)


