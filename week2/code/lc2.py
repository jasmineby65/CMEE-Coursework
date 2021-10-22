# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

heavy_rain = [i for i in rainfall if i[1]>100.0]
print("Months and rainfall values when the amount of rain was greater than 100mm:\n",heavy_rain)
# Remember to specify what output you want before the "for" loop!



# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

dry_month = [i[0] for i in rainfall if i[1]<50.0]
print("Months when the amount of rain was less than 50mm:\n",dry_month)


# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

heavy_rain = []
dry_month = []

for i in rainfall:
    if i[1]>100.0:
        heavy_rain.append(i)
    if i[1]<50.0:
        dry_month.append(i[0])

print("Months and rainfall values when the amount of rain was greater than 100mm:\n",heavy_rain)
print("Months when the amount of rain was less than 50mm:\n",dry_month)


# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

