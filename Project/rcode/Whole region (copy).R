##################################
#### Whole region correlation ####
##################################

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

setwd("~/../../../media/jasmine/Album/Project/rcode")
getwd()


###### Export #######

data <- as.data.frame(read.csv("../csv/Whole_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Export", ]
head(data)


data["Kendall"] = abs(data$Kendall)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_region_export.csv")


### Plotting ###

png(filename="../output/Multimodel/Whole_export.png", res=600, width=10000, height=4100)


Whole <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "#FFCC33") +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(A) Correlation of percentage change by 2100 with export") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
Whole

dev.off()


## Not box ##
exp <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, col = Model)) +
  geom_point(size = 10) +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(A) Correlation of percentage change by 2100 with export") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
exp


##### Ice #####

data <- as.data.frame(read.csv("../csv/Whole_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Sea ice fraction", ]
head(data)


data["Kendall"] = abs(data$Correlation_ice_k)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_region_ice.csv")


### Plotting ###

png(filename="../output/Multimodel/Whole_ice.png", res=600, width=10000, height=4100)

Whole2 <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "darkslategray3") +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(C) Correlation of percentage change by 2100 with sea ice fraction") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
Whole2

dev.off()

#### Not box ####
Ice <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, col = Model)) +
  geom_point(size = 10) +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(C) Correlation of percentage change by 2100 with sea ice fraction") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
Ice

##### NPP #####

data <- as.data.frame(read.csv("../csv/Whole_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="NPP", ]
head(data)


data["Kendall"] = abs(data$Correlation_npp_k)
head(data)

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")

data %>% 
  group_by(Variable) %>%
  get_summary_stats(Kendall, type = "common")%>% 
  write_csv("../output/Multimodel/Whole_region_NPP.csv")


### Plotting ###

png(filename="../output/Multimodel/Whole_npp.png", res=600, width=10000, height=4100)

Whole3 <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "olivedrab3") +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(B) Correlation of percentage change by 2100 with NPP") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
Whole3

dev.off()

#### Not box ####
npp <- ggplot(data=data, aes(x=reorder(Variable, -Kendall), y=Kendall, col = Model)) +
  geom_point(size = 10) +
  theme_classic() +
  labs(y = "Kendall rank correlation coefficient",
       title = "(B) Correlation of percentage change by 2100 with NPP") +
  ylim(0,1) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 15),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"))
npp


###### Final plot #####
png(filename="../output/Multimodel/Fial_whole_correlatiom.png", res=600, width=7000, height=12000)
grid.arrange(Whole, Whole3, Whole2, ncol = 1)
dev.off()

png(filename="../output/Multimodel/Fial_whole_correlatiom_point.png", res=600, width=7500, height=12000)
grid.arrange(exp, npp, Ice, ncol = 1)
dev.off()

