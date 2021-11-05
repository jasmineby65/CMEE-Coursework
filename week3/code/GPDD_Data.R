require(maps)

# Loading the GPDD data
# Contains info on the location (lat & long) 
# where population time series are available for species 
load("../data/GPDDFiltered.RData")
str(gpdd)
head(gpdd)

# Draws the outlines of a world map
dev.off()
map(database = "world", fill=T, col="grey")

# Adding the coordinates of locations on the map
points(x=gpdd$long, y=gpdd$lat, col="red", pch=19)

# Data points are concentrated in the Northern Hemisphere, especially in the US and Europe. 
# Analysis based on this dataset will be biased in populations in specific regions of the Northern Hemisphere.
