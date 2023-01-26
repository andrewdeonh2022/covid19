library(osmdata)
library(ggplot2)

# Adapted from: https://jcoliver.github.io/learn-r/017-open-street-map.html

# A 2x2 matrix
#tucson_bb <- matrix(data = c(-111.0, -110.7, 31.0, 32.3),
#                    nrow = 2,
#                    byrow = TRUE)

# Update column and row names
#colnames(tucson_bb) <- c("min", "max")
#rownames(tucson_bb) <- c("x", "y")

# Print the matrix to the console
#cat(tucson_bb)

# using state names tends to cause the OSM server to time out (long queries)
placelist <- c("Boston", "Hawaii")

for (x in 1:length(placelist)) {

	tplace <- placelist[x]
	cat(paste("Generating plot for ", tplace, sep=""))
	geodata <- getbb(place_name = tplace) %>%
		opq() %>%
		add_osm_feature(key = "highway", 
			value = c("motorway", "primary", "secondary")) %>%
		osmdata_sf()

	geoplot <- ggplot() +
		geom_sf(data = geodata$osm_lines,
			inherit.aes = FALSE,
			color = "black",
			size = 0.2)

	ofile <- paste(tplace, ".png", sep="")
	ggsave(ofile, geoplot)

}
