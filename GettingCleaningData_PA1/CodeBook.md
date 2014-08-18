## Description of data and variables used by run_analysis.R

This code book describes the data and variables used by the script
run_analysis.R for 
the course project of the Getting and Cleaning Data course. 
It is assumed that the data from the link
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">SmartphoneDataSet</a> 
is downloaded and unpacked. 
The folder containing the data is to be set in the variables **dir**, **dir_test** and **dir_trai** at the top of the script.
At the level of **dir** the 
files

- *activity_labels.txt*  (assigned to **actLabels** after read.table)
- *features.txt* (assigned to **features** after read.table)

are expected.

At the level of **dir_test**
the script expects the data for the test set

- *X_test.txt*  (assigned to **testX** after read.table)
- *subject_test.txt*  (assigned to **testS** after read.table)
- *y_test.txt*  (assigned to **testA** after read.table).


At the level of **dir_trai** 
the script expects the data for the training set

- *X_train.txt*  (assigned to  **traiX** after read.table)
- *subject_train.txt*  (assigned to  **traiS** after read.table)
- *y_train.txt*  (assigned to  **traiA** after read.table).

 

After reading in the data, first the column names of the data **testX** and 
**traiX** are assigned the names given in the 2nd column of the feature file *features.txt*.
Then the test and training data are concatenated to one data frame and is assigned the variable **X**. 

To this data frame we add 2 more columns containing the corresponding activity (**X\$Act**) and the 
subject (**X\$Subject**) which itself are constructed by concatenating 
**testA** and **traiA** as well as **testS** and **traiS**, respectively.

From the 2nd column of the data frame  **features** (being a list of all measurement variable names) we identify those variable names which refer to mean or standard deviation 
measurements. The matching indices within the list **features** are assigned
to the index vector **Ids**.
The latter is then used to extract the mean and standard deviation measurements from the big data frame **X** and assign it the new smaller data frame
**X_ms** which contains 88 columns (86 columns of mean/std-data + subject column + activity column).

The script then assigns descriptive names to the column **X_ms$Act** 
by first converting the integer range into a factor variable followed by assigning the factor variable descriptive level names ("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING").

In the last step the data set is made tidy by first melting the data frame **X_ms** into a 4 column dataset where the activity and subject
columns are kept. The new 2 columns contain the names of the melted column variable and its variable value, respectively. The thus obtained melted data frame is called **X_ms_melt**. It is a data frame with 885714 rows and 4 columns.

Finally, the mean is computed over each variable in the melted data frame having a constant activity and subject value. Here, the dcast()-function can
do the job for us.
The tidy data set is then assigned to **X_ms_tidy**. It is a data frame with 180 rows and 88 columns (86 columns of mean/std-data + subject column + activity column). The data frame is written to the hard disc (*GetAndCleanCourseProjTidyData.txt*) as a text file with blank column separation by means of the write.table function.




