
date<-pm25_fudan$date
date<-date[-1]
d<-date[seq(1,length(date),by=3)]
pm25_fudan<-pm25_fudan[-1, ]

pm25_fudan<-as.data.frame(pm25_fudan)
pm25_craes<-as.data.frame(pm25_craes)

pm25_fudan_3d<- pm25_fudan%>%
  mutate(date = as.Date(date)) %>%
  group_by(date = cut(date, '3 days')) %>%
  summarise(across(starts_with('temp'), mean, na.rm = TRUE))


pm25_fudan_cpr<-pm25_fudan_3d[c(162:608), ]
p<-data.frame()

for (i in 1:4090) {
  
  p[i,1]<-rownames(pm25_craes)[i+1]
  
  p[i,2]<-cor(pm25_craes[, i+1], pm25_fudan_cpr[, i+1], use = "complete.obs")
}


library("reshape2")
library("ggplot2")

compare_long <- melt(compare, id="date")  # convert to long format

tiff("figure2.tiff",width=16, height=8, units = 'in', res=300)
ggplot(data=compare_long,aes(x=date, y=value, colour=variable))+geom_line(size=1)+labs(y=expression(paste("3 days averaged PM2.5 levels (  ",   mu, "g/",m^3,")")), font=18)+theme(text=element_text(size=18))
dev.off()

pm25_craes$rmean <- rowMeans(pm25_craes[,-1])

pm25_fudan_cpr$rmean <- rowMeans(pm25_fudan_cpr[,-1])

compare_all<-cbind(pm25_craes[,c(1,2)], pm25_fudan_cpr[,2])

colnames(compare_all)<-c("date",  "CRAES", "Fudan")
compare_all_long <- melt(compare_all, id="date") 


tiff("figure1.tiff",width=16, height=8, units = 'in', res=300)
ggplot(data=compare_all_long,aes(x=date, y=value, colour=variable))+geom_line(size=1)+labs(y=expression(paste("3 days averaged PM2.5 levels (  ",   mu, "g/",m^3,")")))+
  theme(text=element_text(size=18))

dev.off()
