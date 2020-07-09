### Merge multiple LIDAR flight lines using LasTools
### Requires LasMerge.exe to be in working directory

### Set working directory
setwd("C:/lidar")

### Select file type
FileType<-"las" # Are input files las or laz?

### Select output file name
MergeFileName<-"Output_merge"

#Create command string and run in shell
ShellString<-paste("lasmerge -i *.",FileType," -o ",MergeFileName,".",FileType,sep="")
shell(ShellString)
