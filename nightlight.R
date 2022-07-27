
require(readr)
require(stringr)
require(tidyr)
require(dplyr)
nl<-data.frame()
for (i in c(500,1000,1500,2000,2500,3000)){
  dat<-read_csv(paste0("gaap_nightlight_",i,".csv",sep=""))
  colnames(dat)<-gsub(".*_","",colnames(dat))
  colnames(dat)[11]<-"original_id"
  dat$buffer<-paste0("nl",str_pad(i, width=4, pad="0"),sep='')
  nl<-rbind(nl,dat)
  
}

nl<-nl%>%select('2016','2017','2018','2019','2020','2021',id,buffer)

nl_all<-nl%>% gather(year, value, -c("id","buffer"))%>% spread(key = buffer, value = value)

nl_all$year<-as.numeric(nl_all$year)

qy_data<-left_join(qy_data, nl_all,by=c("id","year"))