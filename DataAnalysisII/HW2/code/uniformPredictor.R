
# a predictor which uniformly selects categorical results at random. this
# can be used as a baseline for building more robust and accurate models]
#   n - the number of predictions to make
#   cats - the categories to select from for predictions
uniformPredictor = function(n, cats){
  i = round(runif(n, min=1, max=length(cats)))
  predictions = cats[i]
  return(predictions)
}