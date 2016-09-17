## Example of how to use lexical scope in R to cache data
## Marcio Heder - 17/09/16

## Creating a matrix with set/get methods

makeCacheMatrix <- function(x = matrix()) {
  ## initializing
  i <- NULL
  
  #function to set values in the parent environment
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  
  #function to return the matrix
  get <- function() x

  #setting the inverse
  setinverse <- function(solve) i <<- solve
  
  #returning the inverse
  getinverse <- function() i
  
  #cached list
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## Using the Cache

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  i <- x$getinverse()
  
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  
  #show the inverse
  i
  
  
}

# How to test....
#mx <- matrix(c(5,7,8,1), nrow = 2, ncol = 2)
#a <- makeCacheMatrix(mx)
#cacheSolve(a)
#Call a second time to see the cache use message

#end
