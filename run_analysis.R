# Coursera 'Cleaning and Getting Data', Assignment for Week 4

# The script loads and merges data from the UCI HAR Dataset. 
# It filters only for mean and std columns, and makes the table more descripive
# Lastly, it creates a summarised output called "tidy_data"

# The five different sub-tasks are marked with (1), (2), etc. 


# Load dplyr library (used in part 5):
library(dplyr)


# (1) Merges the training and the test sets to create one data set.

# Read data files. Assumes the files have been unzipped and stored in the 'UCI HAR Dataset' folder. 
# Note: Loading of the data may take a few moments.

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


# Merge the data sets:

  # First combine the columns of the shorter 'test' set and the longer 'train' set,
  # then combine the rows of both data sets. 
  merged_data <- rbind(cbind(subject_test, y_test, X_test), cbind(subject_train, y_train, X_train))


# (2) Extracts only the measurements on the mean and standard deviation for each measurement.

# Get column names and find 'mean' and 'std'
variables_list <- readLines("./UCI HAR Dataset/features.txt")

  variables_list <- c("subject_data", "y_data", variables_list)

  colnames(merged_data) <- variables_list
  
filtered_data <- merged_data[grep("subject_data|y_data|mean()|std()", colnames(merged_data))]


# (3) Uses descriptive activity names to name the activities in the data set.

# Load activity labels from file and split into look-up table
lookUpVec <- readLines("./UCI HAR Dataset/activity_labels.txt")
lookUpVec <- as.data.frame(lookUpVec)
colnames(lookUpVec)[1] <- "Activity_labels"
lookUpVec <- lookUpVec %>% separate(Activity_labels, c("Number", "Label"), " ")

filtered_data$y_data <- lookUpVec$Label[match(unlist(filtered_data$y_data), lookUpVec$Number)]


# (4) Appropriately labels the data set with descriptive variable names.

# Clean variables names

variables_list <- colnames(filtered_data)

  # Remove column index numbers
  variables_list <- gsub("[[:digit:]]+", "", variables_list)
  # Remove whitespace
  variables_list <- trimws(variables_list, which = ("left"))
  #Remove () from mean and standard deviation columns
  variables_list <- gsub("\\(\\)", "", variables_list)
  #Subsitute "-" with "."
  variables_list <- gsub("\\-", "\\.",variables_list)
  #Change name for first and second columns
  variables_list[1] <- "Subject.ID"
  variables_list[2] <- "Activity"
  
  
colnames(filtered_data) <- variables_list


# (5) From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

# Create a separate dataset grouped by Subject.ID and Activity
# then summarise each variable, creating an average
tidy_data <- filtered_data %>% 
  arrange(Subject.ID) %>%
  group_by(Subject.ID, Activity) %>%
  summarise_all(mean)


  # Visualising the output:
    #In RStudio:
      View(tidy_data)
    
    #Write output to txt-file. The file is separated by spaces. Remove '#' to activate line: 
      # write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

