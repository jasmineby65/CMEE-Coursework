#!/usr/bin/env python3

# this part (Docstring) can be viewed with ?boilerplate
""" Description of this program or application.
You can use several lines """ 

# this part can alo be viewed with ?boilerplate
# Needs TWO underscore to indicate its a special variable
__appname__ = '[application name here]'
__author__ = 'Your Name (your@email.address)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


## importing module
import sys #SYStem-specific parameters and functions
# allows access to interact with the interpreter i.e. operating system
sys.exit("I am exisiting right now!")


## constants


## functions
def main(argv):
    # argv (ARGument Variable) is a variable that holds the arugments entered at the terminal when the script is run 
    # so the input here can be anything i.e. not a list 
    """ Main entry point of the program """ 
    # Docstring can be inserted anywhere in the script 
    print('This is a boilerplate')
    return 0
    # 0 in bash means code has run successfullly  
    # so return 0 is needed to tell bash that the code in PYTHON has run successfully 

if __name__ == "__main__": 
    # name has TWO underscores, indicating its a 'internal' varaible
    # when a program is run, it is automatically set as __name__ =="__main___"
    # so there is not much point in this line if we are just running boilerplate
    # BUT when you import boilerplate as module into other script, 
    # e.g. `import boilerplate as bp` in new script  
    # __name__=='boilerplate' for the imported boilerplate and __name__=="__main__" for the script
    # so having this "if" will prevent boilerplate from running automatically when the script is run
    # controlled running of boilerplate can be achieved by writing `bp.main()`` in the script   
    # good explanation at: https://www.freecodecamp.org/news/whats-in-a-python-s-name-506262fe61e8/
    """ Makes sure the "main" function is called from command line """
    status = main(sys.argv)
    # set the output of main() as status i.e. 0 from `return 0`
    sys.exit(status)
    # sys.exit() allows exit from Python
    # status = 0 so sys.exit(0) in this case, which tells bash the PYTHON code was run successfully 
     


