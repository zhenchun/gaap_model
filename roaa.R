TjGxsikfQfgdZXAyncPXPdTjBTioUZsM
library(devtools)
devtools::install_github("ropensci/rnoaa")
library("rnoaa")
library("lawn")


stations<-stations[!with(stations,is.na(lon)|lon<=0| is.na(lat)| lat<=0),]
stations_sf<-st_as_sf(stations, coords = c("lon", "lat"), 
         crs = 4326)
sh_bbox<-st_bbox(c(xmin = 120.8568, xmax = 122.2471, ymax = 31.87272, ymin = 30.67559), crs = st_crs(4326))

climate<-ncdc(datasetid = 'GHCND', stationid = 'GHCND:CHM00058362', startdate = '2016-01-01',
     enddate = '2016-12-31', token="TjGxsikfQfgdZXAyncPXPdTjBTioUZsM")


geo<-geocovars

geo_sf <- geo %>% st_as_sf(coords = c("longitude", "latitude" ), remove = T) %>%
  st_set_crs(4326) 

qy_sf<- qy_coordinates %>% st_as_sf(coords = c("longitude", "latitude"), remove = T) %>%
  st_set_crs(4326) 


joined_sf <- geo_sf %>% 
  cbind(
    qy_sf[st_nearest_feature(geo_sf, qy_sf),])
