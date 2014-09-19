# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 

# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")
# retain only records for Baltimore City, Maryland (fips == "24510")
BLTemissions <- subset(emissions, fips == "24510")
# construct plot
# setting fill = type will color the facet by type
g0 <- ggplot(data = BLTemissions, aes(factor(year), Emissions, fill = type))
# add layers
# setting stat = identity will result in the height of the bar representing the value i.e. Emissions
g1 <- g0 + geom_bar(stat = "identity")
# add facet wrap
g2 <- g1 + facet_wrap(~ type)
# Add axes labels
g3 <- g2 + labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)"))
# Add Title
g4 <- g3 + labs(title=expression("PM"[2.5]*" Emissions, Baltimore City by Source Type"))

# save to file
png("plot3.png", width = 480, height = 480)
print(g4)
dev.off()

