## Breaking out of loops (break)

i <- 0 #initialise i
while (i<Inf){
    if (i == 10) {
        break}
    else {
        cat("i equals", i, "\n") # with print() the "\n" will be recognsed as strings rather than as arguments
        i <- i + 1
    }
    }