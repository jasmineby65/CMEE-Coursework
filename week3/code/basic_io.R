# A simple script to illustrate R input-output

MyData <- read.csv("../data/trees.csv", header = T)
# import with headers

write.csv(MyData, "../results/MyData.csv")
# write it out as a new file

write.table(MyData[1,], file="../results/MyData.csv", append=T)
# append the first row of MyData (header) to the new file

write.csv(MyData, "../results/MyData.csv", row.names=T)
# Overwrite the new file including number of rows as a column

write.table(MyData, "../results/MyData.csv", col.names=F)
# Overwrite the new file without column names i.e. header