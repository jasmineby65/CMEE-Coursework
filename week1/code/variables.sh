#!/bin/bash

### Illustrates the use of variables 

# Special variables 

echo "This script was called with $# parameters"
echo "This script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"

# Assigned variables; Explicit declaration:
MyVar='some string'
echo 'The current value of the variable is:' $MyVar
echo 'Please enter a new string'
read MyVar # Allows new value for the variable to be entered at the terminal 
echo 'The current value of the variable is' $MyVar

if [ -z "$MyVar" ] # Check whether argument is filled
then
    echo "ERROR: Input missing. Please type in something."
    exit
fi # Closing if 

# Assigned variables; Reading multiple values from user input: 
echo 'Enter two numbers seperated by space(s)'
read a b 
echo 'You entered '$a' and '$b'. Their sum is:'

# Assigned variables; Command substitution 
mysum=`expr $a + $b` # 
echo $mysum     

if [[ -z "$a" || -z "$b" ]] # Check whether argument is filled
then
    echo "ERROR: Input missing. Please type in two integers seperated by space."
    exit
fi # Closing if 

if ! [[ "$a&$b" =~ "^[0-9]+$" ]] # Check whether argument is integer 
        then 
            echo "ERROR: Wrong input. Integers only."
fi
