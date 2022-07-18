library(orsifronts)
library(rgdal)

getwd()
setwd("~/Documents/CMEECourseWork/Project/")

writeOGR(obj = orsifronts, dsn = "Shapes", layer = "SO_fronts", driver="ESRI Shapefile")
# driver specifies the format of output shape file
# dsn = destination directory
# layer = output file name