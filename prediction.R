require(data.table)
library(lubridate)
library(dplyr)
library(zoo)
library(ggplot2)
library(reshape)
library(tidyr)

setwd("C:/Users/zy125/Box Sync/Postdoc/GAAP/R/shanghai/ST_2012_2019/T65_loocv_v9.6_df8_14d")

load("lim4trun_14d.Rdata")
load("pred_gaap_2016_1/prediction_EX.Rdata")


pm25<-as.data.frame(prediction_EX$PM2.5)
pm25<-exp(pm25)

range_pm25<-as.data.frame(lim4trun$PM2.5)

which(rownames(range_pm25)=="2016-05-01")

range_pm25<-range_pm25[1431:2770,]

cnt<-matrix(0,nrow = 1328, ncol = 2)

pm25_trun<-pm25

for (i in 1: 1328){
  n<-0
  m<-0
  for (j in 1:3919){
  
  if (pm25_trun[i, j]< range_pm25[i,1]) {
    
    pm25_trun[i,j]<-range_pm25[i,1]
    
    n<-n+1
    
  }
  
  else if (pm25_trun[i, j]> range_pm25[i,2]) {
    
    pm25_trun[i,j]<-range_pm25[i,2]
    
    m<-m+1
  }
 
  }
 cnt[i,1]<-n
 
 cnt[i,2]<-m
  
  
   
}


pm25_trun<-pm25_trun[1:1328,]

pm25t<-setDT(pm25_trun, keep.rownames="date")
pm25t$date<-as.Date(pm25t$date)
pm25t_long <- gather(pm25t, key = nam, value = "con", -date)


pm25d<-pm25[1:1328,]
pm25d<-setDT(pm25d, keep.rownames="date")
pm25d$date<-as.Date(pm25d$date)
pm25d_long <- gather(pm25d, key = nam, value = "con", -date)


pm25_compare<-bind_rows(pm25d_long, pm25t_long)


pm25_compare$type<-c(rep("All.Range", 5204432), rep("Truncated", 5204432))

tiff("figure1.tiff",width = 800, height=400)

ggplot(pm25_compare, aes(x = date, y = con, colour=type, group=type))+
  geom_point()+
  ylab(expression(paste("Predicted daily PM2.5 concentration (", mu, "g/",m^3,")")))

dev.off()

############################################old############################################
pm25_summary<-pm25_compare %>% 
  group_by(yr = year(date), mon = month(date), type) %>% 
  summarise_if(is.numeric, mean, na.rm=TRUE)


pm25_summary$date <- as.yearmon(paste(pm25_summary$yr, pm25_summary$mon), "%Y %m")



pm25_long <- gather(pm25_s, key = nam, value = "con", -date)

pm25_long$date<-as.Date(pm25_long$date)

ggplot(pm25_long, aes(x=date, y=con))+geom_boxplot()

timePlot(pm25_long, pollutant="con")

tiff("figure1.tiff",width = 800, height=300)

ggplot(pm25d_long, aes(x = date, y = con))+geom_point()

dev.off()

pred_truncated<-matrix(nrow=length(rownames(pm25)), ncol=4090)

rownames(pred_truncated)<-rownames(pm25)
colnames(pred_truncated)<-id$id_orig




for (i in 1:4090) {
  
  pred_truncated[,i]<-pm25t[, id$id[i]]
  
}











