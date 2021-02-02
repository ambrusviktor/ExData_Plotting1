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

png("./week_1_assignment/plot3.png", width  = 480, height = 480)
plot(Sub_metering_1 ~ datetime, data, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)
lines(Sub_metering_2 ~ datetime, data, type = "l",col="red")
lines(Sub_metering_3 ~ datetime, data, type = "l",col="blue")
legend("topright",col = c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lwd = 2 )

dev.off()

