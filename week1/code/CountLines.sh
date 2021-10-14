#!/bin/bash

if [ -z "$1" ] # Check whether argument is filled 
then
    echo "ERROR: Input missing. Please provide a text file."
    exit
fi # Closing if 

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
exit