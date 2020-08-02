library(dplyr)
library(ggplot2)
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
grp <- NEI %>% subset(fips=="24510") %>% group_by(year,type) %>% summarize(X=sum(Emissions,na.rm = TRUE))
png("plot3.png")
qplot (data=grp,year,X,facets=.~type,xlab = "Year",ylab = "Total Emission(Tons)", main = "Total Annual Emissions in Baltimore by Year")
dev.off()