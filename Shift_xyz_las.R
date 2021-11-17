### Shift a point cloud (.las) in 3D space
### Requires las2las.exe from LASTools - location to be provided in ShellString variable
### Point cloud file name cannot have spaces

library(rstudioapi)

### Select the working directory
setwd(choose.dir(getwd(), caption = "Select folder"))

### Select file
fileName<-selectFile(caption = "Select File to Convert", label = "Select", path = getwd(), filter = "All Files (*.las)", existing = TRUE)
fileName<-basename(fileName)

### Set offset values (m)
x_offset<-0
y_offset<-0
z_offset<-0

# Parse file name string
vft<-strsplit(fileName,"[.]")[[1]]
fname<-vft[1]
ftype<-vft[2]
# Create output file name string
outFile<-paste0(fname,"_off.",ftype)
# Build string for shell and run
ShellString<-paste0("C:/lidar/las2las.exe -i ",fileName," -o ",outFile," -translate_xyz ",x_offset," ",y_offset," ",z_offset)
shell(ShellString)

