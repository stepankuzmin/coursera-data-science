# Getting and Cleaning Data Course Project

## Description

This repository is a course project assignment for Coursera's Getting and Cleaning Data course.

### Repository includes the following files:

* `run_analysis.R` -- script for data analysis
* `CodeBook.md` -- codebook for tidy data set, created by `run_analysis.R` script
* `README.md` -- this readme

## Dependencies

`run_analysis.R` needs `dplyr` library to be installed into R:

```r
install.packages("dplyr")
```

## Installation

Clone this repository

```shell
git clone git@github.com:StepanKuzmin/getting-and-cleaning-data-course-project.git
```

### Preparing Human Activity Recognition Using Smartphones data set

Full data set description is located [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Download [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it to folder, where `run_analysis.R` is located.

```
getting-and-cleaning-data-course-project
├── CodeBook.md
├── README.md
├── UCI\ HAR\ Dataset
│   ├── README.txt
│   ├── activity_labels.txt
│   ├── features.txt
│   ├── features_info.txt
│   ├── test
│   │   ├── Inertial\ Signals
│   │   │   ├── body_acc_x_test.txt
│   │   │   ├── body_acc_y_test.txt
│   │   │   ├── body_acc_z_test.txt
│   │   │   ├── body_gyro_x_test.txt
│   │   │   ├── body_gyro_y_test.txt
│   │   │   ├── body_gyro_z_test.txt
│   │   │   ├── total_acc_x_test.txt
│   │   │   ├── total_acc_y_test.txt
│   │   │   └── total_acc_z_test.txt
│   │   ├── X_test.txt
│   │   ├── subject_test.txt
│   │   └── y_test.txt
│   └── train
│       ├── Inertial\ Signals
│       │   ├── body_acc_x_train.txt
│       │   ├── body_acc_y_train.txt
│       │   ├── body_acc_z_train.txt
│       │   ├── body_gyro_x_train.txt
│       │   ├── body_gyro_y_train.txt
│       │   ├── body_gyro_z_train.txt
│       │   ├── total_acc_x_train.txt
│       │   ├── total_acc_y_train.txt
│       │   └── total_acc_z_train.txt
│       ├── X_train.txt
│       ├── subject_train.txt
│       └── y_train.txt
└── run_analysis.R
```

## Running analysis

```shell
Rscript run_analysis.R
```

After running this command, `tidy.txt` and `means_by_subject_activity.txt` will appear in the same directory.

* `tidy.txt` is a tidy data set created by `run_analysis.R` script from UCI HAR Dataset. Detailed description of this data set is located in [CodeBook.md](CodeBook.md).
* `means_by_subject_activity.txt` is a independent tidy data set with the average of each variable for each activity and each subject from `tidy.txt`.