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

png(file = "plot2.png", bg = "transparent", antialias="cleartype", width=504,height=504)
plot(jan_feb_2007_data$Time,jan_feb_2007_data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()