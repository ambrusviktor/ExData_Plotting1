rm(list = ls())
library(lubridate)
#get data
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

ssfile="./week_1_assignment/data/subset.txt"
if(!file.exists(ssfile)){
  datazip="./week_1_assignment/data/household_power_consumption.zip"
  data=gsub(datazip,pattern = "zip",replacement = "txt")
  if(!file.exists(datazip)){download.file(url = url,destfile = datazip)}
  if(!file.exists(data)){
    unzip(datazip, exdir = "./week_1_assignment/data")
  }
  x=read.csv(data,sep=';', header = T,na="?")
  x$Date <- as.Date(as.character(x$Date), "%d/%m/%Y")
  data=x[ grep(x$Date,pattern= "2007-02-01|2007-02-02"),]
  write.table(data,ssfile,row.names = F,col.names = T,quote = T,sep=";")
}else{
  data<- read.csv(ssfile, header = T,sep = ";")
}

data$datetime <- ymd_hms(paste(data$Date,data$Time));

png("./week_1_assignment/plot2.png", width  = 480, height = 480)
plot(Global_active_power ~ datetime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)
dev.off()
