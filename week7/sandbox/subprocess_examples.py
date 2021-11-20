## Building workflows ##
# Python can be used to build workflow that involves multiple languages e.g. R, LaTeX

import subprocess

# Popen() is used to run command in bash terminal through subprocesses
# This line creates object "p" which can can have its output and other info extracted
# Commands are given as list of strings to prevent symbols being interpreted as commands e.g. '
p = subprocess.Popen(["echo", "I'm taking' to you, bash!"], \
stdout = subprocess.PIPE, stderr=subprocess.PIPE)

# subprocess.PIPE creates a connection to the output of the command
# stdout and stderr are both given as binary format (bytes)
# stout is the output of the command
# sterror is the error from command 

stdout, stderr = p.communicate() # Reads info of stdout and stderr
stderr # empty since there was no error
stdout 

# Since the output is in bytes, it needs to be decoded 
print(stdout.decode())
# Or universal_newlines=True can be used to encode the output as text 
# But this will add \n at the line ending 
p = subprocess.Popen(["echo", "I'm taking' to you, bash!"], \
stdout = subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)

# Command to print list of code directory 
p = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()

# Calling python from the bash terminal 
p = subprocess.Popen(["python3", "../../week2/code/boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE) 
stdout, stderr = p.communicate()
print(stdout.decode())

# Calling pdflatex (used to convert tex to pdf) from bash 
subprocess.os.system("pdflatex ../sandbox/FirstExample.tex")
# os.system is the equivelant of:
subproycess.Popen("pdflatex ../sandbox/FirstExample.tex", shell=True).wait()
# shell=True means to run the command in shell, basically allowing command arguments to be written as single string
# But the fact that its run from shell makes it dangerous if running untrusted data 
# wait() will close the program after command processed 
subprocess.Popen(["pdflatex", "../sandbox/FirstExample.tex"]).wait()

# subprocess.os can be used to make the code OS independent i.e. work in Linux, Windows and Mac
# Making or manipulating a directory paths
path = subprocess.os.path.join("directory", "subdirectory", "file")
path # Useful when needing to call multile times 