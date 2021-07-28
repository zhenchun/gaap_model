

#######load the id transfer file

library(readr)
library(data.table)

setwd("C:/Users/zy125/Box Sync/Postdoc/GAAP/R")

id <- read_csv("id_transfer.csv")

###load modelled pm2.5 results

load("C:/Users/zy125/Box Sync/Postdoc/GAAP/R/sh/ST_2012_2019/T4all_sep_v16.0.3_loocv_NO2_PM10_df08_3d/pred_gaap_201605_3/prediction_EX.Rdata")

pm10<-prediction_EX$PM10

pm10<-exp(pm10)


pred<-matrix(nrow=length(rownames(pm10)), ncol=4090)

rownames(pred)<-rownames(pm10)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-pm10[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "PM10_temp_id_3d_v16.0.3.csv")



###load modelled PM10 results

load("pred_PM10.Rdata")

pm10<-pred$EX

pm10<-exp(pm10)


result<-matrix(nrow=length(rownames(test)), ncol=4090)

rownames(result)<-rownames(test)
colnames(result)<-id$id_orig




for (i in 1:4090) {
  
  result[,i]<-test[, id$id[i]]
  
}


result<-as.data.frame(result)
result$temp_03827-result$temp_00344

result$temp_03087-result$temp_00768


write.csv(result, "temperature_fudan_temp_id.csv")




###load modelled PM10 results

load("pred_ozone.Rdata")

ozone<-pred$EX

ozone<-exp(ozone)


result<-matrix(nrow=length(colnames(temp2)), ncol=4090)

rownames(result)<-colnames(temp2)
colnames(result)<-id$id_orig




for (i in 1:4090) {
  
  result[,i]<-temp2[id$id[i], ]
  
}


result<-as.data.frame(result)
result$temp_03827-result$temp_00344

result$temp_03087-result$temp_00768


write.csv(result, "ozone_temp_id_daily_v9.9.csv")


###load modelled PM10 results

load("pred_ozone_8h.Rdata")

ozone_8h<-pred$EX

ozone_8h<-exp(ozone_8h)


test<-as.data.frame(test)
test<-setDT(test, keep.rownames = TRUE)[]

names(test) <- as.matrix(test[1, ])
test <- test[-1, ]

pm2.5_result<-matrix(nrow=length(rownames(test)), ncol=4090)

rownames(pm2.5_result)<-rownames(test)
colnames(pm2.5_result)<-id$id_orig




for (i in 1:4090) {
  
  temp_result[,i]<-temp2[id$id[i], ]
  
}



temp_result<-matrix(nrow=length(colnames(temp2)), ncol=4090)

rownames(temp_result)<-colnames(temp2)
colnames(temp_result)<-id$id_orig





pm2.5_result<-as.data.frame(pm2.5_result)
pm2.5$temp_03827-pm2.5$temp_00344

pm2.5$temp_03087-pm2.5$temp_00768


write.csv(result, "ozone_8h_temp_id_daily_v9.9.csv")


###load modelled ozone_8h results

load("pred_ozone_8h.Rdata")

ozone_8h<-pred$EX

ozone_8h<-exp(ozone_8h)


result<-matrix(nrow=length(rownames(test)), ncol=4090)

rownames(result)<-rownames(test)
colnames(result)<-id$id_orig




for (i in 1:4090) {
  
  result[,i]<-test[, id$id[i]]
  
}


result<-as.data.frame(result)
result$temp_03827-result$temp_00344

result$temp_03087-result$temp_00768


write.csv(result, "ozone_8h_fudan_temp_id.csv")



###load modelled CO results

load("pred_CO.Rdata")

CO<-pred$EX

CO<-exp(CO)


result<-matrix(nrow=length(rownames(CO)), ncol=4090)

rownames(result)<-rownames(CO)
colnames(result)<-id$id_orig




for (i in 1:4090) {
  
  result[,i]<-CO[, id$id[i]]
  
}


result<-as.data.frame(result)
result$temp_03827-result$temp_00344

result$temp_03087-result$temp_00768


write.csv(result, "CO_temp_id_daily_v9.9.csv")



##########################################################################################
########################################################################################


load("C:/Users/zy125/Box Sync/Postdoc/GAAP/R/sh/ST_2012_2019/T4all_sep_v15.0_NO2_model1_df8_3d/pred_gaap_201605_3/prediction_EX.Rdata")

NO2<-prediction_EX$NO2

NO2<-exp(NO2)


pred<-matrix(nrow=length(rownames(NO2)), ncol=4090)

rownames(pred)<-rownames(NO2)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-NO2[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "NO2_temp_id_3d_v15.csv")

###########################################################################################################
ozone<-prediction_EX$ozone

ozone<-exp(ozone)


pred<-matrix(nrow=length(rownames(ozone)), ncol=4090)

rownames(pred)<-rownames(ozone)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-ozone[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "ozone_temp_id_3d_v16.1.csv")





###########################################################################################################
ozone_8h<-prediction_EX$ozone_8h

ozone_8h<-exp(ozone_8h)


pred<-matrix(nrow=length(rownames(ozone_8h)), ncol=4090)

rownames(pred)<-rownames(ozone_8h)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-ozone_8h[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "ozone_8h_temp_id_3d_v16.1.csv")




###########################################################################################################
CO<-prediction_EX$CO

CO<-exp(CO)


pred<-matrix(nrow=length(rownames(CO)), ncol=4090)

rownames(pred)<-rownames(CO)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-CO[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "CO_temp_id_3d_v16.1.csv")

####################################################################################################


library(readr)

setwd("C:/Users/zy125/Box Sync/Postdoc/GAAP/R")

id <- read_csv("id_transfer.csv")

###load modelled pm2.5 results

load("C:/Users/zy125/Box Sync/Postdoc/GAAP/R/sh/ST_2012_2019/T4all_sep_v16.0.3_loocv_PM2.5_df8_3d/pred_gaap_201605_3/prediction_EX.Rdata")

pm25<-prediction_EX$PM2.5

pm25<-exp(pm25)


pred<-matrix(nrow=length(rownames(pm25)), ncol=4090)

rownames(pred)<-rownames(pm25)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-pm25[, id$id[i]]
  
}


pred<-as.data.frame(pred)
pred$temp_03827-pred$temp_00344

pred$temp_03087-pred$temp_00768


write.csv(pred, "PM2.5_temp_id_3d_v16.0.3.csv")
