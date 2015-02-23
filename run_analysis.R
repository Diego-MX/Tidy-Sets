# Diego-MX, February 2015.

# ==============================================================
## STEP 0.  Define directory and download data.

library(ddply)

if(interactive()){
    cat(paste0("Hey, this is the script that completes the ",
        "project for Coursera's Getting and Cleaning Data.\n",
        "Diego thanks Jeff and sends regards from Mexico."))
    guest <- readline("...¿Your name?... ")
    isWork <- readline(paste0("Mmph, whatever. ¿Are we in the ",
        "working directory now?  Y/n... "))

    if(tolower(isWork) != 'n'){
      cat("Mmph.  Now back to business.")
    }else{
      isDiego <- readline(paste0("¿Do we go to the standard ",
        "directory?  Y/n... "))
      if(tolower(isDiego) == "n"){
        stop("Ugh. Then where?  Figure it out, will you?")
      }else{
        workdir <- paste0("~/Sync/Dropbox/R/Coursera/",
          "3 Cleaning Data/Project-get.clean.data/")
        setwd(workdir)}}
}#EndInteractiveIf


if(!file.exists("Samsung.zip")){
    url = paste0("https://d396qusza40orc.cloudfront.net",
        "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    download.file(url, "Samsung.zip", method='curl')}

if(!file.exists("UCI HAR Dataset")){
    unzip("Samsung.zip")}

setwd("UCI HAR Dataset")


# ==============================================================
# Step 1.  Merge data

data <- data.frame()
types <- c("test", "train")
for(tp in types){
    setwd(tp)
    Xfile <- sprintf("X_%s.txt", tp)
    X <- read.table(Xfile, colClasses="numeric", nrows=10000)
    data <- rbind(data, X)
    setwd("../")}


# ==============================================================
# Step 2.  Mean and Standard Deviation

features <- read.table("features.txt", row.names=1,
    col.names=c("ft_id", "feat"), nrows=600, stringsAsFactors=F)

meanInd <- grep('mean\\(\\)', features$feat, ignore.case=T)
stdInd  <- grep('std\\(\\)',  features$feat, ignore.case=T)
indices <- sort(c(meanInd, stdInd))

data <- data[indices]


# ==============================================================
# Step 3. Activity names.

activities <- read.table("activity_labels.txt", row.names=1,
    col.names=c("id", "activity"), nrows=10)

actvty <- data.frame()
types <- c("test", "train")
for(tp in types){
    setwd(tp)
    yfile <- sprintf("y_%s.txt", tp)
    y <- read.table(yfile, colClasses="integer", nrows=10000,
        col.names="act_id")
    actvty <- rbind(actvty, y)
    setwd("../")}

data$activity <- activities$activity[actvty$act_id]
# Wow! what a line!


# ==============================================================
# Step 4. Variable Labels

# Create auxiliary variable LABELS because of the added columns.
labels <- colnames(data)
labels[1:length(indices)] <- features$feat[indices]
colnames(data) <- labels


# ==============================================================
# Step 5. Averages.

subject <- data.frame()
types <- c("test", "train")
for(tp in types){
    setwd(tp)
    sbjfile <- sprintf("subject_%s.txt", tp)
    sbj <- read.table(sbjfile, colClasses="integer",
        nrows=10000, col.names="sbj_id")
    subject <- rbind(subject, sbj)
    setwd("../")}

data$subject <- subject$sbj_id

averages <- ddply(data, .(activity, subject), colwise(mean))
