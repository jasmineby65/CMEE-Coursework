#!/bin/bash 
pdflatex $1
bibtex $(basename "$1" .tex)
pdflatex $1
pdflatex $1
evince $(basename "$1" .tex).pdf

##Removing files made during conversion
rm *.aux
rm *.log
rm *.bbl
rm *.blg

