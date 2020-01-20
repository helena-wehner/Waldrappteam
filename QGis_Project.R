### Autumn Migration - Northern Bald Ibis
### Waldrappteam
### Helena W.

setwd("C:/Users/Lenovo/Desktop/")

library(sp)
library(raster)
install.packages("sf")
library(sf)

q3 <- st_read("GPS_data_Helena/2019_Q3.shp")
head(q3)
str(q3)
names(q3)

Afra <- q3[7901:11707,5:6]
head(Afra)
plot(Afra$geometry)

install.packages("tmaptools")
library(tmaptools)
install.packages("OpenStreetMap")
library(OpenStreetMap)

read_osm(Afra, type = "osm")
