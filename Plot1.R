## Requires dplyr for filter and transform functionality

# COMMON REGION for all the scripts. This generates the data that is needed for plotting
# This could have been pushed to a function. But, repeating it in every code for functional completeness
library(dplyr)
input <- read.csv("exdata-data-household_power_consumption\\household_power_consumption.txt",
                  header=TRUE,
                  sep=";",dec=".",na.strings="?", as.is = TRUE,
                  comment.char = "",
                  colClasses=c(rep("character",2),rep("numeric",7)),
                  nrows=2075260)

filterCondition <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
requiredInput <- filter(input,as.Date(Date,"%d/%m/%Y") %in% filterCondition)
transformedInput <- transmute(requiredInput, 
                              datetime = as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")),
                              day      = weekdays(as.Date(Date,"%d/%m/%Y"),abbreviate=TRUE),
                              Global_active_power,
                              Global_reactive_power,
                              Voltage,
                              Sub_metering_1,
                              Sub_metering_2,
                              Sub_metering_3)

#END - COMMON REGION

# Code to generate plot1.png
png(file="plot1.png",width = 480, height = 480, units = "px")
hist(transformedInput$Global_active_power,
     col = "red",xlab="Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()