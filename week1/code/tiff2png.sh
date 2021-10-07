#!/bin/bash


for f in $1/*.tif;
    do
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif).png";
    done
