taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc


taxa_dic = {}

for i in taxa:
        if i[1] in taxa_dic: # "in" searches for key in dictionary 
                taxa_dic[i[1]].update([i[0]]) 
                # .update to append to sets
        else:
                taxa_dic[i[1]]=set([i[0]]) 
                # what goes into set has to be a list!
                # if not enclosed by [] to set it as list,
                # it will make a list of individual letters of the word

taxa_dic


