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
grp<-tapply(NEI$Emissions,NEI$year,sum)
names(grp)<-NULL
year<-c(1999,2002,2005,2008)
grp1<-cbind(year,grp)
## Creating a png file for the data
png("plot1.png")
plot(grp1,pch=19,col="blue",xlab = "Year",ylab="Total Annual Emissions (Tons)",type="p",main = "Total Annual Emission in the US by Year")
## Closing the file 
dev.off()
