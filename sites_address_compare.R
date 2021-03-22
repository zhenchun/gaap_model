require(dplyr)
require(ggplot2)
library("reshape2")

###weekly measurement from the monitoring site

load("pm25_v9.7.Rdata")

pm25_sites<-as.data.frame(pm25)

####weeekly prediction from the 3919 locations


load("sh/ST_2012_2019/T301_sep_v9.8_df8_2t_3d/pred_gaap_2016_7/prediction_EX.Rdata")

pm25_address<-as.data.frame(prediction_EX$PM2.5)

pm25_address<-exp(pm25_address)


########load the nn data 
library(readr)

nn <- read_csv("sites_55_nn.csv")


nn_100<-nn%>% filter(between(distance, 0,100))


compare6<-as.data.frame(cbind(pm25_sites[, nn_100$id[6]], pm25_address[, nn_100$join_id[6]]))



compare6$date<-rownames(pm25_address)
 

colnames(compare6)<-c(nn_100$id[6], nn_100$join_id[6], "date")

compare6_long <- melt(compare6, id="date")  

compare6_long$date<-as.Date(compare6_long$date, format =  "%Y-%m-%d")

ggplot(data=compare1_long,
       aes(x=date, y=value, colour=variable)) +
  geom_line(size=1)+ylab(expression(paste("PM2.5 concentrations (  ", mu, "g/",m^3,")")))



