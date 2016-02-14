# Tidied Data from the Human Activity Recognition Using Smartphones Dataset

This project uses data from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This is a data set represents data collected from the accelerometers from the Samsung Galaxy S smartphones.

A few steps were taken to transform the initial data set. The test and train sets have were merged and the subject identifiers and activity labels were pulled in to create a single data set. Acitivity labels were applied to clarify each activity. Only the mean and standard deviation variables were retained, and data is presented as averages across subjects and activity.

The final data set can be found in the `subj_output.txt` file, which can be read into R with `read.table("subj_output.txt", header = TRUE)`. A detailed description of the variables can be found in `CodeBook.md`. The basic naming convention is:

  Mean{timeOrFreq}{measurement}{meanOrStd}{XYZ}

Where `timeOrFreq` is either Time or Frequency, indicating whether the measurement comes from the time or frequency domain, `measurement` is one of the original measurement features, `meanOrStd` is either Mean or StdDev, indicating whether the measurement was a mean or standard deviation variable, and `XYZ` is X, Y, or Z, indicating the axis along which the measurement was taken, or nothing, for magnitude measurements.

The script used to transform the data is run_analysis.R. This script assumes that all data files were unzipped, file structure kept the same, and the main unzipped folder is set as your working directory.
