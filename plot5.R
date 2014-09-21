# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q3: OHow have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")

# load source classification file
srcclass <- readRDS("Source_Classification_Code.rds")

# retain only records for Baltimore City, Maryland (fips == "24510")
BLTemissions <- subset(emissions, fips == "24510")

# retain only records for motor vehicle emissions
# Filter the EI.Sector field 
library(sqldf)
BLTmveh <- sqldf("select e.year Year,sum(e.Emissions) tot_emissions
                 from   BLTemissions e
                 inner join
                        srcclass s
                 on    e.SCC = s.SCC
                 where s.EI_Sector like '%Vehicle%'
                 group by e.year")

# create plot
q <- qplot(factor(Year), 
           tot_emissions, 
           data = BLTmveh,
           geom = "bar",
           stat = "Identity",
           xlab = "Year",
           ylab = "Baltimore Emissions - Motor Vehicle Sources (Tons) ",
           main = "Emissions from Motor Vehicle Sources in Baltimore City"
) + theme_bw()

# save to file
png("plot5.png", width = 480, height = 480)
print(q)
dev.off()
