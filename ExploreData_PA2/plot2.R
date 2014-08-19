##############
#
# File: plot2.R
# ExploratoryDataAnalysis  Programming Assignment 2
#
##############
#
# reading data
#
setwd("C:/Users/jb/Documents/R/ExploreData_PA2/")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
# compute sum over Emissions for each year in Baltimore
#
NEI_baltimore <- NEI[NEI$fips=="24510",]
SumEmissionsVersusYearBaltimore <- tapply(NEI_baltimore$Emissions,NEI_baltimore$year,sum)
#
#create figure
#
png("./plot2.png",width = 480, height = 480, units = "px")
Year <- c(1999,2002,2005,2008)
plot(Year,SumEmissionsVersusYearBaltimore,col="red",xaxp  = c(1999, 2008, 3),main="Total PM2.5 Emission Baltimore",xlab="Year",ylab="Sum Emissions [tons]")
dev.off()

