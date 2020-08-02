url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "destfile.zip"

if(!file.exists(destfile1)) {
  download.file(url1, 
                destfile = destfile1, 
                method = "curl")
  unzip(destfile1, exdir = ".")
}


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
grp <- subset(NEI,NEI$fips=="24510") 
grp <- tapply(grp$Emissions, grp$year, sum)
names(grp)<-NULL
year<-c(1999,2002,2005,2008)
grp1<-cbind(year,grp)
## Creating a png file for the data
png("plot2.png")
plot(grp1,pch=24,col="red",xlab = "Year",ylab="Total Annual Emissions (Tons)",main = "Total Annual Emission in the Baltimore city by Year")
## Closing the file 
dev.off()
