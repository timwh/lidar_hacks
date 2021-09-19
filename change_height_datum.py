#!/usr/bin/env python
# Changes height datum (eg ellipsoid to AHD) of las files using PDAL and custom geoid grid.
# For example, the AUSGeoid09 product released by Geoscience Australia
# provides the offset between the ellipsoid (GRS80 realised as GDA94) and AHD.
# This script will batch for all las files in a particular folder.

import glob
import os
from os import path
from os.path import splitext as spext
import shutil
# Set the working directory
os.chdir("C:\\lidar\\TLF\\Aug-09\\Exports2\\SOR_filtered\\projected")

# Set global variables as strings
epsg_code = '32753'  # wgs84 z53s
ahd_code = '5711'  # EPSG for AHD
geoid_grid = 'C:/lidar/AUSGeoid09_V1_01.gtx'  # location of the grid for conversion
# Other grids for conversion can be found here: https://github.com/OSGeo/proj-datumgrid

# Loop through files and reproject to AHD
for filename in glob.iglob('**p.las', recursive=True):
    if os.path.isfile(filename):  # filter dirs
        print("File to reproject: ", filename)
        # parse file name for outputs
        parsed_fname = spext(filename)
        filename2 = parsed_fname[0]
        fileType = parsed_fname[1]
        # create reprojected output filename string
        las_out = ''.join([filename2, '_ahd', fileType])
        # build shell string
        shellString = ''.join(
            ['pdal translate -i ', filename, ' -o ', las_out, ' reprojection --filters.reprojection.in_srs="EPSG:',
             epsg_code, '" --filters.reprojection.out_srs="+init=EPSG:', epsg_code, ' +geoidgrids=', geoid_grid,
             '" --writers.las.a_srs="EPSG:', epsg_code, '+', ahd_code, '" -v 4'])
        print("Running: ", shellString)
        # run pdal using shell string
        os.system(shellString)
