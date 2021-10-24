## No pre-allocation of memory for vector

NoPreallocFun <- function(x){
    a <- vector() # empty vector
    for (i in 1:x) {
        a <- c(a, i)
        print(a)
        print(object.size(a))
    }
}

print(system.time(NoPreallocFun(100000)))
# Running from source() in R terminal DOESN'T print automatically so need to add print()


## Memory pre-allocated for the vector 
PreallocFun <- function(x){
    a <- rep(NA,x) # replicate the value (NA), x is the no. of repeat
    # so rep(NA,x) will make a vector of length x with NA as each element inside 
    for (i in 1:x) {
        a[i] <- i
        print(a)
        print(object.size(a))
    }
}

print(system.time(PreallocFun(10)))

# Difference in time with 100000 iterations:
# No pre-allocation: 10.494 
# With pre-allocation: 0.011