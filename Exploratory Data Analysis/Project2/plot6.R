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
a <- SCC[grep("[Vv]ehicles",SCC$Short.Name),]
grp <- NEI %>% subset((NEI$fips=="24510" | NEI$fips=="06037") & NEI$SCC %in% a$SCC) %>% group_by(year,fips) %>% summarize(Total=sum(Emissions,na.rm = TRUE))
grp$fips<-sub("24510","Baltimore City",grp$fips)
grp$fips<-sub("06037","Los Angeles County",grp$fips)
png("plot6.png")
qplot(data=grp,year,Total,facets = .~fips,col=year,xlab="Year",ylab = "Total Emissions [Tons]",main = "Total Annual Vehicular Emissions")
dev.off()

