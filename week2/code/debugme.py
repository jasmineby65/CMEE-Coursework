def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except ZeroDivisionError: # Pre-defined error
            print(f"The result of dividing a number by zero is undefined")
        except: # Run this section if error arises in the try section instead of stopping code 
            print(f"This did't work; x = {x}; y = {y}")
        else:
            print(f"OK; x = {x}; y = {y}; z = {z};")
    return z

buggyfunc(20)