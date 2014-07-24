##DEPENDENCIES: ggplot2
##REQ: assume the data file is in the same folder as this file.
##EFF: 

library(ggplot2)

plot_title <- "Plot of Total PM2.5 Emission between 1999 and 2008 in Baltimore City, US"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$fips == 24510, ]
	data <- split(NEI, NEI$type)
	data <- sapply(data, function(x) sapply(split(x$Emissions, x$year), sum))
	data <- as.data.frame(as.table(data))

	g <- ggplot(data, aes(Var1, Freq)) + geom_point() + facet_grid(.~Var2) + 
		labs(x = "Year", y = "PM2.5 Emission (ton)", title =
		"Total PM2.5 Emission between 1999 and 2008 in Baltimore, US by Source")
	ggsave("plot3.png", plot = g, width = 4, height = 2, scale = 2)

} else {
	print(error)
}

