###Subset to bounding box###
### Libraries ###
library(sp)
library(rgeos)
library(rgdal)
library(raster)
library(lidR)

### Create bounding box polygon
bb<-matrix(c(267010,8595820,267040,8595850),nrow=2)
rownames(bb)<-c("x","y")
colnames(bb)<-c('min','max')
bb_poly<-as(extent(as.vector(t(bb))),"SpatialPolygons")

#project polygon
proj.crs<-CRS("+proj=utm +zone=44 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs") #WGS84z44ns
proj4string(bb_poly)<-proj.crs
plot(bb_poly)


#Write bounding box polygon to shapefile
bb_poly<-SpatialPolygonsDataFrame(bb_poly,data.frame(area=area(bb_poly)))
writeOGR(bb_poly,"C:/lidar","bb_poly1",driver="ESRI Shapefile",overwrite_layer=TRUE)

# Load LiDAR
las<-readLAS("C:/lidar/c20.las")

# Clip to bounding box polygon
las<-lasclip(las,bb_poly)