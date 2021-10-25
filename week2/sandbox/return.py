def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)

my_list = [1,2,3]

print('before, my_list = ', my_list)

modify_list_1(my_list)

print('after, my_list =', my_list) # this still gives the ORIGINAL list i.e. 1,2,3
# changes are only saved within the function but is not applied outside!


print('Using return...')

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)
    return some_list # this alter some_list outside as output of the modification 

my_list = modify_list_2(my_list)

print('after, my_list = ', my_list)


print('To modify the orignial list...')

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) # an actual modification to the list 
    print('changed to ', some_list)

my_list = [1,2,3]

print('before, my_list = ', my_list)

modify_list_3(my_list)

print('after, my_list = ', my_list)

