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


data <- as.data.frame(read.csv("../csv/Whole.csv", header = TRUE, stringsAsFactors = F))
head(data)
data[data == "dfe"] <- "dfeos"
data["Abs"] = abs(data$Correlation)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Correlation, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Abs, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_variable_correlation.csv")
plot <- as.data.frame(read.csv("../output/Multimodel/Whole_variable_correlation.csv", header = TRUE, stringsAsFactors = F))
head(plot)

ggplot() + 
  geom_point(data = data, aes(x = Variable, y = Abs, col = Export)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-ci, ymax=mean+se), width=.1, color = "red")

ggplot(plot, aes(x=Variable, y=, colour=supp)) + 
  geom_errorbar(aes(ymin=len-se, ymax=len+se), width=.1) +
  geom_line() +
  geom_point()

res.kruskal <- data %>% kruskal_test(Correlation ~ Variable)
res.kruskal

pwc <- data %>% 
  dunn_test(Correlation ~ Variable, p.adjust.method = "bonferroni") 
print(pwc, n=36)

pwc <- data %>% 
  dunn_test(Abs ~ Variable, p.adjust.method = "bonferroni") 
print(pwc, n=36)

png(filename="../output/Multimodel/Whole_variable_correlation.png")

ggplot(data, aes(x = Variable, y = abs(Correlation), col = Export)) + 
  geom_point() + geom_boxplot()

dev.off()


png(filename="../output/Multimodel/Whole_variable_correlation_dots.png")

ggplot(data, aes(x = Variable, y = abs(Correlation), col = Export)) + 
  geom_point() 

dev.off()

png(filename="../output/Multimodel/Whole_variable_correlation_ci.png")
ggplot() + 
  geom_point(data = data, aes(x = Variable, y = Abs, col = Export)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-ci, ymax=mean+ci), width=.1, color = "red")
dev.off()

png(filename="../output/Multimodel/Whole_variable_correlation_se.png")
ggplot() + 
  geom_point(data = data, aes(x = Variable, y = Abs, col = Export)) +
  geom_point(data = plot, aes(x = Variable, y = mean), color = "red") +
  geom_errorbar(data = plot, aes(x = Variable, y = mean, ymin=mean-se, ymax=mean+se), width=.1, color = "red")
dev.off()
