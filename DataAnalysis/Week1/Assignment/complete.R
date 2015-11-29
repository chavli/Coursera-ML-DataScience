complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        m = matrix(0, nrow=0, ncol=2)

        for( i in id ){
          file_id <- formatC(i, width = 3, format = "d", flag = "0")
          directory <- as.character(directory[1])
          
          filename <- paste(directory, "/", file_id, ".csv",sep="")
          df <- read.csv(filename)
          
          good <- sum( complete.cases( df ))
        
          m <- rbind(m, c(i, good))
          
        }
        
        df <- data.frame(m)
        names(df) <- c("id", "nobs")
        return(df)
}
