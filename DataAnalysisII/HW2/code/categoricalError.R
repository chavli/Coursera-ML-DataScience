categoricalError = function(truth, predictions){
  error = sum( truth != predictions ) / length(predictions)
  return (error)
}