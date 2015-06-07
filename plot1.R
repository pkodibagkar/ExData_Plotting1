## plot1.R

# load libraries
library(dplyr)


###  Initialize common variables
srcDir <- "C:/Data Science/workspace/ExData_Plotting1"
srcFile <- "household_power_consumption.txt"
imgFile <- "plot1.png"

# Load Power consumption file
powerDF <- read.table(paste(srcDir,"/", srcFile,sep = ""),sep = ";",stringsAsFactors=FALSE, header=TRUE)

# Removing observations with missing data
powerDF <- powerDF[as.character(powerDF$Global_active_power) != "?",]

# Convert the date column to a proper date and numeric format

powerDF$Time <- strptime(paste(powerDF$Date,powerDF$Time),"%d/%m/%Y %H:%M:%S")
powerDF$Date <- as.Date(powerDF$Date , "%d/%m/%Y")
powerDF$Global_active_power <- as.numeric(powerDF$Global_active_power) 

# Subsetting the data for certain dates only
powerDF <- powerDF[powerDF$Date == as.Date("2007-02-01") | powerDF$Date == as.Date("2007-02-02"),]
# print(summary(powerDF))

# Open PNG file
png(file = paste(srcDir,"/", imgFile,sep = ""), width=480, height=480)

# Print the histogram
hist(powerDF$Global_active_power, col="red",  main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the device
dev.off()
