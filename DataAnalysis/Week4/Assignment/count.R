# Cha Li -- 2013 Oct 19

# The goal of this problem is to count the number of different types of homicides that are
# in this dataset.



count <- function(cause = NULL) {
  homicides <- readLines("homicides.txt")
  
  causes = c("asphyxiation", "blunt force", "other", "shooting", "stabbing", "unknown")
  if(cause == "asphyxiation"){ pattern = "Cause: [Aa]sphyxiation" }
  else if(cause == "blunt force"){ pattern = "Cause: [Bb]lunt [Ff]orce" }
  else if(cause == "other"){ pattern = "Cause: [Oo]ther" }
  else if(cause == "shooting"){ pattern = "Cause: [Ss]hooting" }
  else if(cause == "stabbing"){ pattern = "Cause: [Ss]tabbing" }
  else if(cause == "unknown"){ pattern = "Cause: [Uu]nknown" }
  else{
    stop("unknown cause given")
  }
  
  n = length( grep(pattern, homicides) )
  return(n)


## Check that "cause" is non-NULL; else throw error
## Check that specific "cause" is allowed; else throw error
## Read "homicides.txt" data file
## Extract causes of death
## Return integer containing count of homicides for that cause
}
