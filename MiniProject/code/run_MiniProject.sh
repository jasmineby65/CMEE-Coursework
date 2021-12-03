#!/bin/sh
# Author: Jasmine (Zhengxin) Yang zy1921@ic.ac.uk
# Script: run_MiniProject
# Desc: run all the codes for miniproject and compile a PDF report
# Date: December 2021

ipython3 Data_wrangling.py  

Rscript Modelling.R
Rscript Comparison.R

pdflatex Report.tex
bibtex Report.aux
pdflatex Report.tex
pdflatex Report.tex

#exit