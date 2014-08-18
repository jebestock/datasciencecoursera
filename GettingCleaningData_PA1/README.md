## Description of run_anaysis.R

This readme describes the script run_analysis.R for 
the course project of the Getting and Cleaning Data course. 
The script requires the *reshape2* package.
It is assumed that the data from the link
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">SmartphoneDataSet</a> 
is downloaded and unpacked. 
The folder containing the data is to be set in the variables **dir**, **dir_test** and **dir_trai** at the top of the script.
At the level of **dir** the 
files

- *activity_labels.txt*  
- *features.txt* 

are expected.

At the level of **dir_test**
the script expects the data for the test set

- *X_test.txt*  
- *subject_test.txt*  
- *y_test.txt* 


At the level of **dir_trai** 
the script expects the data for the training set

- *X_train.txt*  
- *subject_train.txt*  
- *y_train.txt*  

Upon calling of run_analysis.R a tidy data set is created in the very same 
folder as the script is located. The file name of the file created is
*GetAndCleanCourseProjTidyData.txt*. It is as a text file with blank column separation. It contains a single-row header with the column names of the data frame.




