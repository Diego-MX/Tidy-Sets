## Project with Data from Experiment with Samsung's phone
###### Coursera > Johns Hopkins > Data Science (*Jeff*, Roger, Brian) > Getting and Cleaning Data
###### UCI M.L. Repo, Experiment data by Jorge, Davide, Alessandro, Luca, Xavier
###### February 2015, get.clean.data-Project, Diego from Mexico

This is a class project from Coursera.  We are to download experiment data from a website and follow the guidelines.  In this document I include comments about the script `run_analysis.R`.  

The order which I've followed in the script corresponds to the requirements from the guidelines, and doesn't necessarily optimize computer resources. 

I use double question marks for questions, if any, and a compact style of coding for `R`.  I apologise in advance.

#### Step 0. Set-up the workbench
When running in `iteractive` mode, I've included interaction with the user to determine whether we're at the right directory.  Then we download and unzip if it hasn't already been done that. 

#### Step 1. Merge data
To merge, we rowbind the datasets obtained in the corresponding folders `train` and `test`.

#### Step 2. Mean and Standard Deviation
Use `grep` function to find `'mean'` and `'std'` text in features, and *select* those from the column indices. 

#### Step 3. Activity Names
Activity names are found from the `y` text files according to the keys in `activity_labels.txt`.  To get those we row bind the `y` files, and we *join* the corresponding column.

#### Step 4. Variable Labels
Variable labels were found from the `features` text file.  Since we had selected columns during the import, we must filter the corresponding idices as well. 

#### Step 5. Averages
We must first get the data corresponding to the subject.  Then we add a corresponding column as we did with activities.  






