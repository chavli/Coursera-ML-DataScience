rankall <- function(outcome, num = "best") {
  orig_num = num
  data = read.csv("outcome-of-care-measures.csv", colClasses="character")
  valid_outcomes = c("heart attack", "heart failure", "pneumonia")
  idx_map = data.frame(outcomes=c("heart attack", "heart failure", "pneumonia"), idx=c(11, 17, 23))
  
  if( !(state %in% data$State) ){
    stop("invalid state")
  }
  
  if( !(outcome %in% valid_outcomes)){
    stop("invalid outcome")
  }
  
  # put data in correct format
  data[, coln] = as.numeric(data[, coln])
  data$Hospital.Name = as.character(data$Hospital.Name)
  data$State = as.character(data$State)
  
  coln = idx_map[ idx_map$outcomes == outcome, "idx"]
  
  # split the data and sort each 
  split_data = split(data, data$State)
  idxs = lapply(split_data, function(x, ...){
    order(x[, coln], x$Hospital.Name, decreasing=c(F, F) )
  })
  
  
  all_states = vector()
  all_hospitals = vector()
  
  for( i in seq(1, length(idxs))){
    state_data = data.frame(split_data[[i]])[idxs[[i]], ]
    
    #determine the requested ranking
    num = orig_num
    if( is.character(num)){
      if( num == "best"){ num = 1 }
      else if( num == "worst"){num = which.max(state_data[, coln]) }
      else{ return(NA) }
    }
    
    all_states = rbind(all_states, state_data[1, "State"])
    all_hospitals = rbind(all_hospitals, state_data[num, "Hospital.Name"])
  }
  
  return( data.frame(hospital = all_hospitals, state = all_states ) )
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}