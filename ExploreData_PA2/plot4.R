##############
#
# File: plot4.R
# ExploratoryDataAnalysis  Programming Assignment 2
#
##############
#
# reading data
#
library(ggplot2)
setwd("C:/Users/jb/Documents/R/ExploreData_PA2/")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
# Find SCC-codes related to coal combustion.
# We search for the pattern "Fuel Comb.*Coal" in the EI.Sector column of data-frame SCC
#
Ids      <- grep("Fuel Comb.*Coal",SCC$EI.Sector)
SCC_coal <- as.character(SCC[Ids,]$SCC)
#
# subsetting of NEI-data according to SCC_coal
#
NEI_coal <-  NEI[NEI$SCC %in% SCC_coal, ]
#
#
# aggregate the Emissions according to year and sum values up
#
NEI_coal_agg <- aggregate(NEI_coal$Emissions,list(year=NEI_coal$year),sum) 
#
#create figure
#
png("./plot4.png",width = 480, height = 480, units = "px")
# pic <- ggplot(NEI_coal_agg, aes(year,x))+
# geom_line()+
# labs(x="year") +
# labs(y="Total Emissions USA Coal Sources [tons]") +
# theme_bw( base_size = 10)+
# scale_x_continuous(breaks=seq(1999, 2008, 3))
pic<-ggplot(NEI_coal_agg, aes(factor(year), x)) + geom_bar(stat="identity") +
    xlab("year") + ylab("Total Emissions USA Coal Sources [tons]") 
print(pic)
dev.off()

