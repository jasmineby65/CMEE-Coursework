# qplots is a simplified version of ggplot 
# only one dataset can be used in qplot

rm(list=ls())
require(ggplot2)

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

## Scatterplots ##
qplot(data=MyDF, Prey.mass, Predator.mass)
qplot(log(Prey.mass), log(Predator.mass), data=MyDF)

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      color=Type.of.feeding.interaction)

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      color=Type.of.feeding.interaction, asp=1)

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      shape=Type.of.feeding.interaction, asp=1)

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      color="red", asp=1) # the colour in ggplot2 is different to the colour in R of the same name

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      color=I("red"), asp=1) # to specify colours using the R name, need to use I()

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      size=3, asp=1) 

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      size=I(3), asp=1) # same as colour 

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      shape=3, asp=1) # this gives error because shape is a discrete variable

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      shape="3", asp=1)

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      shape=I(3), asp=1) # the same as colour

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      colour=Type.of.feeding.interaction, asp=1,
      alpha=I(0.5)) # setting transparency with alpha

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      colour=Type.of.feeding.interaction, asp=1,
      alpha=0.5) # this makes a new variable called alpha with a value of 0.5

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      asp=1, geom=c("point", "smooth")) # smooth geom add a line of best fit

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      asp=1, geom=c("point", "smooth")) + geom_smooth(method="lm") # add a straight line

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      colour=Type.of.feeding.interaction, asp=1, 
      geom=c("point", "smooth")) + geom_smooth(method="lm") 

qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      colour=Type.of.feeding.interaction, asp=1, geom=c("point", "smooth")) + 
  geom_smooth(method="lm", fullrange=T) # extends line to the full range

qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)

qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), 
      data = MyDF, geom="jitter") 
# jitters the points in each level to spread them out


## Boxplots ##
# use geom="boxplot" to make boxplot
# geom stands for GEOMetry
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")


## Histograms ##
# use geom="histogram" to make histogram
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram")

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram",
      fill=Type.of.feeding.interaction)

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram",
      fill=Type.of.feeding.interaction, binwidth=1) # set bin width

# Making density plot with geom="density"
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density",
      fill=Type.of.feeding.interaction)

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density",
      fill=Type.of.feeding.interaction, alpha=I(0.5))

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density",
      colour=Type.of.feeding.interaction)
# colour= changes the colour of lines and points, fill= fills the shape with colour


## geom arguments ##
# bar charts
qplot(Predator.lifestage, data=MyDF, geom="bar")

# line (points joined by line) graph
qplot(log(Prey.mass), log(Predator.mass), data=MyDF,
      geom = "line",
      colour=Type.of.feeding.interaction)

# violin plot
qplot(Predator.lifestage, log(Prey.mass), data=MyDF, 
      geom="violin")


## Multi-faceted plots ##
qplot(log(Prey.mass/Predator.mass), data=MyDF, geom="density",
      facets= Type.of.feeding.interaction ~.)
# Seperate facets by type of feeding interactions 
# ~. specify to have facet by rows

qplot(log(Prey.mass/Predator.mass), data=MyDF, geom="density",
facets= .~ Type.of.feeding.interaction)
# .~ specify to have facet by column 


## Logarithmic axes ##
qplot(Prey.mass, Predator.mass, data=MyDF, log="xy")
# log= will apply log to the variables, "x" will only apply to x axis


## Annotating plots ##
qplot(Prey.mass, Predator.mass, data=MyDF, log="xy",
      main="Relation bewteen predator and prey mass",
      xlab="log(Prey mass) (g)",
      ylab="log(Predator mass) (g)")

qplot(Prey.mass, Predator.mass, data=MyDF, log="xy",
      main="Relation bewteen predator and prey mass",
      xlab="log(Prey mass) (g)",
      ylab="log(Predator mass) (g)") + theme_bw()
# theme_bw() makes the plot suitable for black and white printing


## Exporting plots ##
pdf("../results/MyFirst-ggplot2-Figure.pdf")
# print() will help keep all the command together
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
            main = "Relation between predator and prey mass", 
            xlab = "log(Prey mass) (g)", 
            ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()



