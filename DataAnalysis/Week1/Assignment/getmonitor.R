getmonitor <- function(id, directory, summarize = FALSE) {
        ## 'id' is a vector of length 1 indicating the monitor ID
        ## number. The user can specify 'id' as either an integer, a
        ## character, or a numeric.

        id <- as.numeric(id[1])
        id <- formatC(id, width = 3, format = "d", flag = "0") 

        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        directory = as.character( directory[1] )

        ## 'summarize' is a logical indicating whether a summary of
        ## the data should be printed to the console; the default is
        ## FALSE

        ## Your code here
        filename <- paste(directory, "/", id, ".csv",sep="")
        df <- read.csv(filename)

        if( summarize ){
          summary(df)
        }

        return(df)
}



