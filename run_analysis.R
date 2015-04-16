# Diego-MX, February 2015.
# Modified on April 2015

# ==============================================================
## STEP 0.  Define directory and download data.

library(dplyr)

if(interactive())
{ cat(paste0("Hey, this is the script that completes the ",
    "project for Coursera's Getting and Cleaning Data.\n",
    "Diego thanks Jeff and sends regards from Mexico."))
  guest  <- readline("...¿Your name?... ")
  isWork <- readline(paste0("Mmph, whatever. ¿Are we in the ",
    "working directory now?  Y/n... "))

  if(tolower(isWork) != 'n')
  { cat("Mmph.  Now back to business.")
  } else
  { toStandard <- readline(paste0("¿Do we go to the standard ",
      "directory?  Y/n... "))

    if(tolower(toStandard) == "n")
    { stop("Ugh. Then where?  Figure it out, will you?")
    } else
    { setwd(paste0("~/Sync/Dropbox/R/Coursera/",
        "3 Cleaning Data/Tidy Sets/"))
    }
  }
}

if(!file.exists("./data/UCI HAR Dataset.zip"))
{ url = paste0("https://d396qusza40orc.cloudfront.net",
    "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  download.file(url, "./data/UCI HAR Dataset.zip",
    method='curl')
}
if(!file.exists("./data/UCI HAR Dataset"))
{ unzip("./data/UCI HAR Dataset.zip", exdir="./data")
  system("mv ./data/UCI\\ HAR\\ Dataset/* ./data/")
}


# ==============================================================
# Step 1.  Merge data

X <- y <- subject <- data_frame()
for(tp in c("test", "train")) for(var in c("X", "y", "subject"))
{ varFile <- sprintf("./data/%1$s/%2$s_%1$s.txt", tp, var)

  var_ <- read.table(varFile, quote="", nrows=9000,
    comment.char="")
  eval(parse(text=sprintf("%1$s <- rbind(%1$s, var_)", var)))
}


# ==============================================================
# Step 2. Mean and Standard Deviation

features <- read.table("./data/features.txt",
  col.names=c("feat_id", "feat_name"), stringsAsFactors=F)

X <- X[grepl('(mean|std)\\(\\)', features$feat_name)]


# ==============================================================
# Step 4. Variable Labels

Xindices <- as.integer(sub("V", "", names(X)))
names(X) <- features$feat_name[Xindices]


# ==============================================================
# Step 3. Activity names.

activities <- read.table("./data/activity_labels.txt",
  col.names=c("act_id", "activity"))

names(y) <- "act_id" # Rename for the left_join to be automatic
X$activity <- left_join(y, activities, by=c("V1"="act_id")) %>%
  '[['("activity")


# ==============================================================
# Step 5. Subjects and averages.

X$subject <- subject$V1
averages  <- group_by(X, activity, subject) %>%
  summarise_each(funs(mean))


# ==============================================================
# Step 6. Later instructions.

write.table(averages, "./averages.txt", row.name=F)





