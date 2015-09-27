# cachematrix.R

# There are two functions makeCacheMatrix and cacheSolve
# makeCacheMatrix creates a special matrix, that can store the inverse of itself
# cacheSolve calculates the inverse of matrix, created with makeCacheMatrix

# makeCacheMatrix creates a special matrix, which is a list containing functions to:
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of the inverse of the matrix
# 4. get the value of the inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
        # set initial value for inverse of the matrix as NULL
        s <- NULL

        # set function resets the value of the matrix
        set <- function(y) {
                # assign new data to matrix
                x <<- y

                # reset stored value of inverse of the matrix
                # so we can calculate the inverse of the matrix for new data
                s <<- NULL
        }

        # get function returns value of the matrix
        get <- function() x

        # setSolve function sets the matrix inverse value
        setSolve <- function(solve) s <<- solve

        # getSolve function returns the matrix inverse value
        getSolve <- function() s

        # return cache matrix
        list(set = set, get = get,
             setSolve = setSolve,
             getSolve = getSolve)
}

# cacheSolve calculates the inverse of the special matrix
# created with the makeCacheMatrix function
cacheSolve <- function(x, ...) {
        # get matrix inverse value from the cache
        s <- x$getSolve()

        # return matrix inverse if it is not null
        if(!is.null(s)) {
                message("getting cached data")
                return(s)
        }

        # otherwise, if there is no inverse in the cache
        # get matrix data
        data <- x$get()

        # calculate the inverse of the matrix
        s <- solve(data, ...)

        # cache calculated inverse of the matrix
        x$setSolve(s)

        # return inverse matrix value
        s
}