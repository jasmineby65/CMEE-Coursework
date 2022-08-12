rm(list = ls())

require(lsmeans)
require(segmented)
require(interactions)
require(jtools)
require(ggplot2)
library(tidyverse)
#library(ggpubr)
library(rstatix)

setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()


data <- as.data.frame(read.csv("../csv/Correlation.csv", header = TRUE, stringsAsFactors = F))
head(data)
duplicated(data)
data <- data[!duplicated(data),]
head(data)

correlation_test <- lm(data$value ~ data$variable)
summary(correlation_test)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(difference, type = "common") %>%
  write_csv("../output/Multimodel/Whole_variable_correlation_zonal.csv")

plot <- as.data.frame(read.csv("../output/Multimodel/Whole_variable_correlation_zonal.csv", header = TRUE, stringsAsFactors = F))
head(plot)

ggplot() + 
  geom_point(data = data, aes(x = Variable, y = difference)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-se, ymax=mean+se), width=.1, color = "red")

ggplot(plot, aes(x=Variable, y=, colour=supp)) + 
  geom_errorbar(aes(ymin=len-se, ymax=len+se), width=.1) +
  geom_line() +
  geom_point()

res.kruskal <- data %>% kruskal_test(difference ~ Variable)
res.kruskal

pwc <- data %>% 
  dunn_test(difference ~ Variable, p.adjust.method = "bonferroni") 
print(pwc, n=36)

pwc <- data %>% 
  dunn_test(Abs ~ Variable, p.adjust.method = "bonferroni") 
print(pwc, n=36)



png(filename="../output/Multimodel/Whole_variable_correlation_zonal_ci.png")
ggplot() + 
  geom_point(data = data, aes(x = Variable, y = difference)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-ci, ymax=mean+ci), width=.1, color = "red")
dev.off()

png(filename="../output/Multimodel/Whole_variable_correlation_zonal_se.png")
ggplot() + 
  geom_point(data = data, aes(x = Variable, y = difference)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-se, ymax=mean+se), width=.1, color = "red")
dev.off()
