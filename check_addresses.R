

coor<-cbind(gaap_address_batch2$id, gaap_address_batch2$wgsLon, gaap_address_batch2$wgsLat) 



colnames(coor)<-c("id","wgsLon", "wgsLat") 

coor<-as.data.frame(coor)


count<-coor %>% 
  group_by(wgsLon, wgsLat) %>% summarise(number = n())


co<-coor[,c(2,3)]


co[duplicated(co),]

library(data.table)
result<-setDT(co)[,list(Count=.N),names(co)]
outcome<-merge(gaap_address_batch2, result, by=c('wgsLon','wgsLat'))
check<-outcome[outcome$Count>3,]
write.csv(check, "duplicated_address_of_3.csv",fileEncoding = "UTF-8")

district<-outcome %>% 
  group_by(adcode) %>% summarise(people = n())
