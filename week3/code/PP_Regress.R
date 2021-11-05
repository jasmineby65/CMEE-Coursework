rm(list=ls())
require(ggplot2)
require(tidyverse)
require(plyr)

# Loading data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
#MyDF$Prey.mass[which(MyDF$Prey.mass.unit == "mg")] <- MyDF$Prey.mass[which(MyDF$Prey.mass.unit=="mg")]/1000
head(MyDF)
dplyr::glimpse(MyDF)


### Making figure ###
dev.off()
p <- ggplot(MyDF, 
            aes(x=Prey.mass, 
                y=Predator.mass,
                colour=Predator.lifestage),
            geom="smooth",
              method="lm") + theme_bw() + theme(aspect.ratio = 0.5)

p <- p + geom_point(shape=3) 

p <- p + facet_wrap(Type.of.feeding.interaction~., 
                    ncol=1, strip.position = "right")

p <- p + geom_smooth(method="lm", se=T, fullrange =T)

p <- p + scale_x_continuous(trans="log10",
                            name="Prey Mass in grams") +
  scale_y_continuous(trans="log10",
                     name="Predator mass in grams")

#p <- p + theme(plot.margin = unit(c(1,3,1,3),"cm")) # c(top, right, bottom, left)

p <- p + guides(colour=guide_legend(nrow=1)) + 
  theme(legend.position = "bottom", 
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(face="bold"),
        legend.justification = "centre")
p

pdf("../results/PP_Regress.pdf", 7.5, 10)
p
dev.off()


### Regression results ###
# Results of linear regression analysis on subsets of the feeding type x predator life stage 
# i.e. make subset of data for feeding x predator life stage and calculate the regression of prey-predator mass for each subset
# Headers: Slope (regression slope), Intercept (regression intercept), r_squared, F-statistic, p-value

# Making headers of each combinations of lifestage and feeding type  
levels(MyDF$Predator.lifestage)
levels(MyDF$Type.of.feeding.interaction)
MyDF$Grouping <- factor(paste0(MyDF$Predator.lifestage, "_", MyDF$Type.of.feeding.interaction))
head(MyDF)
# paste() joins vectors and strings to make strings, paste0() concatenate vectors without spaces inbewteen
# Exporting csv
levels(MyDF$Grouping)

# Making result matrix 
results <- matrix(NA, 5, 18)
results
rownames(results) <- c("slope", "intercept", "r-squared", "F-statistic", "p-value")
colnames(results) <- levels(MyDF$Grouping)
results

ddply(.data=MyDF, .variables = Predator.lifestage, )

write.csv(results, "../results/PP_Regree_Results.csv")
