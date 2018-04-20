#Push to MySQL
install.packages('RMySQL')
library(RMySQL)
mydb = dbConnect(MySQL(), user=‘***’, password=‘***’, dbname='nn', host='localhost')
dbListTables(mydb)

setwd("/Users/Kalhan/Desktop/Waterloo Data/Winter 2018/CS698/Neural Networks/Project/ml-100k-4")
getwd()

data <- read.csv("movie_similarity.csv",header=T)
dbWriteTable(mydb,"movie_similarity",data,overwrite=T)