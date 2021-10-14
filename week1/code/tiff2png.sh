#!/bin/bash

if [ -z "$1" ] # Check whether argument is filled 
then
    echo "ERROR: Input missing. Please provide a folder with tiff image."
    exit
fi # Closing if 

for f in $1/*.tif;
    do
        echo "Converting $f";
        convert "$f" "../data/$(basename "$f" .tif).png";
    done

