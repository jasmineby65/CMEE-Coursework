rm(list=ls())

### Loading required packages ###
library(raster) # Core raster GIS data package
library(sf) # Core vector GIS data package
library(sp) # Another core vector GIS package
library(rgeos) # Extends vector data functionality
library(rgdal) # Interface to the Geospatial Data Abstraction Library
library(lwgeom) # Extends vector data functionality



### Population density map for the British Isles ###

## Vector data##

# Population data # 
pop_dens <- data.frame(n_km2 = c(260, 67, 151, 4500, 133),
                       country = c("England", "Scotland", "Wales", "London", "Northern Ireland"))
print(pop_dens)

# Making vectors from coordinates # 
# Creating polygon coordinates for each country  
# Making a matrix of pair of coordinates forming the edge of the polygons
# The first and last coordinates have to be the same to close the polygon shape 
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

# Converting the coordinates to feature geometries (simple coordinate sets with no projection info)
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# Converting all geometries together into a simple feature column (sfc) and plot it 
uk_eire <- st_sfc(wales, england, scotland, ireland, crs=4326) 
# CRS (coordinate reference system) consists of a ellipsoid or geometric model of the shape of Earth and a datum,
# which identifies the origin and orientation of the coordinate axes on the ellipsoid
# as well as the units of measurements 
plot(uk_eire)
# sf automatically scale the aspect ratio of plots based on their latitude, which makes them look less squashed
# This could be suppressed with asp=1
plot(uk_eire, asp=1)


# Creating vector points from datafame #
# Making the dataframe
uk_eire_capitals <- data.frame(long= c(-0.1, -3.2, -3.2, -6.0, -6.25),
                               lat=c(51.5, 51.5, 55.8, 54.6, 53.30),
                               name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin'))

# Convert the dataframe to sf object, specifying the field that contains the coordinates 
# sf object is a data-frame-like object that contains a geometry column of class sfc 
# sfc stores the spatial forms of data such as the CRS, coordinates, and the type of geometric object 
uk_entire_capitals <- st_as_sf(uk_eire_capitals, coords=c("long", "lat"), crs=4326)
uk_entire_capitals


# Vector geometry operations #
# Making a polygon for London
st_pauls <- st_point(x=c(-0.09856, 51.513611))
london <- st_buffer(st_pauls, 0.25) # Defined London as anywhere within quarter degree of st_paul

england_no_london <- st_difference(england, london)
# remove london from england polygon, england the first argument so this gives parts of england thats not london
lengths(scotland) # shows the no of components and no of points in each components of a polygon
lengths(england_no_london) # this shows this polygon has two components (two rings)
# One ring of 18 for external border and one ring of 242 for the london border 
# There was 9 pairs of coordinates, so 18 points for the external border 
wales <- st_difference(wales, england) # Tidying up the border of Wales and england 

# Making a polygon for Northern Ireland from Ireland 
# Making a rough polygon that includes Northern Island and surrounding sea
ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))
northern_ireland <- st_intersection(ireland, ni_area) 
# Takes the region of intersection of the two polygons 
eire <- st_difference(ireland, ni_area)
uk_eire <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)
print(uk_eire)
# uk_eire now consist of 6 features 
# Features: a set of one or more vector GIS geometries that represent a spatial 
plot(uk_eire, asp=1)


