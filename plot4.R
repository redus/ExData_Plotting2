##REQ: summarySCC_PM25.rds and Source_Classification_Code.rds are in same folder
##	as this file.
##EFF: plot how pm2.5 emission from coal combustion-related sources has changed 
##	from 1999 to 2008 in US, and
##	output it as png file.

plot_title <- expression(paste("Plot of Coal Combustion Related ", PM[2.5], 
	" Emission from 1999 to 2008 in US"))
plot_filename <- "plot4.png"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir() || "Source_Classification_Code.rds"){
	NEI <- readRDS("summarySCC_PM25.rds")
	SCC <- readRDS("Source_Classification_Code.rds")

	# subset coal realted sources by finding all SCC rows with "Coal"
	# in the SCC.Level.Three column. (Leaves out Charcoal)
	candidates <- SCC[grep("Coal", SCC$SCC.Level.Three), "SCC"]
	data <- subset(NEI, SCC %in% candidates)
	data <- sapply(split(data$Emissions, data$year), sum)
	png(plot_filename, width = 600, height = 600)
	plot(data, x = names(data), main = plot_title, pch = 16, xlab = "Year", 
		ylab = expression(paste(PM[2.5], " Emission (ton)")))
	dev.off()
} else {
	print(error)
}

