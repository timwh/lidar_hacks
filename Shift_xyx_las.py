#!/usr/bin/env python
import os
import easygui as gu
from os.path import splitext as spext
from os.path import basename

# Set working directory
root_dir = gu.diropenbox("Select folder location", "Choose folder", "C:\\")
os.chdir(root_dir)

# Select location of executables
filename = gu.fileopenbox("Locate the las file", "Find las", default=os.path.join(root_dir, "*.las"))
print(filename)
filename = basename(filename)
print(filename)

# Set offset values (m)
# Use easygui to input xyz offsets
msg = "Enter x, y and z offsets"
title = "Offsets in metres"
fieldNames = ["X offset", "Y offset", "Z offset"]
fieldValues = gu.multenterbox(msg, title, fieldNames)
if fieldValues is None:
    sys.exit(0)

# Make sure that none of the fields were left blank
while 1:
    errmsg = ""
    for i, name in enumerate(fieldNames):
        if fieldValues[i].strip() == "":
            errmsg += "{} is a required field.\n\n".format(name)
    if errmsg == "":
        break  # no problems found
    fieldValues = gu.multenterbox(errmsg, title, fieldNames, fieldValues)
    if fieldValues is None:
        break
print("Input was:{}".format(fieldValues))

### Set offset variables
x_offset = fieldValues[0]
y_offset = fieldValues[1]
z_offset = fieldValues[2]

# Parse file name for outputs
parsed_fname = spext(filename)
filename2 = parsed_fname[0]
fileType = parsed_fname[1]

# Create clipped output filename string
las_out = ''.join([filename2, '_off', fileType])

# Build shell string
shellString = ''.join(["C:/lidar/las2las.exe -i ", filename, " -o ", las_out, " -translate_xyz ", x_offset, " ", y_offset, " ", z_offset])
print(shellString)
os.system(shellString)
