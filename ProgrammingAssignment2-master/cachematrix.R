## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
Inv<-NULL                   ##setting inverse to be NULL
setmatrix<-function(z){
  x<<-z                     ##caching the matrix
  Inv<<-NULL
}
getmatrix<-function() x    ##getting cached matrix
setInverse<-function(g) Inv<<-g     ##Taking inverse and caching it
getInverse<-function() Inv
list(setmatrix = setmatrix,
     getmatrix = getmatrix,
     setInverse = setInverse,
     getInverse = getInverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  Inv<-x$getInverse() ##calling getInverse() function 
  if(!is.null(Inv)){
    message("Getting cached data")
    return(Inv)
  }
  m<-x$getmatrix()    ##calling getmatrix() function to get the matrix
  Inv<-solve(m,...)
  x$setInverse(Inv)   ##calling setinverse function to cache the inverse
  Inv
}
