corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        ids = 1:332
        
        corr_vec = vector(mode="numeric")

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        for( id in ids ){
          file_id <- formatC(id, width = 3, format="d", flag="0")
          filename <- paste(directory, "/", file_id, ".csv",sep="")
          
          df <- read.csv(filename)
          
          good = complete.cases(df)
          df = df[good, ]
          
          if(nrow(df) >= threshold){
            corr_vec = append(corr_vec, cor( df$sulfate, df$nitrate ))
          }
        }
        
        ## Return a numeric vector of correlations
        return(corr_vec)
}
