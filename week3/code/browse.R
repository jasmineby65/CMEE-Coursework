Exponential <- function(N0=1, r=1, K=10, generations=10) {
    # Runs a simulation of the Ricker model
    # Returns a vector of length generatiosn

    N <- rep(NA, generations) # making pre-allocated vector of NA for N

    N[1] <- N0 
    for (t in 2:generations){
        N[t] <- N[t-1] * exp(r) # exp is e 
        browser() 
        # this should be run in R terminal rather than from bash if you want to go through each line individually
    }
    return(N)
}

plot(Exponential(generations=10), type="l", main="Exponential growth")