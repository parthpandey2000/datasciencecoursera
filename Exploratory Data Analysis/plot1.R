## Reading the given table which is in the .txt format
## Setting boolean value of argument 'header' as TRUE, since the first line contains the Column names
Pow <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Subsetting the data for only 2  days  of february
Pow2 <- subset(Pow,Pow$Date=="1/2/2007" | Pow$Date =="2/2/2007")

## Creating a png file for the data
png("plot1.png")

## Plotting the histogram
hist(as.numeric(Pow2$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
## Annotating the plot to give the title
title(main="Global Active Power")

## Closing the file 
dev.off()