
## remove all varibles that exist
rm(list = setdiff(ls(), lsf.str()))

##reading all training data
X_train <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"")

y_train <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")

subject_train <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")

##reading all testing data
X_test <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"")

y_test <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")

subject_test <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")
>   View(subject_test)

##reading features
features <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"")

##reading actvity labels
act_labels <- read.table("D:/DataScience/CleaningData/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"")

## labeling traing and testing data
names(X_test) = as.character((features[,2]))
names(X_train) = as.character((features[,2]))
names(y_test) = "outid"
names(y_train) = "outid"
names(subject_train) = "subid"
names(subject_test) = "subid"

## labeling activity data
names(act_labels) = c("id","output")

## combining X and Y training data
train_d = cbind(X_train,y_train)
## combining X and Y traing data with subject
train_data = cbind(train_d,subject_train)

## combining X and Y test data
test_d = cbind(X_test,y_test)
## combining X and Y test data with subject
test_data = cbind(test_d,subject_test)

## combining traing and testing data into 1 dataframe
tempdata <- rbind(train_data,test_data)

## combining dataframe with activity labels columns 
c_data <- merge(tempdata,act_labels,by.x="outid",by.y="id")

## Getting columns with Mean and Std 
measure_data <- c_data[,grep('mean|std|Mean|subid|outid|output',names(c_data))]

## Creatings independent tidy data set with the average of each variable for each activity and each subject. 

for (i in 1:30)
{
	t1 <- subset(measure_data,measure_data$subid==i)
	for (j in 1:6)
	{
		t2 <- subset(t1,t1$outid == j)
		if (!exists("myframe")){
		      myframe <- sapply(t2,mean)
			myframe["output"] = as.character(t2[1,"output"])
	
		    }
		else
		{
			mytemp <- sapply(t2,mean)
			mytemp["output"] = as.character(t2[1,"output"])
			myframe <- rbind(myframe,mytemp)
		}
	}

}
tidydata <- data.frame(myframe)
drops <- c("outid")
tidydata <- tidydata[,!(names(tidydata) %in% drops)]

## writing tidydata in txt file
write.table(tidydata, file = "tidydata.txt", sep = ",", col.names = colnames(tidydata))