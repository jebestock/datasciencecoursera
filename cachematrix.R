## Put comments here that give an overall description of what your
## functions do
## makeCacheMatrix defines an object containing sub-functions to
## setting an input matrix via setMatrix
## getting the matrix via getMatrix
## storing and fetching a matrix to/from the cache
## storing and fetchgin the inverse matrix to/from the cache
## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    m    <- NULL
    m_inv <- NULL
    
    setMatrix       <- function(y){
        x <<- y
    }
    getMatrix       <- function(){
        x
    }
    setCacheMatrix    <- function(y){
        m     <<- y
    }
    setCacheInvMatrix <- function(y){
        m_inv <<- y
    }
    getCacheMatrix    <- function(){
        m
    }
    getCacheInvMatrix <- function(){
        m_inv
    }
    
    list(setMatrix              = setMatrix,
         getMatrix              = getMatrix,
         setCacheMatrix         = setCacheMatrix,
         setCacheInvMatrix      = setCacheInvMatrix,
         getCacheMatrix         = getCacheMatrix,
         getCacheInvMatrix      = getCacheInvMatrix)
}


## Write a short comment describing this function
##
## compute the inverse only if the cache is empty or
## the input matrix is unequal to the matrix from which
## the cached inverse was computed from.
## After a new matrix is computed memorize both
## the matrix and its inverse in the cache.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    m      <- x$getMatrix()
    mc     <- x$getCacheMatrix()
    mc_inv <- x$getCacheInvMatrix()
    if( !is.null(mc_inv) && identical(m,mc)){
            message("getting cached inverse matrix")
            return(mc_inv)
    }
    new_m <- x$getMatrix()
    m_inv <- solve(new_m,...)
    x$setCacheMatrix(new_m)
    x$setCacheInvMatrix(m_inv)
    return(m_inv)
}
