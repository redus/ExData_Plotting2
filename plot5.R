##REQ: assume the data file is in the same folder as this file.
##EFF: 

plot_title <- "Plot of PM2.5 Emission from Mobile Sources from 1999 to 2008 in Baltimore City, US"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$fips == 24510 & NEI$type == "ON-ROAD", ]

	data <- sapply(split(NEI$Emissions, NEI$year), sum)
	png("plot5.png", width = 600, height = 600)
	plot(data, x = names(data), type = 'b', main = plot_title,
		xlab = "Year", ylab = "PM2.5 emission (tons)")
	dev.off()
} else {
	print(error)
}
