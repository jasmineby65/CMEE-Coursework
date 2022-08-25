###################################
##### Correlation with export #####
###################################

rm(list = ls())

require(lsmeans)
require(segmented)
require(interactions)
require(jtools)
require(ggplot2)
library(tidyverse)
library(rstatix)
library(lme4)
require(gridExtra)
require(grid)
require(gridtext)
require(smatr)
require(png)

#setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()


################
#### Export ####
################

data <- as.data.frame(read.csv("../csv/Whole_absolute_export.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
data["Sign"] = sign(data$Correlation)
head(data)


data["Kendall"] = abs(data$Correlation)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_correlation_export.csv")

data <- data %>% 
  group_by(Variable) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)


### All model ###

png(filename="../output/Multimodel/Whole_export.png", res=600, width=7000, height=3000)

Whole <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  labs(y = "Pearson correlation coefficient",
       title = "(A) Export") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.title = element_blank(),
        legend.direction = "horizontal",
        legend.position = c(0.85, 1.045),
        legend.background = element_blank(),
        legend.key.size = unit(25, "pt"),
        legend.text=element_text(size=20))
Whole

dev.off()


#############
#### NPP ####
#############

data <- as.data.frame(read.csv("../csv/Whole_absolute_npp.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
data <- data[data$Variable !="NPP", ]
data["Sign"] = sign(data$Correlation_npp)
head(data)


data["Kendall"] = abs(data$Correlation_npp)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_correlation_npp.csv")

data <- data %>% 
  group_by(Variable) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)


### All model ###

png(filename="../output/Multimodel/Whole_npp.png", res=600, width=7000, height=3000)

Whole1 <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  labs(y = "Pearson correlation coefficient",
       title = "(B) NPP") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.position = "none")
Whole1

dev.off()


#############
#### Ice ####
#############
data <- as.data.frame(read.csv("../csv/Whole_absolute_ice.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Sea ice fraction", ]
data <- data[data$Variable !="Export", ]
data <- data[data$Variable !="NPP", ]
data["Sign"] = sign(data$Correlation_ice)
head(data)


data["Kendall"] = abs(data$Correlation_ice)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_correlation_ice.csv")

data <- data %>% 
  group_by(Variable) %>%
  mutate(Mean_cor = sum(Sign))
head(data)
data["Sign2"] = sign(data$Mean_cor)
data = as.data.frame(data)

data$Sign[data$Sign2 == 1] = "Positive"
head(data)
data$Sign[data$Sign2 == -1] = "Negative"
head(data)


### All model ###

png(filename="../output/Multimodel/Whole_ice.png", res=600, width=7000, height=3000)

Whole2 <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, fill = Sign)) +
  geom_boxplot(lwd=0.5) +
  theme_classic() +
  labs(y = "Pearson correlation coefficient",
       title = "(C) Sea ice fraction") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.position = "none")
Whole2

dev.off()



###### Final plot #####
png(filename="../output/Multimodel/Final_whole_correlation.png", res=600, width=7000, height=10000)
grid.arrange(Whole, Whole1, Whole2, ncol = 1)
dev.off()

