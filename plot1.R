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

##Convert date & time to date/time class
data$Date <- dmy(data$Date)
data$Time <- times(data$Time)
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

##Subset days
refine <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

##remove unneeded data
rm(data)

##Plot

png(filename = "plot1.png", width=480, height=480)
hist(refine$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()


