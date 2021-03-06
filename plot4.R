##################################
##
##  Code for generating Plot 4
##  Code assumes data is located in working directory
##  in file: household_power_consumption.txt
##  data can be found at: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##
##################################

## load file into data frame
data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

## Convert date variables to date
data$Date <- as.Date(as.character(data$Date), format="%d/%m/%Y")

## create date/time vector and bind it as new column
DateTime <- strptime(paste(as.character(data$Date), data$Time), format="%Y-%m-%d %H:%M:%S")
data <- cbind(data, DateTime)

## Filter down to just 2007-02-01 thru 2007-02-02
data <- data[(data$Date == "2007-02-01") | (data$Date == "2007-02-02"),]

## open PNG device
png(filename = "plot4.png", width =480, height=480, bg="transparent")

## set up plot grid
par(mfrow = c(2,2))

## draw top left plot
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## draw top right plot
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

## draw bottom left plot

plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty="solid", box.lwd =0)

## draw bottom right plot
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## close PNG device
dev.off()
