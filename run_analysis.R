run_analysis <- function(){
    ## Assume current working directory has UCI HAR Da
    ## Define paths for reading raw data
    feature_path       <- "./UCI HAR Dataset/features.txt"
    trainset_path      <- "./UCI HAR Dataset/train/X_train.txt"
    trainlabel_path    <- "./UCI HAR Dataset/train/y_train.txt"
    trainsubject_path  <- "./UCI HAR Dataset/train/subject_train.txt"   
    testset_path       <- "./UCI HAR Dataset/test/X_test.txt"
    testlabel_path     <- "./UCI HAR Dataset/test/y_test.txt"
    testsubject_path   <- "./UCI HAR Dataset/test/subject_test.txt"
    activitylabel_path <- "./UCI HAR Dataset/activity_labels.txt"
    ## Read each data sets into variables
    feature        <- read.table(feature_path, header=FALSE)
    train_set      <- read.table(trainset_path, header=FALSE)
    test_set       <- read.table(testset_path, header=FALSE)
    train_label    <- read.table(trainlabel_path, header=FALSE)
    test_label     <- read.table(testlabel_path, header=FALSE)
    train_subject  <- read.table(trainsubject_path, header=FALSE)
    test_subject   <- read.table(testsubject_path, header=FALSE)
    activity_label <- read.table(activitylabel_path, header=FALSE)
    ## Assign subject and activity names
    names(train_subject) <- "subject"
    names(test_subject)  <- "subject"
    names(train_label)   <- "activity"
    names(test_label)    <- "activity"
    ## Add subject and label columns to train set and test set
    train_set <- cbind(train_subject,train_label,train_set)
    test_set  <- cbind(test_subject,test_label,test_set)
    ## Merge train set and test set
    ## Set column names according to feature.txt
    merge_set <- merge(train_set, test_set, all=TRUE)
    names(merge_set) <- c(names(merge_set)[[1]], names(merge_set)[[2]], as.vector(feature[,2]))
    ## Extract columns on mean and standard deviation measurement
    filter_set <- merge_set[,grepl("*mean[^a-zA-Z]|std[^a-zA-Z]|activity|subject",names(merge_set))]
    ## Read activity label and map each label into descriptive names
    ## Calculate average of each variable for each activity and each subject
    factor <- as.vector(activity_label[, 2])
    filter_set$activity <- factor(filter_set$activity,levels=1:nrow(activity_label),labels=factor)
    tidy_data<-aggregate(filter_set[,3:ncol(filter_set)],list(subject=filter_set$subject,activity=filter_set$activity),mean)
    ## Write tidy data to txt file for further processing
    write.table(tidy_data,file="tidy_data.txt",row.names=FALSE)
}