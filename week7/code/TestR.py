## R can be run from python using subprocess
""" Running R from python using subprocess """ 

import subprocess

subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()
# --verbose will show what R is actually doing
# ">" is used to assign the output to assign the output to files
# "2>" assigns the second output, which is content of --verbose in this case

subprocess.Popen("Rscript --verbose NonExistScript.R > ../results/outputFile.Rout 2> ../results/errorFile.Rout", shell=True).wait()
# Since the R script don't exist, the stored output it the error message 