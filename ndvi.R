setwd("C:/Users/zy125/Box/Postdoc/GAAP/R")

require(stringr)
ndvi<-data.frame()
for (i in c(300,500,750,1000,1500,2000,2500,3000)){
  dat<-read_csv(paste0("gaap_monthly_ndvi_",i,".csv",sep=""))
  colnames(dat)<-gsub(".*_","",colnames(dat))
  colnames(dat)[77]<-"original_id"
  colnames(dat)[1:72]<-str_c(colnames(dat)[1:72],"-01", sep = "", collapse = NULL)
  dat$buffer<-paste0("ndvi",str_pad(i, width=4, pad="0"),sep='')
  ndvi<-rbind(ndvi,dat)
  
}

ndvi<-ndvi%>%select(-'system:index', -latitude,-longitude,-original_id)

ndvi_all<- ndvi%>% gather(month, value, -c("id","buffer"))%>% spread(key = buffer, value = value)
colnames(ndvi_all)[1]<-"id"