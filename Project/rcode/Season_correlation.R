###########################
#### Season Correlation ####
###########################

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

###############
### Export ####
###############

data <- as.data.frame(read.csv("../csv/Season_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="Export", ]
head(data)

data["Kendall"] = abs(data$Kendall)
head(data)


## Correlation ##
result <- matrix(nrow = length(unique(data$Variable)), ncol = 2)
result

for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lmer(data = subset, Kendall ~ Season + (1|Model))
  model2 <- lmer(data = subset, Kendall ~ 1 + (1|Model))
  
  output <- anova(model, model2)
  result[i,2] <- format(output$`Pr(>Chisq)`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable","p-value")
write_csv(result, "../csv/Season_Kendall_lmer_export.csv")
result

# data %>% 
#   group_by(Variable, Season) %>%
#   get_summary_stats(Kendall, type = "common")
# 
# res.kruskal_correlation <- data %>% 
#   group_by(Variable) %>%
#   kruskal_test(Kendall ~ Season)
# 
# res.kruskal_correlation
# 
# write_csv(res.kruskal_correlation, "../csv/Season_correlation_export.csv")


### Plotting ###

data[data == "Diatom"] <- "Diatom"
data[data == "Export"] <- "Export"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD*"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP*"
data[data == "PAR"] <- "PAR***"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST"


png(filename="../output/Multimodel/Season_correlation_export.png", res=600, width=10000, height=4000)

Season <- ggplot(data=data, aes(x = Season, y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "#FFCC33") +
  theme_classic() +
  ggtitle("(A) Correlation of percentage change with export by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
Season

dev.off()

# Not box #
exp <- ggplot(data=data, aes(x = Season, y=Kendall, col = Model)) +
  geom_point(size = 10)+
  theme_classic() +
  ggtitle("(A) Correlation of percentage change with export by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
exp



###############
##### Ice #####
###############

data <- as.data.frame(read.csv("../csv/Season_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="Sea ice fraction", ]
head(data)

data["Kendall"] = abs(data$Correlation_ice_k)
head(data)

## Correlation ##

result <- matrix(nrow = length(unique(data$Variable)), ncol = 2)
result

for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lmer(data = subset, Kendall ~ Season + (1|Model))
  model2 <- lmer(data = subset, Kendall ~ 1 + (1|Model))
  
  output <- anova(model, model2)
  result[i,2] <- format(output$`Pr(>Chisq)`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable","p-value")
write_csv(result, "../csv/Season_Kendall_lmer_ice.csv")
result


# data %>% 
#   group_by(Variable, Season) %>%
#   get_summary_stats(Kendall, type = "common")
# 
# res.kruskal_correlation <- data %>% 
#   group_by(Variable) %>%
#   kruskal_test(Kendall ~ Season)
# 
# res.kruskal_correlation
# 
# write_csv(res.kruskal_correlation, "../csv/Season_correlation_ice.csv")

### Plotting ###
data[data == "Diatom"] <- "Diatom*"
data[data == "Export"] <- "Export"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate"
data[data == "NPP"] <- "NPP"
data[data == "PAR"] <- "PAR**"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST***"


png(filename="../output/Multimodel/Season_correlation_ice.png", res=600, width=10000, height=4000)

Season2 <- ggplot(data=data, aes(x = Season, y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "darkslategray3") +
  theme_classic() +
  ggtitle("(C) Correlation of percentage change with sea ice fraction by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
Season2

dev.off()

# Not box #
ice <- ggplot(data=data, aes(x = Season, y=Kendall, col = Model)) +
  geom_point(size = 10)+
  theme_classic() +
  ggtitle("(C) Correlation of percentage change with sea ice fraction by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
ice



#############
#### NPP ####
#############

data <- as.data.frame(read.csv("../csv/Season_final.csv", header = TRUE, stringsAsFactors = F))
data <- data[order(data$Variable),]
data <- data[data$Variable !="NPP", ]
head(data)

data["Kendall"] = abs(data$Correlation_npp_k)
head(data)

## Correlation ##

result <- matrix(nrow = length(unique(data$Variable)), ncol = 2)
result

for(i in 1:length(unique(data$Variable))){
  print(i)
  
  var <- unique(data$Variable)[i]
  print(var)
  
  result[i,1] <- var
  
  subset <- data[data$Variable == var,]
  
  model <- lmer(data = subset, Kendall ~ Season + (1|Model))
  model2 <- lmer(data = subset, Kendall ~ 1 + (1|Model))
  
  output <- anova(model, model2)
  result[i,2] <- format(output$`Pr(>Chisq)`[2], digits = 4, scientific=FALSE)
  
}

result
result <- as.data.frame(result)
colnames(result) <- c("Variable","p-value")
write_csv(result, "../csv/Season_Kendall_lmer_npp.csv")
result

# data %>% 
#   group_by(Variable, Season) %>%
#   get_summary_stats(Kendall, type = "common")
# 
# res.kruskal_correlation <- data %>% 
#   group_by(Variable) %>%
#   kruskal_test(Kendall ~ Season)
# 
# res.kruskal_correlation
# 
# write_csv(res.kruskal_correlation, "../csv/Season_correlation_npp.csv")

### Plotting ###
data[data == "Diatom"] <- "Diatom"
data[data == "Export"] <- "Export*"
data[data == "Iron"] <- "Iron"
data[data == "MLD"] <- "MLD"
data[data == "Nitrate"] <- "Nitrate**"
data[data == "NPP"] <- "NPP"
data[data == "PAR"] <- "PAR"
data[data == "Sea ice fraction"] <- "Sea ice fraction"
data[data == "SST"] <- "SST"


png(filename="../output/Multimodel/Season_correlation_npp.png", res=600, width=10000, height=4000)

Season3 <- ggplot(data=data, aes(x = Season, y=Kendall)) +
  geom_boxplot(lwd=0.5, fill = "olivedrab3") +
  theme_classic() +
  ggtitle("(B) Correlation of percentage change with NPP by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
Season3

dev.off()

# Not box #
npp <- ggplot(data=data, aes(x = Season, y=Kendall, col = Model)) +
  geom_point(size = 10)+
  theme_classic() +
  ggtitle("(B) Correlation of percentage change with NPP by season") +
  labs(y = "Kendall rank correlation coefficient")  +
  theme(plot.title = element_text(size = 18, face = "bold", margin=margin(0,0,15,0)),
        plot.title.position = "plot",
        strip.text.x = element_text(size = 13, hjust = 0.5, face = "bold", color = "#333333"), 
        axis.title.y = element_text(size = 18, margin = margin(r = 10)),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 15),
        panel.border = element_rect(size = 0.5, fill = NA),
        axis.line = element_blank(),
        strip.background = element_rect(colour="white", fill="white"),
        plot.margin = unit(c(5.5, 40, 40, 5.5), "pt")) +
  facet_wrap(. ~ Variable, scales="free", nrow = 1)
npp


###### Final plot #####
png(filename="../output/Multimodel/Final_Season_correlatiom.png", res=600, width=10000, height=12000)
grid.arrange(Season, Season3, Season2, ncol = 1)
dev.off()

png(filename="../output/Multimodel/Fial_Season_correlatiom_point.png", res=600, width=10000, height=12000)
grid.arrange(exp, npp, ice, ncol = 1)
dev.off()