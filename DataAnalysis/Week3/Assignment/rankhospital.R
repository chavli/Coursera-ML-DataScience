rankhospital <- function(state, outcome, num = "best") {
  data = read.csv("outcome-of-care-measures.csv", colClasses="character")
  valid_outcomes = c("heart attack", "heart failure", "pneumonia")
  idx_map = data.frame(outcomes=c("heart attack", "heart failure", "pneumonia"), idx=c(11, 17, 23))
  
  if( !(state %in% data$State) ){
    stop("invalid state")
  }
  
  if( !(outcome %in% valid_outcomes)){
    stop("invalid outcome")
  }

  state_data = data[ data$State == state, ]
  coln = idx_map[ idx_map$outcomes == outcome, "idx"]
  
  # put data in correct format
  state_data[, coln] = as.numeric(state_data[, coln])
  state_data$Hospital.Name = as.character(state_data$Hospital.Name)
  
  idx = order(state_data[, coln], state_data$Hospital.Name, decreasing=c(F, F))
  state_data = state_data[idx, ]  
  
  #determine the requested ranking
  if( is.character(num)){
    if( num == "best"){ num = 1 }
    else if( num == "worst"){num = which.max(state_data[, coln]) }
    else{ return(NA) }
  }
  else if( num > nrow(state_data) ){ return(NA) }

  return(state_data[num, "Hospital.Name"])
}