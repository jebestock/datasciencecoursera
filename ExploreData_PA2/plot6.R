##############
#
# File: plot6.R
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
# Find all rows of SCC where we find the string "ehicle" in any column.
#
collist <- names(SCC) # list of all columns
sel <- apply(SCC[,collist],1,function(row) length(grep("ehicle",row))>0)
a<-1:length(sel)
Ids_big <- a[sel]
#
# more appropriate might be to search for the string "vehicle" or Vehicle" 
# in the SCC-Level.Two column of data-frame SCC
#
Ids      <- grep("[vV]ehicle",SCC$SCC.Level.Two)
SCC_veh  <- as.character(SCC[Ids,]$SCC)
#
# Compute the difference set between Ids_big and Ids.
#
myset <- setdiff(Ids_big, Ids)
# The 2 index sets differ by 43 rows. After inspecting the rows I decided to
# disregard Ids_big for plotting since Ids_big contains things like:
# Vehicle Filling Gas tanks, vehicles used for iron or cotton production,...
# I think the latter things are not considered as "normal" motor vehicles.
#
# subsetting of NEI-data according to SCC_veh and further subsetting to 
# Baltimore or Los Angeles
#
NEI_veh    <-  NEI[NEI$SCC %in% SCC_veh, ]
NEI_veh_bl <-  NEI_veh[NEI_veh$fips=="24510"|NEI_veh$fips=="06037", ]
#
#
# aggregate the Emissions according to year and fips and sum values up
#
NEI_veh_bl_agg <- aggregate(NEI_veh_bl$Emissions,list(year=NEI_veh_bl$year,location=NEI_veh_bl$fips),sum) 
#
# make location a factor variable and change level name for more descriptive plotting afterwards
#
NEI_veh_bl_agg$location <- factor(NEI_veh_bl_agg$location)
levels(NEI_veh_bl_agg$location) <- c("LA","BA")
#
# compute for each year the relative difference 100*emis((year,city)-total(city))/total(city)
#
#
#create figure
#
png("./plot6.png",width = 640, height = 640, units = "px")
pic <- ggplot(NEI_veh_bl_agg, aes(factor(year),x,fill=location))+
geom_bar(stat="identity")+
facet_grid(location ~ ., scales="free")+
labs(x="year") +
labs(y="Total Emissions for Vehicle Sources [tons]") +
theme_bw( base_size = 10)
print(pic)
dev.off()

