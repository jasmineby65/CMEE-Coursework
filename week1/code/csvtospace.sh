#!/bin/bash

if [ -z "$1" ] # Check whether argument is filled 
then
    echo "ERROR: Input missing. Please provide a text file."
    exit
fi # Closing if #

filename=$(basename -- "$1") # Check the file type of input 
extension="${filename##*.}"

if [ "$extension" != "csv" ]
then 
    echo "ERROR: Wrong input. Please provide a csv file."
    exit
fi 

echo "Creating a space seperated version of $1..."
cat $1 | tr -s "," " " >> ../data/$(basename "$1" .csv).txt 
# () around 'basename' needs $ or it will think (basename) is part of the file name rather than command  
echo "Done!"
exit 