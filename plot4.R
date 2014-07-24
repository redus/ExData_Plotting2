##REQ: assume the data file is in the same folder as this file.
##EFF: how have emissions from coal combustion-related sources changed from 1999–2008?

plot_title <- "Total PM2.5 Emission Related to Coal Combustsion in US between 1999 and 2008"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir() || "Source_Classification_Code.rds"){
	NEI <- readRDS("summarySCC_PM25.rds")
	SCC <- readRDS("Source_Classification_Code.rds")

	candidates <- SCC[grep("Coal", SCC$SCC.Level.Three), "SCC"]
	data <- subset(NEI, SCC %in% candidates)
	data <- sapply(split(data$Emissions, data$year), sum)
	png("plot4.png", width = 600, height = 600)
	plot(data, x = names(data), type = 'b', main = plot_title,
		xlab = "Year", ylab = "PM2.5 emission (tons)")
	dev.off()
} else {
	print(error)
}

