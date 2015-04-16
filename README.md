## Project with Data from Experiment with Samsung's phone
###### Coursera > Johns Hopkins > Data Science (*Jeff*, Roger, Brian) > Getting and Cleaning Data
###### UCI M.L. Repo, Experiment data by Jorge, Davide, Alessandro, Luca, Xavier
###### April 2015, Tidy-Sets, Diego from Mexico

This is a class project from Coursera.  We are to download experiment data from a website and follow the guidelines.  In this document I include comments about the script `run_analysis.R`.  

I refer to the numbering instructions as steps.  For coding flow I switched the steps 3 and 4. 

#### Step 0. Set-up the workbench
When running in `iteractive` mode, I've included interaction with the user in order to acknowledge work from other people.  I ask about the working directory and download data if necessary.

#### Step 1. Merge data
To merge, we rowbind the datasets obtained in the corresponding folders `train` and `test`.  That is for each labeled `X`, `y` or `subject`.  We assume the observations across such files correspond between each other. 

#### Step 2. Mean and Standard Deviation
Use `grep` function to find `'mean'` and `'std'` text in features, and subset-select those from the column indices. 

#### Step 4. Variable Labels
Havig selected the indicated columns, we import the `features` text file and match the corresponding names to the columns. 

#### Step 3. Activity Names
Activity names are found from the `y` text files according to the keys in `activity_labels.txt`.  We do a "left join" to add the labels, with care as to how to name the by variables.  The subsetting operation is needed for compatibility within the data frames. 

#### Step 5. Subject and Averages
We add the subject column to the data, and then we summarize based on functions from `dplyr` package. 

#### Step 6. Writing
Use `write.table()` as instructed.




