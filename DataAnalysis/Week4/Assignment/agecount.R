# Cha Li -- 2013 Oct 19

# The goal of this part is to write a function called agecount that returns the number of
# homicide victims of a given age.

agecount <- function(age = NULL) {
  if( is.numeric(age) && age > 0){
    data = readLines("homicides.txt")
    
    

    pattern = paste(" ", age, " years old</dd>", sep="")
    n = length(grep(pattern, data))
    return(n)

  }
  else{
    stop("invalid age value")
  }
## Check that "age" is non-NULL; else throw error
## Read "homicides.txt" data file
## Extract ages of victims; ignore records where no age is
## given
## Return integer containing count of homicides for that age
}
