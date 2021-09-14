### Batch script for SOR (Statistical Outlier Removal) filtering of LiDAR flight lines (NextCore) using lidR ###
### Applies SOR filter to each flightline las in working directory and moves these to new folder ###

### Libraries
library(lidR)
library(filesstrings)

### Set the working directory ###
key_folder = ("C:/lidar/TLF/Jun-22/Exports/autoroll")
setwd(key_folder)

### Get list of files in directory (change to .laz if needed)
flist<-list.files(pattern="\\.las")

### SOR parameters ###
mean_k<-10 # Specify the number of neighbors used to compute the 'distance to neighbors' for each point
multiplier<-2  # Standard deviation multiplier

for (i in 1:length(flist)){
  # read in las file and set projection
  las <- readLAS(flist[i])
  las <- classify_noise(las,sor(mean_k,multiplier))
  las_denoise <- filter_poi(las, Classification != LASNOISE)
  # Parse file name string
  fileName=flist[i]
  vft<-strsplit(fileName,"[.]")[[1]]
  fname<-vft[1]
  ftype<-vft[2]
  # Create output file name string
  outFile<-paste0(fname,"_SOR.las")
  writeLAS(las_denoise, outFile)
}

### Move filtered files to new folder
dir.create(file.path(key_folder,"SOR_filtered"))
path=getwd()
new_loc<-paste0(path,"/SOR_filtered")
flist2<-list.files(pattern="\\_SOR.las")
file.move(flist2,new_loc,overwrite=TRUE)
