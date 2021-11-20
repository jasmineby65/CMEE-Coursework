"""
Print three lists containing the latin names, common names and mean body masses for each species in birds  
"""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

species_name = [i[0] for i in birds]
print("Latin names:\n",species_name)
common_name = [i[1] for i in birds]
print("Common names:\n",common_name)
mean_body_mass = [i[2] for i in birds]
print("Mean body mass:\n",mean_body_mass)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

species_name = []
common_name = []
mean_body_mass = []

for i in birds:
    species_name.append(i[0])
    common_name.append(i[1])
    mean_body_mass.append(i[2])

print("Latin names:\n",species_name)
print("Common names:\n",common_name) 
print("Mean body mass:\n",mean_body_mass)

# A nice example output is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 