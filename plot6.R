##DEPENDENCIES: ggplot2
##REQ: summarySCC_PM25.rds is in same folder as this file.
##EFF: plot how pm2.5 emission from motor vehicles has changed from 1999 to 2008
##	in baltimore city and in los angeles county, and
##	output it as png file.

library(ggplot2)

plot_title <- expression(paste("Comparison of ", PM[2.5], 
	" Emission from Motor Vehicles from 1999 to 2008"))
plot_filename <- "plot6.png"
baltimore_scc <- "24510"
lac_scc <- "06037"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$type == "ON-ROAD", ]
	data <- subset(NEI, fips == baltimore_scc| fips == lac_scc)
	
	data <- split(data, data$fips)
	data <- sapply(data, function(x) sapply(split(x$Emissions, x$year), sum))
	data <- as.data.frame(as.table(data))
	data$city <- factor(data$Var2, labels = c("Los Angeles County, CA", 
		"Baltimore City, MD"))

	g <- ggplot(data, aes(Var1, Freq)) + geom_point() + facet_grid(.~city) + 
		labs(x = "Year", y = expression(paste(PM[2.5], " Emission (ton)")),
		title = plot_title)
	ggsave(plot_filename, plot = g, width = 4, height = 2, scale = 2)

} else {
	print(error)
}
