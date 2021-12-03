import pandas as pd
#import scipy as sc 
#import matplotlib.pylab as pl 
#import seaborn as sns 

# Loading data
data = pd.read_csv("../data/LogisticGrowthData.csv")

print("Loaded {} columns.".format(len(data.columns.values)))
data.columns.values

data.head()
len(data)

# Checking units
print(data.PopBio_units.unique())
print(data.Time_units.unique())



# Removing rows that contain negative time and population size 
neg_time = data[data.Time < 0].index
sum(data.Time < 0)
len(neg_time)
data.drop(neg_time, inplace=True)

neg_pop = data[data.PopBio < 0].index
sum(data.PopBio < 0)
len(neg_pop)
data.drop(neg_pop, inplace=True)

len(data)
data.head()

# Adding unique ID to each combination of species-temp-medium-citation
data.insert(0, "ID_character", 
data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)
data.head()
data.ID_character


# Assigning each unique ID character an unique ID no
data.insert(0, "ID", pd.Categorical(data["ID_character"]).codes)
# pd.Categorical converts a column to categorial values
# which means each unique category has a number associated with it
# .code shows the number associated with it 

#!!assignment of value by data[row,column] = x doesn't work becuase pandas is not strictly a dataframe!!
# So assigning values by iteration with for loop won't work - should use R for that!

data = data.sort_values(by=["ID"])
data.head()

# Exporting as new csv
data.to_csv("../data/Data.csv", index=False)

print("Data wragling done!")