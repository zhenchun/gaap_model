

#######load the id transfer file

library(readr)
id <- read_csv("id_transfer.csv")

###load modelled pm2.5 results

load("prediction_EX.Rdata")

pm25<-exp(pm25)


pred<-matrix(nrow=length(rownames(pm25)), ncol=4090)

rownames(pred)<-rownames(pm25)
colnames(pred)<-id$id_orig




for (i in 1:4090) {
  
  pred[,i]<-pm25[, id$id[i]]
  
}
