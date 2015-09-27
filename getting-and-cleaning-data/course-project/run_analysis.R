library(dplyr)

# === SET UP FEATURES ===

# read feature names from `features.txt` as `tbl_df`
features <- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE) %>% tbl_df

# create valid column names for each data set
column_names <- make.names(names = features$V2, unique = TRUE, allow_ = TRUE)


# === SET UP LABELS ===

# read activity labels from `activity_labels.txt` as `tbl_df`
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE) %>% tbl_df



# === SET UP TEST DATA SET ===

# read test data set subjects from `test/subject_test.txt` as `tbl_df`
test_subjects <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = FALSE) %>% tbl_df

# read test data set labels from `test/y_test.txt` as `tbl_df`
test_labels <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = FALSE) %>% tbl_df

# create test data set activity factor based on activity labels
test_activity <- cut(test_labels$V1, breaks = nrow(activity_labels), labels = activity_labels$V2)

test <- # read test data set from `test/X_test.txt` as `tbl_df`
        read.table(file = "UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = column_names) %>% tbl_df %>%

        # select all variables, which name contains either `.mean.` or `.std.`
        select(matches("\\.mean\\.|\\.std\\.")) %>%

        # append subject and activity factor variables
        mutate(subject = test_subjects$V1, activity = test_activity)

# cleanup
rm(test_subjects, test_labels, test_activity)



# === SET UP TRAIN DATA SET ===

# read train data set subjects from `train/subject_train.txt` as `tbl_df`
train_subjects <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = FALSE) %>% tbl_df

# read train data set labels from `train/y_train.txt` as `tbl_df`
train_labels <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = FALSE) %>% tbl_df

# create train data set activity factor based on activity labels
train_activity <- cut(train_labels$V1, breaks = nrow(activity_labels), labels = activity_labels$V2)

train <- # read train data set from `train/X_train.txt` as `tbl_df`
        read.table(file = "UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = column_names) %>% tbl_df %>%

        # select all variables, which name contains either `.mean.` or `.std.`
        select(matches("\\.mean\\.|\\.std\\.")) %>%

        # append subject and activity factor variables
        mutate(subject = train_subjects$V1, activity = train_activity)

# cleanup
rm(train_subjects, train_labels, train_activity)



# === MERGE DATA SETS ===

# merge test and train data sets as new shiny tidy data set
tidy <- merge(test, train, all = TRUE)

# save tidy data set to `tidy.txt` file
write.table(x = tidy, file = "tidy.txt", row.name = FALSE)

# calculate average of each variable for each activity and each subject
means_by_subject_activity <- tidy %>%

                             # group data set by subject and activity
                             group_by(subject, activity) %>%

                             # calculate average of each variable
                             summarise_each(funs(mean))

# save means by subject activity data set to `means_by_subject_activity.txt` file
write.table(x = means_by_subject_activity, file = "means_by_subject_activity.txt", row.name = FALSE)

# cleanup
rm(features, column_names, activity_labels, test, train)