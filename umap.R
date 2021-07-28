
require(dplyr)
library(data.table)
library(hydroTSM)

load("C:/Users/zy125/Box Sync/Postdoc/GAAP/R/sh/ST_2012_2019/T4all_sep_v16.0.3_loocv_PM2.5_df8_3d/pred/")
points<-geocovars %>% mutate(group= case_when(
  
  between(m_to_road_A, 0, 50) ~ 1,
  between(m_to_road_A, 50, 100) ~ 2,
  between(m_to_road_A, 100, 150) ~ 3,
  between(m_to_road_A, 150, 200) ~ 4,
  between(m_to_road_A, 200, 250) ~ 5,
  between(m_to_road_A, 250, 300) ~ 6,
  between(m_to_road_A, 300, 350) ~ 7,
  between(m_to_road_A, 350, 400) ~ 8,
  between(m_to_road_A, 400, 450) ~ 9,
  between(m_to_road_A, 450, 500) ~ 10,
  between(m_to_road_A, 500, 750) ~ 11,
  between(m_to_road_A, 750, 1000) ~ 12,
  between(m_to_road_A, 1000, 1500) ~ 13,
  between(m_to_road_A, 1500, 5000) ~ 14,
  between(m_to_road_A, 5000, 21390) ~ 15,
  
  
))



latitude<-geocovars %>% mutate(group= case_when(
  
  between(latitude, 30.71968, 30.82486) ~ 1,
  between(latitude, 30.82486, 30.93003) ~ 2,
  between(latitude, 30.93003, 31.0352) ~ 3,
  between(latitude, 31.0352, 31.14037) ~ 4,
  between(latitude, 31.14037, 31.24554) ~ 5,
  between(latitude, 31.24554, 31.35071) ~ 6,
  between(latitude, 31.35071, 31.45588) ~ 7,
  between(latitude, 31.45588, 31.56105) ~ 8,
  between(latitude, 31.56105, 31.66622) ~ 9,
  between(latitude, 31.66622, 31.77139) ~ 10,
  between(latitude, 31.77139, 31.87656) ~ 11,

  
  
))

pm25<-prediction_EX$PM2.5
pm25<-exp(pm25)
pm25<-t(pm25)

pm25<-as.data.frame(pm25)
pm25<-setDT(pm25, keep.rownames=TRUE)[]





group<-data.frame()

mi<-min(geocovars$longitude)
ma<-max(geocovars$longitude)
gap<-(ma-mi)/10
p<-mi

for (i in 1:10){
  
  group[i,1]<-p
  group[i,2]<-p+gap
  p<-p+gap
}

longitude<-geocovars %>% mutate(group= case_when(
  
  between(longitude, group[1,1], group[1,2]) ~ 1,
  between(longitude, group[2,1], group[2,2]) ~ 2,
  between(longitude, group[3,1], group[3,2]) ~ 3,
  between(longitude, group[4,1], group[4,2]) ~ 4,
  between(longitude, group[5,1], group[5,2]) ~ 5,
  between(longitude, group[6,1], group[6,2]) ~ 6,
  between(longitude, group[7,1], group[7,2]) ~ 7,
  between(longitude, group[8,1], group[8,2]) ~ 8,
  between(longitude, group[9,1], group[9,2]) ~ 9,
  between(longitude, group[10,1], group[10,2]) ~ 10,
  
  
))



longitude<-longitude[, c(1,333)]



pm25<-prediction_EX$PM2.5
pm25<-exp(pm25)
pm25<-t(pm25)

pm25<-as.data.frame(pm25)
pm25<-setDT(pm25, keep.rownames=TRUE)[]
colnames(pm25)[1]<-"id"
pm25$id<-as.numeric(pm25$id)
pm25<-merge(pm25,points_1km_with_district)
pm25<-pm25[,-1]

colnames(pm25)[874]<-"group"

pm25_aggregate<-aggregate(.~ group, data = pm25, FUN = mean)
write.csv(pm25, "pm25_umap_longitude.csv")



code<-c(3292750,398374,1673543,398348,398350,3530718,398353,398351,398886,3292760,1278189,398899,371650,1278188,3293722,3292751,3292756)

# List of Names
pm25$group<-0

for (i in 1:17){
  pm25$group[pm25$osm_id == code[i]] <- i
  
  
}


#####################################umap by month##########################################
############################################################################################
colnames(pm25)[1]
colnames(pm25)[1]<-"date"
pm25$date<-as.Date(pm25$date, format =  "%Y-%m-%d")
pm25$month<-month(pm25$date)

pm25<-pm25[,-1]
pm25_month<-aggregate(.~ month, data = pm25, FUN = mean)



pm25$season<-time2season(pm25$date, out.fmt="seasons")


pm25_season<-aggregate(.~ season, data = pm25, FUN = mean)

#################################################################################################
################################################################################################

pm25_site_tran<-t(pm25_site)
View(pm25_site_tran)
pm25_site_tran<-as.data.frame(pm25_site_tran)
pm25_site_tran<-setDT(pm25_site_tran, keep.rownames=TRUE)[]
View(pm25_site_tran)
names(pm25_site_tran)<-as.character(pm25_site_tran[1,])
pm25_site_tran<-pm25_site_tran[-1,]

