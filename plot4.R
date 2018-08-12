##Load Libraries
library(dplyr)
library(lubridate)
library(magrittr)
library(chron)

##Download Data + unzip

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "E:/Coursera Data Science/Course 4/Week 1/projectfiles.zip"
download.file(url, destfile)
unzip(zipfile = destfile, exdir= "E:/Coursera Data Science/Course 4/Week 1/projectfiles")

##read data
data <- read.csv2("E:/Coursera Data Science/Course 4/Week 1/projectfiles/household_power_consumption.txt", 
                  na.strings = "?") %>% as_tibble

##Convert to correct class
data$Date <- dmy(data$Date)
data$Time <- times(data$Time)
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))


##Subset days
refine <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

##create date&time combined column
refine$datetime <- strptime(paste(refine$Date, refine$Time), "%Y-%m-%d %H:%M:%S")

##remove unneeded data
rm(data)

## Open plot

png(filename = "plot4.png", width=480, height=480)
par(mfrow = c(2,2))

##topleft
plot(refine$datetime, refine$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")

##topright
plot(refine$datetime, refine$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


##bottomleft

plot(refine$datetime, refine$Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering")
lines(refine$datetime, refine$Sub_metering_2, col = "red")
lines(refine$datetime, refine$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n")


##bottomright
plot(refine$datetime, refine$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


##dev off
dev.off()