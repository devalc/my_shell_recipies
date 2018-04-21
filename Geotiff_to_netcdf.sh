#!/bin/bash

############################################################################################################
#Created on Fri Oct 28 12:40:21 2016
#@author: chinmay deval
#This script loops over al Tif files and writes them to a single netcdf file
# Requires cdo and nco libraries installed on the system
############################################################################################################

#echo "List all files"
ls -al

#set all values less than or equal to 0 to nodata or missing value
for i in *.tif
do
gdal_calc.py -A $i --calc="A*(A>0)" --NoDataValue=-999 --outfile=set0$i
done

echo "looping thru all files with extention .tif"
for i in `find . -name "set0*.tif" -type f`; do
    echo "finding datevalue $i in filename"
    year=$(echo $i | cut -d"_" -f4 | cut -d"." -f1); echo $year
    month=$(echo $i | cut -d"_" -f4 | cut -d"." -f2); echo $month
    day=$(echo $i | cut -d"_" -f4 | cut -d"." -f3); echo $day 	
    echo "translating tif to netCDF"
    gdal_translate -of netCDF set0ETensemble_mm_month-1_$year.$month.$day.tif set0ETensemble_mm_month-1_$year.$month.$day.nc
    rm set0*.tif
    echo "setting reference time to the netCDF"
    cdo setreftime,2001-01-01,00:00:00 set0ETensemble_mm_month-1_$year.$month.$day.nc srt_ETensemble_mm_month-1_$year.$month.$day.nc
    rm set0*.nc
    echo "setting date to the netCDF"
    cdo setdate,$year-$month-$day srt_ETensemble_mm_month-1_$year.$month.$day.nc sd_ETensemble_mm_month-1_$year.$month.$day.nc
    rm srt_*.nc     
done

# merge al individual netcdf files into one
cdo mergetime sd_*.nc ETensemble_mm-month-1_2003_2007.nc
# rename the variable in the merged netcdf file
ncrename -v Band1,Evapotranspiration ETensemble_mm-month-1_2003_2007.nc         
