#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3"]] # Check whether argument is filled 
then
    echo "ERROR: Input missing. Please provide three text files."
    exit
fi # Closing if 

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3