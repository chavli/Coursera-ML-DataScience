1. Preparing the text files.

All the required raw text files have been compressed into a zip file named "raw_data.zip". This zip file can be found in the "raw_data"
folder.

Extract the contents of the zip file into the raw_data folder. make sure another raw_data folder isn't created inside the current raw_data
folder


2. Running the R script.

run_analysis.R can be executed by itself or executed by first opening the RStudio project file: Project.Rproj

run_analysis.R requires the above steps to be performed correctly. The necessary files should be at the following locations relative to
the script:

    raw_data/train/X_train.txt
    raw_data/test/X_test.txt
    raw_data/train/subject_train.txt
    raw_data/test/subject_test.txt
    raw_data/train/y_train.txt
    raw_data/test/y_test.txt
    raw_data/activity_labels.txt
    raw_data/features.txt

If the folders are correctly made, then run_analysis.R will execute and produce the output of step 5 in the assignment: results.txt