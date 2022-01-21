# CMEE 2021 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice in this instance
source("zy1921_HPC_2021_main.R")
# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1,4,4,5,1,6,1))
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.
init_community_max(7)
init_community_min(4)
choose_two(4)
neutral_step(c(10,5,13))
neutral_generation(c(10,5,13))
a <- neutral_time_series (community = init_community_max(7) , duration = 20)
a
length(a)
question_8()
neutral_step_speciation(c(10,5,13), 0.2)
neutral_generation_speciation(c(10,5,13), 0.2)
b <- neutral_time_series_speciation(c(10,5,13), 0.2, 20)
b
length(b)
question_12()
species_abundance(c(1,5,3,6,5,6,1,1))
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))
sum_vect(c(1,3),c(1,0,5,2))
question_16()


name <- paste("my_test_file_1.rda")
cluster_run(speciation_rate = 0.1, size=100, wall_time=2, interval_rich=1,
            interval_oct=10, burn_in_generations=200,
            output_file_name=name)
load(file = name)
process_cluster_results()
plot_cluster_results()

question_21()
question_22()
chaos_game()
plot(1, type="n", xlab="", ylab="", xlim=c(-5, 5), ylim=c(-5,5))
turtle(c(0,0), 2, pi/2)
elbow(c(0,0), 2, pi/2)
spiral(c(0,0), 2, pi/2)
draw_spiral()
draw_tree()
draw_fern()
draw_fern2()

Challenge_A()
Challenge_B()
Challenge_E()
