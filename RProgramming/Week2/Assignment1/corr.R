setwd("/home/cha/Coursera/RProgramming/Week2/Assignment1")
source("complete.R")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  # get the count of number of complete cases for each file
  complete_counts = complete(directory)
  good = complete_counts[complete_counts$nobs >= threshold[1], ]
  
  # get valid file ids
  target_ids = good["id"]
  
  # return 0 if there are no valid files
  if(nrow(target_ids) < 1){
    return(as.numeric(vector()))
  }
  
  corrs = vector(length = length(target_ids))
  
  # prepend 0's as needed so all numbers have 3 digits
  for(i in 1:nrow(target_ids)){
    cur_id = target_ids[i, "id"]
    
    full_id = if(cur_id < 10){
      paste("00", cur_id, sep="")
    }
    else if (cur_id < 100){
      paste("0", cur_id, sep="")
    }
    else{
      cur_id
    }
    
    # open file, and calculate correlato=ion between non-na values in sulfate and nitrate columns
    filename = paste(directory, "/", full_id, ".csv", sep="")
    data = read.csv(filename)
    clean_data = data[complete.cases(data), ]
    corrs[i] = cor(clean_data$sulfate, clean_data$nitrate)
  }
  return(corrs)
}
