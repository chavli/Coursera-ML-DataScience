setwd("/home/cha/Coursera/RProgramming/Week4/Assignment3")
source("totitle.R")

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data = read.csv("outcome-of-care-measures.csv")
  
  ## Check that outcome is valid
  outcome = totitle(outcome)
  outcome = gsub(x = outcome, pattern = " ", replacement = ".")
  target = paste("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep="")
  
  if (!target %in% names(data)){
    stop("invalid outcome")  
  }
  
  flags = data[target] != "Not Available"
  subdata = data[flags , c("Hospital.Name", "State", target)]
  subdata[, target] = sapply(subdata[, target], as.character)
  subdata[, target] = sapply(subdata[, target], as.numeric)
  

  ## split the data and get the specified rank from each state
  split_data = split(x = subdata, f = subdata$State)
  all_rankings = lapply(split_data, function(x){
      x = x[order(x[target], x["Hospital.Name"], decreasing = F), ]
      
      if(is.character(num)){
        if(num == "best"){
          num = 1
        }
        else if(num == "worst"){
          num = nrow(x)
        }
      }
      else{
        if(num > nrow(subdata))
          return(NA)
      }
      
      x[num, ]
    })
  
  # extract the data we want
  states = names(all_rankings)
  hospitals = as.vector(sapply(all_rankings, function(x){ as.character(x$Hospital.Name) }))
  data.frame(hospital = hospitals, state=states)
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}