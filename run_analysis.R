> #download and unzipping dataset
> if(!file.exists("./data")){dir.create("./data")}
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl,destfile="./data/week4dataset.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> unzip(zipfile="./data/week4dataset.zip",exdir="./data")
>
>
> #Merge the training set and test set into one dataset
> xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
> ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
> subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
> xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
> ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
> subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
> features <- read.table('./data/UCI HAR Dataset/features.txt')
> activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
>
>
> colnames(xtrain) <- features[,2] 
> colnames(ytrain) <-"activityId"
> colnames(subjecttrain) <- "subjectId"
> colnames(xtest) <- features[,2] 
> colnames(ytest) <- "activityId"
> colnames(subjecttest) <- "subjectId"
> colnames(activityLabels) <- c('activityid','activityType')
>
>
> merge_train <- cbind(ytrain, subjecttrain, xtrain)
> merge_test <- cbind(ytest, subjecttest, xtest)
> merge_all <- rbind(merge_train, merge_test)
> colNames <- colnames(merge_all)
> mean_and_std <- (grepl("activityId" , colNames) |
+ grepl("subjectId" , colNames) |
+ grepl("mean.." , colNames) | 
+ grepl("std.." , colNames))
>
>
> setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
> setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
+ by='activityId',
+ all.x=TRUE)
>
>
> #Create a secondary tidy data set
> sectidydateset <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
> sectidydateset  <- sectidydateset [order(sectidydateset$subjectId, sectidydateset$activityId),]
> write.table(sectidydateset, "sectidydateset.txt", row.name=FALSE)