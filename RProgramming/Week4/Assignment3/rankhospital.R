setwd("/home/cha/Coursera/RProgramming/Week4/Assignment3")
source("totitle.R")

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data = read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if( !state %in% unique(data$State) ){
    stop("invalid state")
  }
  
  # convert the outcome into the proper format
  outcome = totitle(outcome)
  outcome = gsub(x = outcome, pattern = " ", replacement = ".")
  target = paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep="")
  
  if (!target %in% names(data)){
    stop("invalid outcome")  
  }
  
  
  subdata = data[data$State == state, c("Hospital.Name", target)]
  
  # remove bad cases
  flags = subdata[target] != "Not Available"
  subdata = subdata[flags, ]
  
  # factor to numeric
  subdata[, target] = sapply(subdata[, target], as.character)
  subdata[, target] = sapply(subdata[, target], as.numeric)
    
  # sort the data by increasing mortality rate
  subdata = subdata[order(subdata[target], subdata["Hospital.Name"], decreasing = F), ]
  
  
  # convert num to an int if necessary
  if(is.character(num)){
    if(num == "best"){
      num = 1
    }
    else if(num == "worst"){
      num = nrow(subdata)
    }
  }
  else{
    if(num > nrow(subdata))
      return(NA)
  }
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  as.character(subdata[num, "Hospital.Name"])
}