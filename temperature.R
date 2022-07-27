
require(tidyr)
library(lubridate)
data<-data.frame()

for (year in c(2017,2018,2019,2020)) {
        dat<-read.table(paste0("C:/Users/zy125/Box/Postdoc/GAAP/Fudan_model/meterological/583211-99999-",year), quote="\"", comment.char="")
       colnames(dat)<-c("year", "month", "day", "hour", "tem", "dp_tem", "sl_pressure", "wd", "ws","Sky","lpdd","lpd")
       dat$datetime<-with(dat, ymd_h(paste(year, month, day, hour, sep= ' ')))
       ts <- seq.POSIXt(as.POSIXct(paste0(year,"-01-01 0:00"),'%m/%d/%y %H:%M:%S'), as.POSIXct(paste0(year,"-12-31 23:00"),'%m/%d/%y %H:%M:%S'), by="hour")
       ts<-data.frame(ts)
       colnames(ts)[1]<-"datetime"
       dat<-left_join(ts, dat, by="datetime")
       dat<-dat[,c('datetime','tem','wd','ws')]
       dat$tem<-dat$tem/10
       dat$ws<-dat$ws/10
       data<-rbind(data, dat)
}

data<-data%>%fill(c('tem' ,'wd' , 'ws'), .direction = c( "down"))

########pudong and hongqiao hourly data
data<-data.frame()
for (year in c(2017,2018,2019,2020)) {
  dat<-read.table(paste0("C:/Users/zy125/Box/Postdoc/GAAP/Fudan_model/meterological/583211-99999-",year), quote="\"", comment.char="")
  colnames(dat)<-c("year", "month", "day", "hour", "tem", "dp_tem", "sl_pressure", "wd", "ws","Sky","lpdd","lpd")
  dat$datetime<-with(dat, ymd_h(paste(year, month, day, hour, sep= ' ')))
  dat<-dat[,c('datetime','tem','wd','ws')]
  dat$tem<-dat$tem/10
  dat$ws<-dat$ws/10
  data<-rbind(data, dat)
}
data<-na_if(data, -9999)

data<-data%>%fill(wd, .direction = c( "down"))
sh3<-data
sh3$site<-583211
sum(is.na(data))



met_arr<-left_join(met, s, by="site")
met_arr<-met_arr[,c(1,2,3,4,6)]

qy_all_2<-left_join(qy_all, met_arr, by=c("id","datetime"))

qy_all_3<- qy_all_2[, !colnames(qy_all_2) %in% c('lon','lat','datetime','sunrise','sunset')]
qy_all_day<-aggregate( .~id + date,  
           qy_all_3, mean,na.rm = TRUE)


setwd('C:/Users/zy125/Box/Postdoc/GAAP/Fudan_model/R')
list.files()
library(readr)
qy_pm25<-qy_data[,c('pm25','date','id')]
qy_pm25_date<-aggregate( pm25~id + date,  
                        qy_pm25, mean,na.rm = TRUE)
met_arr$date<-as.Date(met_arr$datetime)
met_date<-aggregate(cbind(tem,wd,ws)~id + date,  
                    met_arr, mean,na.rm = TRUE)

da<-left_join(qy_pm25_date, met_date, by=c('date', 'id'))
da<-left_join(da, qy_lu_all, ('id'))
qy_cat<-qy_all[,c('date', 'id','season','businessday','month','year', 'weekday')]
qy_cat<-qy_cat[!duplicated(qy_cat), ]

da<-left_join(da, qy_cat, by=c('date', 'id'))

ndvi<- qy_all_2%>%dplyr:: select(id, month, year, starts_with("ndvi"))
ndvi<-ndvi[!duplicated(ndvi), ]
da<-left_join(da, ndvi, by=c('id','month','year'))


nl<- qy_all_2%>%dplyr:: select(id, year, starts_with("nl"))
nl<-nl[!duplicated(nl), ]
da<-left_join(da, nl, by=c('id','year'))
