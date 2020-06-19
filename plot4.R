dataset<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
str(dataset)
library(dplyr)
library(tidyr)
date_filter<-c("1/2/2007", "2/2/2007")
dataset_filter<-filter(dataset, Date %in% date_filter)
data_united<-unite(dataset_filter,col = "date_time", Date:Time,sep = "-")
data_united$date_time<-gsub("(/|:)","-",data_united$date_time)
library(lubridate)
Sys.setlocale("LC_TIME", "English")
data_united$date_time<-dmy_hms(data_united$date_time)

png("plot4.png", height=480,width = 480)
par(mfcol=c(2,2))

## plot 1
with(data_united,plot(date_time, Global_active_power, type="l",ylab = "Global Active Power (Kilowatts)", 
                      xlab = ""))

## plot 2
with(data_united,plot(date_time, Sub_metering_1, type="l",ylab = "Energy sub metering", 
                      pin=c(480,480),xlab = ""))
with(data_united,lines(date_time,Sub_metering_2,col="red"))
with(data_united,lines(date_time,Sub_metering_3,col="blue"))
legend("topright",lwd = 1, col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## plot 3
with(data_united,plot(date_time, Voltage, type="l",ylab = "Voltage", 
                      xlab = "datetime"))
## plot 4
with(data_united,plot(date_time, Global_reactive_power, type="l",ylab = "Global_reactive_Power", 
                      xlab = "datetime"))


dev.off()
