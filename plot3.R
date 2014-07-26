##DEPENDENCIES: ggplot2
##REQ: summarySCC_PM25.rds is in same folder as this file.
##EFF: plot baltimore city's pm2.5 emission between 1999 and 2008 divided by the
##	source of the emission, and 
##	output it as png file.

library(ggplot2)

plot_title <- expression(paste("Plot of ", PM[2.5], 
	" Emission from 1999 to 2008 in Baltimore City, MD by Source"))
plot_filename <- "plot3.png"
baltimore_scc <- "24510"
error <- "Data file not found. If it's inside another folder, \
please move it to where this file is located."

if ("summarySCC_PM25.rds" %in% dir()){
	NEI <- readRDS("summarySCC_PM25.rds")
	NEI <- NEI[NEI$fips == baltimore_scc, ]
	data <- split(NEI, NEI$type)
	data <- sapply(data, function(x) sapply(split(x$Emissions, x$year), sum))
	data <- as.data.frame(as.table(data))

	g <- ggplot(data, aes(Var1, Freq)) + geom_point() + facet_grid(.~Var2) + 
		labs(x = "Year", y = expression(paste(PM[2.5], " Emission (ton)")),
		title = plot_title)
	ggsave(plot_filename, plot = g, width = 4, height = 2, scale = 2)

} else {
	print(error)
}

