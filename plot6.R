classification <- readRDS("Source_Classification_Code.rds")
classification$EI.Sector <- tolower(classification$EI.Sector)
classification <- classification[grepl("vehicles",classification$EI.Sector),]
pm25 <- readRDS("summarySCC_PM25.rds")
bpm25 <- pm25[pm25$fips == "24510",]
bpm25 <- merge(bpm25,classification)
bpm25$year <- factor(bpm25$year)
bpm25 <- tapply(bpm25$Emissions,bpm25$year,sum)
lpm25 <- pm25[pm25$fips == "06037",]
lpm25 <- merge(lpm25,classification)
lpm25$year <- factor(lpm25$year)
lpm25 <- tapply(lpm25$Emissions,lpm25$year,sum)
rm(classification)
pm25 <- data.frame(as.integer(names(bpm25)))
names(pm25) <- "year"
bpm25 <- lowess(pm25$year,bpm25)
lpm25 <- lowess(pm25$year,lpm25)
pm25$baltimore  <- bpm25$y
pm25$la  <- lpm25$y
rm(bpm25)
rm(lpm25)
png(filename = "plot6.png",width = 480, height = 480)
par(mfrow = c(1, 2))
with(pm25, {
  plot(year, la, xlab = "Years", main = "Los Angeles",  ylab = "PM2.5 (tons)", type= "l", col = "dark blue")
  plot(year, baltimore, xlab = "Years", main = "Baltimore",  ylab = "PM2.5 (tons)", type= "l", col = "dark green")
})
dev.off()
rm(pm25)
