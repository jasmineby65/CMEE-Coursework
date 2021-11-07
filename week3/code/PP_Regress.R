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


## Making headers of each combinations of lifestage and feeding type##

#levels(MyDF$Predator.lifestage)
#levels(MyDF$Type.of.feeding.interaction)
#MyDF$Grouping <- factor(paste0(MyDF$Predator.lifestage, "_", MyDF$Type.of.feeding.interaction))
#head(MyDF)
# paste() joins vectors and strings to make strings, paste0() concatenate vectors without spaces inbewteen
# Exporting csv
#levels(MyDF$Grouping)

## This wasn't meeded because plyr has function that makes data frame from calculation result 


## Applying lm to all possible subsets ##
linear <- dlply(MyDF, .(Predator.lifestage, Type.of.feeding.interaction), 
                function(x) lm(Predator.mass ~ Prey.mass, data=x))
# dlply applies a function to subsets of data (specified with .()) and combines the results in a list 
class(linear)
linear
#str(linear)
# Makes a list of 18 lists that contains results of lm of the different subsets 

# ddply does the same thing but combines the results in a data frame instead
# ddply will return an error in this case because lm result cannot be stored as data frame 

 
## Making a dataframe from the output of lm ##
summary(linear$adult.piscivorous)
str(summary(linear$adult.piscivorous))

# ldply() applies a function to each elements in a list and combines the results in a dataframe 
output <- ldply(linear, function(x){
  intercept <- summary(x)$coefficient[1]
  slope <- summary(x)$coefficient[2]
  r <- summary(x)$r.squared
  p <- summary(x)$coefficient[8]
  data.frame("Intercept"=intercept, "Slope"=slope, "r_squared"=r, "p-value"=p)
})
output

output <- ldply(linear, function(x){
  intercept <- summary(x)$coefficient[1]
  slope <- summary(x)$coefficient[2]
  r <- summary(x)$r.squared
  p <- summary(x)$coefficient[8]
  data.frame("Intercept"=intercept, "Slope"=slope, "r_squared"=r, "p-value"=p)
})
output

# f-statistics has two variables (a character and an integer) so cannot be assigned to one row 
a <- summary(linear$adult.piscivorous)$fstatistic[1]
a
class(a)

# need to assign it to a dataframe seperately 
fstat <- ldply(linear, function(x){ 
  f <- summary(x)$fstatistic[1]
  data.frame("F-statistic"=f) 
} )
fstat

# Combining the two dataframe
# merge() allows two dataframe to be combined by common columns or row names specified with by=c()
# all=T will include data point that are NA (otherwise it will say the dataframes have different length)
final_out <- merge(output, fstat, by=c("Predator.lifestage", "Type.of.feeding.interaction"), all=T)
final_out

# Export as csv
write.csv(final_out, "../results/PP_Regress_Results.csv")

