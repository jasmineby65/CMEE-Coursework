# next - sktp to the next iteration of a loop

for (i in 1:10){
    if ((i %% 2) == 0) # checking if i is odd
    next # pass to the next ietration of loop
    print(i)
}