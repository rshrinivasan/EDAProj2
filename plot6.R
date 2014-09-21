# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")

# load source classification file
srcclass <- readRDS("Source_Classification_Code.rds")

# retain only records for Baltimore City, Maryland (fips == "24510") and
# Los Angeles California (fips == "06037")
BLTLAemissions <- subset(emissions, fips %in% c("24510", "06037"))

# retain only records for motor vehicle emissions
# Filter the EI.Sector field 
library(sqldf)
BLTLAmveh <- sqldf("select e.year Year,
                         case when e.fips = '24510' then 'Baltimore City'
                              else 'Los Angeles' 
                          end City,sum(e.Emissions) tot_emissions
                 from   BLTLAemissions e
                 inner join
                 srcclass s
                 on    e.SCC = s.SCC
                 where s.EI_Sector like '%Vehicle%'
                 group by e.year, e.fips")

# construct plot
# setting fill = type will color the facet by type
g0 <- ggplot(data = BLTLAmveh, aes(factor(Year), tot_emissions, fill = City))
# add layers
# setting stat = identity will result in the height of the bar representing the value i.e. Emissions
g1 <- g0 + geom_bar(stat = "identity")
# add facet wrap
g2 <- g1 + facet_wrap(~ City)
# Add axes labels
g3 <- g2 + labs(x="Year", y=expression("Total PM"[2.5]*" Motor Vehicles Emission (Tons)"))
# Add Title
g4 <- g3 + labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions, Baltimore City & Los Angeles"))

# save to file
png("plot6.png", width = 583, height = 406)
print(g4)
dev.off()
