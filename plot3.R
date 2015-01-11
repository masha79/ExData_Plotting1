#include dplyr to use its filter function
library(dplyr)

## archive with data is loaded from: 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 

##unzipped to the folder with the script: household_power_consumption.txt
file_name <- 'household_power_consumption.txt'

all_data <- read.table(file_name,header=TRUE,stringsAsFactors=FALSE,sep=";",na.strings='?')
all_data$Date <- as.Date(all_data$Date, '%d/%m/%Y')

jan_feb_2007_data <- filter(all_data, Date == '2007-02-01' | Date == '2007-02-02') 
jan_feb_2007_data$Time <- strptime(paste(as.character(jan_feb_2007_data$Date),jan_feb_2007_data$Time), '%Y-%m-%d %H:%M:%S')

## release memory allocated for the entire set
rm(all_data)
gc()

png(file = "plot3.png", bg = "transparent", antialias="cleartype", width=504,height=504)

plot(jan_feb_2007_data$Time,jan_feb_2007_data$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(jan_feb_2007_data$Time,jan_feb_2007_data$Sub_metering_1)
lines(jan_feb_2007_data$Time,jan_feb_2007_data$Sub_metering_2,col="red")
lines(jan_feb_2007_data$Time,jan_feb_2007_data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),pch="-")

dev.off()