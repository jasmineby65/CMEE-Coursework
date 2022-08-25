#############################################
##### Whole region correlation by model #####
#############################################

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


### Plotting ###

png(filename="../output/Multimodel/Whole_export_models.png", res = 600, height = 8000, width = 6000)

roles <- function(x) sub("[^_]*_","",x )

Whole <- ggplot(data=cbind(data, V4=paste(data$Model,data$Variable,sep="_")), 
                aes(x=reorder(V4, -Kendall), y=Kendall, col = Variable, shape = Sign)) +
  geom_point(size = 5) +
  theme_classic() +
  labs(y = "Pearon correlation coefficient",
       title = "Correlation of projected absolute change with export") +
  ylim(0,1) +
  scale_x_discrete(labels=roles) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 12),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.title = element_blank(),
        legend.direction = "horizontal",
        legend.position = c(0.85, 1.045),
        legend.background = element_blank(),
        legend.key.size = unit(20, "pt"),
        legend.text=element_text(size=15)) +
  guides(col = "none") +
  facet_wrap(Model ~ ., scales="free",  nrow = 5)
Whole

dev.off()

print("Export done")

#############
#### NPP ####
#############

data <- as.data.frame(read.csv("../csv/Whole_absolute_npp.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="NPP", ]
data <- data[data$Variable !="Export", ]
data["Sign"] = sign(data$Correlation_npp)
head(data)


data["Kendall"] = abs(data$Correlation_npp)
head(data)

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


### Plotting ###

png(filename="../output/Multimodel/Whole_npp_models.png", res = 600, height = 8000, width = 6000)

roles <- function(x) sub("[^_]*_","",x )

Whole <- ggplot(data=cbind(data, V4=paste(data$Model,data$Variable,sep="_")), 
                aes(x=reorder(V4, -Kendall), y=Kendall, col = Variable, shape = Sign)) +
  geom_point(size = 5) +
  theme_classic() +
  labs(y = "Pearson correlation coefficient",
       title = "Correlation of projected absolute change with NPP") +
  ylim(0,1) +
  scale_x_discrete(labels=roles) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 12),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.title = element_blank(),
        legend.direction = "horizontal",
        legend.position = c(0.85, 1.045),
        legend.background = element_blank(),
        legend.key.size = unit(20, "pt"),
        legend.text=element_text(size=15)) +
  guides(col = "none") +
  facet_wrap(Model ~ ., scales="free",  nrow = 5)
Whole

dev.off()

print("NPP done")


#############
#### Ice ####
#############

data <- as.data.frame(read.csv("../csv/Whole_absolute_ice.csv", header = TRUE, stringsAsFactors = F))
data <- data[data$Variable !="Sea ice fraction", ]
data <- data[data$Variable !="NPP", ]
data <- data[data$Variable !="Export", ]
data["Sign"] = sign(data$Correlation_ice)
head(data)


data["Kendall"] = abs(data$Correlation_ice)
head(data)

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


### Plotting ###

png(filename="../output/Multimodel/Whole_ice_models.png", res = 600, height = 8000, width = 6000)

roles <- function(x) sub("[^_]*_","",x )

Whole <- ggplot(data=cbind(data, V4=paste(data$Model,data$Variable,sep="_")), 
                aes(x=reorder(V4, -Kendall), y=Kendall, col = Variable, shape = Sign)) +
  geom_point(size = 5) +
  theme_classic() +
  labs(y = "Pearson correlation coefficient",
       title = "Correlation of projected absolute change with sea ice fraction") +
  ylim(0,1) +
  scale_x_discrete(labels=roles) +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        axis.text = element_text(size = 12),
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt"),
        legend.title = element_blank(),
        legend.position = c(0.92, 1.045),
        legend.background = element_blank(),
        legend.key.size = unit(20, "pt"),
        legend.text=element_text(size=15)) +
  guides(col = "none") +
  facet_wrap(Model ~ ., scales="free",  nrow = 5)
Whole

dev.off()

print("Ice done")
