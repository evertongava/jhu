library(ggplot2)
pm25 <- readRDS("summarySCC_PM25.rds")
pm25 <- pm25[pm25$fips == 24510,]
png(filename = "plot3.png",width = 480, height = 480)
qplot(year, Emissions, data = pm25, facets = type ~ ., cex = 5, main = "Baltimore PM2.5 Emission by Type", xlab = "Years",  ylab = "PM2.5 (tons)")
dev.off()
rm(pm25)
