##DEPENDENCIES: ggplot2
##REQ: assume the data file is in the same folder as this file.
##EFF: 

library(ggplot2)

plot_title <- "Comparison of PM2.5 Emissions from Motor Vehicles from 1999 to 2008"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$type == "ON-ROAD", ]
	data <- subset(NEI, fips == "24510"| fips == "06037")
	
	data <- split(data, data$fips)
	data <- sapply(data, function(x) sapply(split(x$Emissions, x$year), sum))
	data <- as.data.frame(as.table(data))
	data$city <- factor(data$Var2, labels = c("Los Angeles County", "Baltimore"))

	g <- ggplot(data, aes(Var1, Freq)) + geom_point() + facet_grid(.~city) + 
		labs(x = "Year", y = "PM2.5 Emission (ton)", title = plot_title)
	ggsave("plot6.png", plot = g, width = 4, height = 2, scale = 2)

} else {
	print(error)
}
