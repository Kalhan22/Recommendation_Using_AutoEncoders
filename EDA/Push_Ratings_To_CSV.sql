#Push USing Code
SELECT userID, itemID, rating
FROM nn.ratings
INTO OUTFILE '/Users/Kalhan/Desktop/Waterloo Data/Wainter 2018/Neural Networks/Project/RAC/UserData/ratings_python.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


#If the above does not work
#Run the below query
#Using MySQL Interface, Export this data manually into ratings_python.csv
SELECT userID, itemID, rating
FROM nn.ratings;