## plot4.R

# load libraries
library(dplyr)


###  Initialize common variables
srcDir <- "C:/Data Science/workspace/ExData_Plotting1"
srcFile <- "household_power_consumption.txt"
imgFile <- "plot4.png"

# Load Power consumption file
powerDF <- read.table(paste(srcDir,"/", srcFile,sep = ""),sep = ";", stringsAsFactors=FALSE, header=TRUE)


# Removing observations with missing data
powerDF <- powerDF[as.character(powerDF$Global_active_power) != "?" & 
                       as.character(powerDF$Global_reactive_power) != "?" & 
                       as.character(powerDF$Sub_metering_1) != "?" & 
                       as.character(powerDF$Sub_metering_2) != "?" & 
                       as.character(powerDF$Sub_metering_3) != "?",]

# Convert the date column to a proper date and numeric format

powerDF$Time <- strptime(paste(powerDF$Date,powerDF$Time),"%d/%m/%Y %H:%M:%S")
powerDF$Date <- as.Date(powerDF$Date , "%d/%m/%Y")
powerDF$Global_active_power <- as.numeric(powerDF$Global_active_power) 
powerDF$Global_reactive_power <- as.numeric(powerDF$Global_reactive_power) 
powerDF$Voltage <- as.numeric(powerDF$Voltage) 
powerDF$Sub_metering_1 <- as.numeric(powerDF$Sub_metering_1) 
powerDF$Sub_metering_2 <- as.numeric(powerDF$Sub_metering_2) 
powerDF$Sub_metering_3 <- as.numeric(powerDF$Sub_metering_3) 


# Subsetting the data for certain dates only
powerDF <- powerDF[powerDF$Date == as.Date("2007-02-01") | powerDF$Date == as.Date("2007-02-02"),]
print(summary(powerDF))

# Open PNG file
png(file = paste(srcDir,"/", imgFile,sep = ""), width=480, height=480)

# setting up for multiple plots
par(mfrow = c(2, 2))

# Print the 1st plot
with ( powerDF, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# Print the 2nd plot
with ( powerDF, plot(Time, Voltage, type="l", xlab="", ylab="Voltage"))

# Print the 3rd plot
with ( powerDF, plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering"))
lines(powerDF$Time, powerDF$Sub_metering_2, type="l", col="red")
lines(powerDF$Time, powerDF$Sub_metering_3, type="l", col="blue")
legend("topright", lty= c(1), lwd=c(2.5), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Print the 4th plot
with ( powerDF, plot(Time, Global_reactive_power, type="l", xlab="", ylab="Global Reactive Power"))

# Close the device
dev.off()
