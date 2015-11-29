setwd("/home/cha/Coursera/RProgramming/Week2/Assignment1")

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  # data frame to keep track of file ids and their counts of complete rows. initially all 0
  complete_counts = data.frame(id=rep(0, length(id)), nobs=rep(0, length(id)))
  
  # check each file
  for(i in seq_along(id)){
    cur_id = id[i]
    
    # prepend 0's as needed so all numbers have 3 digits
    full_id = if(cur_id < 10){
      paste("00", cur_id, sep="")
    }
    else if (cur_id < 100){
      paste("0", cur_id, sep="")
    }
    else{
      cur_id
    }
    
    # read the file
    filename = paste(directory, "/", full_id, ".csv", sep="")
    data = read.csv(filename)
    
    # count and store the complete counts
    good = complete.cases(data)
    complete_data = data[good, ]
    n = nrow(complete_data)
    complete_counts[i, "id"] = cur_id
    complete_counts[i, "nobs"] = n
    
  }
  
  return(complete_counts)
}