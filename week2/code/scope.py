_a_global = 10 # a global variable i.e. outside a function

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable 

def a_function():
    _a_global = 5 # a local variable i.e. inside a function (a_function)
    # if the a local variable of the same name is made inside a function, 
    # it will overwrite the global variable
    # if a local variable is not made, the global variable will be used inside the function  

    if _a_global >= 5:
        _b_global = _a_global + 5 # also a local variable

    _a_local = 4

    print('Inside the function, the value of _a_global is ', _a_global)
    print('Inside the function, the value of _b_global is ', _b_global)
    print("Insdie the function, the value of _a_local is ", _a_local)

    return None # same as 'exit' in shell script 

a_function()

print('Outside the function, the value of _a_global is ', _a_global)
print('Outside the function, the value of _b_global is ', _b_global)
# print('Outside the function, the value of _a_local is ', _a_local)
# local function only exist inside the function so cannot be run outside the function


print('Using global function...')

_a_global=10

print('Outside the function, the value of _a_global is ', _a_global)

def a_function():
    global _a_global # this command allows local variable to be made available outside
    # i.e. convert it to a global variable 
    _a_global = 5
    _a_local = 4

    print('Inside the fucntion, the value of_a_global is ', _a_global)
    print('Inside the function, the value of _a_local is ', _a_local)

    return None

a_function()

print('Outside the function, the value of _a_global now is ', _a_global)


print('When the global function is used inside nested functions...')

def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global 
        _a_global = 20 # this changes the value of _a_global to 20 outside 
        # but NOT inside the function!
        # within a function, the original local is prioritised 

    print('Before calling a_function, value of _a_global is ', _a_global)

    _a_function2()

    print('After calling _a_function2, value of _a_global is ', _a_global)

    return None

a_function()

print('The value of _a_global in main workspace is ', _a_global)


print('In comparison...')

_a_global = 10

def a_function():

    def _a_function2():
        global _a_global # at this point, _a_global is already a global variable 
        _a_global = 20 # so changes will be reflected in both inside and outside variable 

    print('Before calling a_function, value of _a_global is ', _a_global)

    _a_function2()

    print('After calling _a_function2, value of _a_global is ', _a_global)

    return None

a_function()

print('The value of _a_global in main workspace is ', _a_global)