##
## 2014-08-22
## Two matrix functions that demonstrate the value caching functionality of R. The first
## function creates "cachedMatrix" and the second function returns the inverse of the 
## cached matrix.
##

## Creates a cached matrix given a standard R matrix. the cached matrix keeps track
## of its inverse value and avoids unnecessary re-calculations
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL # the value of the inverse
    
    setdata <- function(y){
        x <<- y
        inv <<- NULL
    }
    getdata <- function(){ x }
    
    setinverse <- function(i) { 
        inv <<- i
    }
    getinverse <- function() { inv }
    
    # a list containing set/get functions is returned
    list(setdata = setdata, getdata = getdata,
        setinverse = setinverse,
        getinverse = getinverse)
}


## Returns the inverse of the given cached matrix. If the cached matrix already
## has an inverse value calculated then that is simply returned. Otherwise it 
## is calcuated and cached.
cacheSolve <- function(x, ...) {
    # check if the the inverse has already been calculated and return it
    val <- x$getinverse()
    
    # return the caches value if it's not null and the underlying matrix 
    # hasn't been changed
    if(!is.null(val)){
        message("returning cached inverse value")
        return(val)
    }
  
    # get the matrix data and calculate the inverse
    data <- x$getdata()
    inv_mat <- solve(data, ...)
    x$setinverse(inv_mat)
    return(inv_mat)
}
    
