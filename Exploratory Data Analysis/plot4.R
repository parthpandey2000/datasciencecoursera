library(lubridate)

## Reading the given table which is in the .txt format
## Setting boolean value of argument 'header' as TRUE, since the first line contains the Column names
Pow <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Subsetting the data for only 2  days  of february
Pow2 <- subset(Pow,Pow$Date=="1/2/2007" | Pow$Date =="2/2/2007")

## Using Lubridate command dmy_hms() to format the date and time  
Pow2$Time<-dmy_hms(paste(Pow2$Date,Pow2$Time))

## Creating a png file for the data
png("plot4.png")

## Dividing the screen into 2 rows and 2 columns
par(mfcol=c(2,2))

## Calling the basic plot function
with(Pow2,{
  plot(Pow2$Time,as.numeric(Pow2$Global_active_power),type="l",  xlab="",ylab="Global Active Power")  
  plot(Pow2$Time,Pow2$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(Pow2,lines(Time,as.numeric(Sub_metering_1)))
  with(Pow2,lines(Time,as.numeric(Sub_metering_2),col="red"))
  with(Pow2,lines(Time,as.numeric(Sub_metering_3),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(Pow2$Time,as.numeric(Pow2$Voltage), type="l",xlab="datetime",ylab="Voltage")
  plot(Pow2$Time,as.numeric(Pow2$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")
})

## Closing the file
dev.off()