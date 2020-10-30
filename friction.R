library(raster)

dem <- raster(file.choose())
sr <- "+proj=utm +zone=12 +ellps=GRS80 +datum=NAD83 +units=m +no_defs" 
dem_proj <- projectRaster(dem, crs=sr) # DEM will need to be in a projected coordinate system with meters for units for this to work

slope_rads <- terrain(dem_proj, opt='slope', unit='radians', neighbors=8)

slope_dist <- 30/cos(slope_rads) # replace 30 with whatever the pixel resolution of the DEM is in meters
slope_sin <- sin(slope_rads)

fric_surf <- (slope_dist * (63.5) * slope_sin) + 1 # 63.5 was the average leg length in cm for SW pueblo populations calculated based on a bioarchaeological sample (intermembral index)

writeRaster(fric_surf, 'fric_surf.tif', overwrite=T)