# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q: Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system

# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")
# retain only records for Baltimore City, Maryland (fips == "24510")
BLTemissions <- subset(emissions, fips == "24510")

# Plot a bar chart with Years on the X-axis and sum(PM2.5) on Y-axis
# PM2.5 units are tons
# First calculate the PM2.5 sum grouped by year
PM2.5 <- tapply(BLTemissions$Emissions, BLTemissions$year, sum)

# save to a png file
png("plot2.png", width = 480, height = 480)
barplot(PM2.5, 
        main = expression("Total PM"[2.5]*" Emissions For Baltimore City by Year"), 
        xlab = "Year", 
        ylab = expression("Total PM"[2.5]*" Emissions (Tons)"))
# turn device off
dev.off()
