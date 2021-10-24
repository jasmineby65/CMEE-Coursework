Ricker <- function(N0=1, r=1, K=10, generations=50) {
    # Runs a simulation of the Ricker model
    # Returns a vector of length generatiosn

    N <- rep(NA, generations) # making pre-allocated vector of NA for N

    N[1] <- N0 
    for (t in 2:generations){
        N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K))) # exp is e 
    }
    return(N)
}

plot(Ricker(generations=10), type="l")