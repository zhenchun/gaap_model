require(sf)
library(dplyr)
require(ggplot2)
inner<-st_read("C:/Users/zy125/Box/Postdoc/GAAP/GIS/CRS_4499/sh_inner_polygon_crs4499.shp", crs=4499)
outer<-st_read("C:/Users/zy125/Box/Postdoc/GAAP/GIS/CRS_4499/sh_outer_clip_polygon_crs4499.shp", crs=4499)
gaap<-st_read("C:/Users/zy125/Box/Postdoc/GAAP/GIS/gaap_address_batch2_crs4499.shp", crs=4499)



ggplot() + 
  geom_sf(data = outer, fill = "grey", color = "grey") +
  geom_sf(data = data, color = data$zone)


index_inner<-st_contains(inner,gaap)
index_outer<-st_contains(outer,gaap)
gaap$zone<-3
gaap$zone[index_inner[[1]]]<-1
gaap$zone[index_outer[[1]]]<-2

gaap$zone<-factor(gaap$zone, levels=c(1,2,3))

gaap%>%filter(zone==3)%>%ggplot() + 
  geom_sf()

gaap%>%group_by(zone)%>%summarize(n=n())
##################################################
sh_boundary<-st_read("C:/Users/zy125/Box/Postdoc/GAAP/gis/sh_boundary_CRS4499.shp",crs=4499)
points<-st_read("C:/Users/zy125/Box/Postdoc/GAAP/Fudan_model/sh_points_crs4499.shp",crs=4499)


sh_points_district<-st_join(points,sh_boundary, join = st_intersects)
sh_points_district<-sh_points_district[,c(1,10,12,13)]
sh_points_district<-as.data.frame(sh_points_district)
sh_points_district<-sh_points_district[,c(1,2,3,4)]


