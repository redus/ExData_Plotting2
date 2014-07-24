##REQ: assume the data file is in the same folder as this file.
##EFF: 

plot_title <- "Plot of Total PM2.5 Emission between 1999 and 2008 in Baltimore City, US"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$fips == 24510, ]
	data <- sapply(split(NEI$Emissions, NEI$year), sum)
	png("plot2.png")
	plot(data, x = names(data), main = plot_title,
		xlab = "Year", ylab = "PM2.5 emission (tons)")
	dev.off()
} else {
	print(error)
}

