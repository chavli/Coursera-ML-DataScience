setwd("/home/cha/Coursera/RProgramming/Week4/Assignment3")
source("totitle.R")

best <- function(state, outcome) {
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
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  as.character(subdata[1, "Hospital.Name"])
}