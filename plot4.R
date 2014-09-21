# setwd("~/Documents/Coursera/datascience_jh/EDA")
# Course Project 2 (National Emissions Inventory Database)
# Q4: Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999–2008?

# Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

# Data in file summarySCC_PM25.rds
emissions <- readRDS("summarySCC_PM25.rds")
# The source of the pollutant in the data file is not descriptive. This needs
# to be joined to the source classification file to get the description
# load the source classification file
srcclass <- readRDS("Source_Classification_Code.rds")

# Technical Support Documentation for NEI 2011 available at
# http://www.epa.gov/ttn/chief/net/2011nei/2011_nei_tsdv1_draft2_june2014.pdf
# From the documentation, the column EI.Sector specifies the sector/source the emissions 
# data are mapped to.
# The following sectors are related to coal combustion
# Fuel Comb - Electric Generation - Coal
# Fuel Comb - Industrial Boilers, ICEs - Coal
# Fuel Comb - Comm/Institutional - Coal

# use sqldf package to join the data frames and filter
library(sqldf)
# The period is a reserved word, column names with period in them
# are replaced with an underscore, so EI.Sector transforms to EI_Sector
# Format the sum for better display dividing by 10^5
coalEmissions <- sqldf("select e.year, sum(e.Emissions) / 100000 tot_Emissions
                        from emissions e
                        inner join
                             srcclass s
                        on  e.SCC = s.SCC
                        where  s.EI_Sector like '%Comb%Coal'
                        group by e.year")


# plot the data
# Using qplot instead of building up plot sequentially
q <- qplot(factor(year), 
      tot_Emissions, 
      data = coalEmissions,
      geom = "bar",
      stat = "Identity",
      ylim(0, 7),
      xlab = "Year",
      ylab = expression("Total Emissions from Coal Combustion Sources "*(10^5 * "Tons") ),
      main = "Emissions from Coal Combustion Sources in the United States"
      ) + theme_bw()

# save to file
png("plot4.png", width = 480, height = 480)
print(q)
dev.off()


    
