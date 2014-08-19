##############
#
# File: plot3.R
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
# extract data for Baltimore
#
NEI_baltimore <- NEI[NEI$fips=="24510",]
#
#
# aggregate the Emissions according to year and type and sum values up
#
NEI_baltimore_agg <- aggregate(NEI_baltimore$Emissions,list(year=NEI_baltimore$year,type=NEI_baltimore$type),sum) 
#
#create figure using facets for type
#
png("./plot3.png",width = 640, height = 640, units = "px")
pic <- ggplot(NEI_baltimore_agg, aes(year,x))+
facet_grid(. ~ type)+
geom_line()+
labs(x="year") +
labs(y="Total Emissions Baltimore [tons]") +
theme_bw( base_size = 10)+
scale_x_continuous(breaks=seq(1999, 2008, 3))
print(pic)
dev.off()

