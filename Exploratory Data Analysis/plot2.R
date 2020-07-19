library(lubridate)

## Reading the given table which is in the .txt format
## Setting boolean value of argument 'header' as TRUE, since the first line contains the Column names
Pow <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Subsetting the data for only 2  days  of february
Pow2 <- subset(Pow,Pow$Date=="1/2/2007" | Pow$Date =="2/2/2007")

## Using Lubridate command dmy_hms() to format the date and time  
Pow2$Time<-dmy_hms(paste(Pow2$Date,Pow2$Time))

## Creating a png file for the data
png("plot2.png")

## Calling the basic plot function
plot(Pow2$Time,as.numeric(Pow2$Global_active_power),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

## Annotating graph
title(main="Global Active Power Vs Time")

## Closing the file 
dev.off()
