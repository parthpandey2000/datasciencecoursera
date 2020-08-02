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
a <- SCC[grep("[Cc]oal",SCC$EI.Sector),]
grp <- NEI %>% subset(NEI$SCC %in% a$SCC) %>% group_by(year) %>% summarize(Total=sum(Emissions,na.rm = TRUE))
png("plot4.png")
qplot(data=grp,year,Total,col=year,xlab="Year",ylab = "Total Emissions [Tons]",main = "Total Annual Coal Combustion Emissions in the US")
dev.off()