#!/bin/bash
# Author: Your name you.login@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitue the tabs in teh files with commas
# 
# Saves the output into a csv.file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

if [ -z "$1" ] # Check whether argument is filled 
then
    echo "ERROR: Input missing. Please provide a text file."
    exit
fi # Closing if 

echo "Creating a comma delimited version of $1..."
cat $1 | tr -s "\t" "," >> ../sandbox/$(basename "$1" .txt).csv 
# () around 'basename' needs $ or it will think (basename) is part of the file name rather than command  
echo "Done!"
exit 
