############################
#### Pearson vs Kendall ####
############################

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

##### Whole ######

data <- as.data.frame(read.csv("../csv/Correlation.csv", header = TRUE, stringsAsFactors = F))
head(data)
unique(data$Type)

# Export #
export <- data[data$Type == "Correlation" | data$Type == "Kendall",]
export <- na.omit(export)
export

correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable), data = export)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable), data = export)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)

# Sea ice #
ice <- data[data$Type == "Correlation_ice" | data$Type == "Correlation_ice_k",]
ice <- na.omit(ice)
ice

correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable), data = ice)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable), data = ice)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)

# NPP #
correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable), data = data)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable), data = data)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)



##### Zone ######

data <- as.data.frame(read.csv("../csv/Correlation_zone.csv", header = TRUE, stringsAsFactors = F))
head(data)

correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable) +(1|Zone), data = data)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable) +(1|Zone), data = data)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)


##### Season #####

data <- as.data.frame(read.csv("../csv/Correlation_season.csv", header = TRUE, stringsAsFactors = F))
head(data)

correlation_test1 <- lmer(Correlation ~ Type + (1|Model/Variable) +(1|Season), data = data)
summary(correlation_test1)

correlation_test2 <- lmer(Correlation ~ 1 + (1|Model/Variable) +(1|Season), data = data)
summary(correlation_test2)

anova(correlation_test1, correlation_test2)