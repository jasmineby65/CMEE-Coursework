# CMEE 2021 HPC excercises R code HPC run code pro forma

rm(list=ls()) # good practice 
while (!is.null(dev.list()))  dev.off()
source("zy1921_HPC_2021_main.R")

#################################################
              # Testing code # 
#################################################

# for(i in 1:100){
# iter <- i
# 
# set.seed(iter)
# 
# if(iter <= 25){popu_size = 500} else if
# (iter <= 50){popu_size = 1000} else if
# (iter <= 75){popu_size = 2500} else if
# (iter <= 100){popu_size = 5000}
# 
# speciation = 0.0027916
# 
# file_name = paste0("Test_result", iter, ".rda")
# 
# cluster_run(speciation_rate = speciation, size = popu_size, wall_time = 5, interval_rich = 1, interval_oct = popu_size/10, burn_in_generations = 8*popu_size, output_file_name = file_name)
# }


#################################################
              # Final code # 
#################################################

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

set.seed(iter)

if(iter <= 25){popu_size = 500} else if
(iter <= 50){popu_size = 1000} else if
(iter <= 75){popu_size = 2500} else if
(iter <= 100){popu_size = 5000}

speciation = 0.0027916

file_name = paste0("Test_result", iter, ".rda",  sep = "")

cluster_run(speciation_rate = speciation, size = popu_size, wall_time = 690, interval_rich = 1, interval_oct = popu_size/10, burn_in_generations = 8*popu_size, output_file_name = file_name)


