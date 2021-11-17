# py_and_r_lidar_hacks
This repository contains a bunch of R and Python scripts for manipulating LiDAR data.
1. merge_las.R is a script that will merge multiple las/laz files using the lasmerge.exe from LasTools.
2. bounding_box.R is a script that allows you to create a rectangular polygon and clip a las object to it.
3. Batch_fltline_SOR_filter.R is a batch script to apply an SOR filter (from the lidR package) to each las file in a folder.
4. change_height_datum.py is a batch script for changing the height datum of las files in a folder.
5. Shift_xyz_las.R is an R script for applying spatial offsets (shifting) a point cloud. Uses las2las.exe from LasTools.
6. Shift_xyz_las.py is a Python script for applying spatial offsets (shifting) a point cloud. Uses las2las.exe from LasTools.
