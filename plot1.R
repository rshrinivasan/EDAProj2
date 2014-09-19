# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the 
# total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")
srcclass <- readRDS("Source_Classification_Code.rds")
# Plot a bar chart with Years on the X-axis and sum(PM2.5) on Y-axis
# PM2.5 units are tons
# First calculate the PM2.5 sum grouped by year
PM2.5 <- tapply(emissions$Emissions, emissions$year, sum)
# Format the numbers for better display (million tons)
PM2.5 <- PM2.5 / 1000000
# save to a png file
png("plot1.png", width = 480, height = 480)
barplot(PM2.5, 
        main = expression("Total PM"[2.5]*" Emissions From All Sources by Year"), 
        xlab = "Year", 
        ylab = expression("Total PM"[2.5]*" Emissions (Million Tons)"))
# turn device off
dev.off()
