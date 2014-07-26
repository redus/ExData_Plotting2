##REQ: summarySCC_PM25.rds is in same folder as this file.
##EFF: plot US's total pm2.5 emission between 1999 and 2008, and 
##	output it as png file.

plot_title <- expression(paste("Plot of ", PM[2.5], 
	" Emission from 1999 to 2008 in US"))
plot_filename <- "plot1.png"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	data <- sapply(split(NEI$Emissions, NEI$year), sum)
	png(plot_filename)
	plot(data, x = names(data), main = plot_title, pch = 16, xlab = "Year", 
		ylab = expression(paste(PM[2.5], " Emission (ton)")))
	dev.off()
} else {
	print(error)
}

