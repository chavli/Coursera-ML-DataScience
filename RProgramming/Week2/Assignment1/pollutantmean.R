setwd("/home/cha/Coursera/RProgramming/Week2/Assignment1")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # values needed to calculate the mean
  cur_sum = 0
  cur_count = 0
  
  # loop through the given files
  for(cur_id in id){
    
    # prepend 0's as needed so all numbers have 3 digits
    if(cur_id < 10){
      cur_id = paste("00", cur_id, sep="")
    }
    else if (cur_id < 100){
      cur_id = paste("0", cur_id, sep="")
    }
    
    # read the file
    filename = paste(directory, "/", cur_id, ".csv", sep="")
    
    # get the values of the pollutant
    data = read.csv(filename)
    vals = data[[pollutant]]
    
    # count and sum non-na values
    cur_count = cur_count + sum(!is.na(vals))
    cur_sum = cur_sum + sum(vals[!is.na(vals)])
  }
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  return(cur_sum/cur_count)
}

# source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
