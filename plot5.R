##REQ: summarySCC_PM25.rds is in same folder as this file.
##EFF: plot how pm2.5 emission from motor vehicles has changed from 1999 to 2008
##	in baltimore city, and
##	output it as png file.

plot_title <- expression(paste("Plot of ", PM[2.5], 
	" Emission from Motor Vehicles from 1999 to 2008 in Baltimore City, MD"))
plot_filename <- "plot5.png"
baltimore_scc <- "24510"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$fips == baltimore_scc & NEI$type == "ON-ROAD", ]

	data <- sapply(split(NEI$Emissions, NEI$year), sum)
	png(plot_filename, width = 600, height = 600)
	plot(data, x = names(data), main = plot_title, pch = 16, xlab = "Year", 
		ylab = expression(paste(PM[2.5], " Emission (ton)")))
	dev.off()
} else {
	print(error)
}
