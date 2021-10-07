#!/bin/bash
#Author: Jasmine Yang zy1921@imperial.ac.uk
#Script: tabtocsv.sh
#Description: substitue the tabs in the files with commas 
#And save the output into a .csv files
#Arguments: 1 -> tab delimited files
#Date: Oct 2021

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit
