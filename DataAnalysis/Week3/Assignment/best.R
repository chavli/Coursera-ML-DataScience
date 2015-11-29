# Finding the best hospital in a state

best <- function(state, outcome) {
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
  state_data$Hospital.Name <- as.character(state_data$Hospital.Name)
  metric_data = as.numeric(state_data[ ,idx_map[ idx_map$outcomes == outcome, "idx"]])
  min_idx = which.min(metric_data)
  
  return(state_data[min_idx, "Hospital.Name" ])
}