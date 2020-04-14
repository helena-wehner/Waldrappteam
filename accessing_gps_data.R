### Preparing NBI Data  for Analysis
### loading Data from DropBox
### request Data from single Birds during a specified time period

### Helena Wehner
### für: Masterarbeit Sinah

########################################################################################################
setwd("C:\\Users/Lenovo/Desktop/")

## packages
library(sp)
library(raster)
library(rgdal)
########################################################################################################
### sort by bird name

bird <- read.table("Waldrappteam/Sinah/vogellisteundanflge/Vogelliste 2019 Sinah.txt", header = T, sep="\t")
head(bird)

names <- bird$Name
names <- as.character(names)

or <- as.Date.factor("2019-07-01 00:00:00")
date <- as.factor(seq(or,length=184, by="day"))

gps <- readOGR("2019 all data/2019_allgpsdata.shp")

# generate a loop selecting individual birds from the gps dataset

sinah.l <- list()
sinah <- SpatialPointsDataFrame

for (i in 1:length(names)) {
  sinah.l[i] <- subset(gps, bird_name == names[i],)
}

print(sinah.l)

library(ini)
write.ini(sinah, "sinah.csv")

dflist <- as.data.frame(lapply(1:length(sinah.l), fun(i){
  as.data.frame(1:length(sinah.l[[i]]))}))

sinah.df <- list()

for (i in 1:length(sinah.l)) {
  sinah.df[[i]] <- as.data.frame(sinah.l[[i]])
}
# worked

# unlist sinah.df
library(plyr)
df.gps <- ldply(sinah.df, data.frame)

iy <- c(13)
df.gps$timestamp <- as.POSIXct(origin = as.Date("2019-01-01"),df.gps$timestamp,format="%Y-%m-%d %H:%M:%S")

date.gps <- df.gps[df.gps$timestamp>="2019-07-01 00:00:01",]

# generate a loop for selecting only 2019-07-01:2019-12-31 from df.gps dataset

#start <- as.POSIXct(as.Date("2019-07-01 00:01:00"), format="%Y-%m-%d %H:%M:%S", tz="UTC")
#end <- as.POSIXct(as.Date("2019-12-31 23:59:00"), format="%Y-%m-%d %H:%M:%S", tz="UTC")

#library(lubridate)
#stamp.2 <- seq(ymd_hms("2019-07-01 00:00:00"), ymd_hms("2019-12-31 23:59:00"), by="1 sec")

#time <- list()
#for (i in 1:length(stamp.2)) {
#  time[i] <- subset(df.gps, timestamp==stamp.2[i])
#}

# change df to spatialpointsdataframe
ix <- c(313,18:20) ## all diese spalten sind "factor", und hier transformiere sie zu "numeric"
df.gps[ix] <- lapply(df.gps[ix], as.numeric)
coords <- data.frame(x=df.gps$coords.x1, y=df.gps$coords.x2)

sinah.gps <- SpatialPointsDataFrame(coords,df.gps)
writeOGR(sinah.gps, dsn="Waldrappteam/Sinah", layer = "gps_2019", driver = "ESRI Shapefile")

# change date.gps to spatialpointsdataframe
coords.2 <- data.frame(x=date.gps$coords.x1, y=date.gps$coords.x2)

date.2019 <- SpatialPointsDataFrame(coords.2, date.gps)
writeOGR(date.2019, dsn="Waldrappteam/Sinah", layer="date_2019", driver = "ESRI Shapefile")

####################################################################################################
### sort by time

# take the individual bird list and select for time: 01.07.2019-31.12.2019

jazu <- subset(gps, bird_name== c("Jazu"),)
plot(jazu)
tail(jazu)

