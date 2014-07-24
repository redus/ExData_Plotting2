##REQ: assume the data file is in the same folder as this file.
##EFF: how have emissions from coal combustion-related sources changed from 1999–2008?

plot_title <- "how have emissions from coal combustion-related sources changed from 1999–2008?"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir() || "Source_Classification_Code.rds"){
	NEI <- readRDS("summarySCC_PM25.rds")
	SCC <- readRDS("Source_Classification_Code.rds")

	candidates <- SCC[grep("Coal", SCC$SCC.Level.Three), "SCC"]
	png("plot1.png")
	plot(data, x = names(data), main = plot_title,
		xlab = "Year", ylab = "PM2.5 emission (tons)")
	dev.off()
} else {
	print(error)
}

