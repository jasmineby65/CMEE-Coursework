M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
    Dimensions <- dim(M) #returns the length of each dimension, default is to start from row
    Tot <- 0
    for (i in 1:Dimensions[1]){
        for (j in 1:Dimensions[2]){
            Tot <- Tot + M[i,j]
        }
    }
    return (Tot)
}

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M))) # much faster than the loops above
