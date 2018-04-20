use nn;


CREATE FUNCTION SPLIT_STR(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');

#Updating Data based on the most recent data on Movie Lens
drop table nn.temp_movies;
create table nn.temp_movies as 
select b.itemID, a.title, a.genre from dwh.dim_movies_raw as a join nn.movies as b on (a.title = b.title);


drop table nn.temporary_item_matrix ;
create table nn.temporary_item_matrix as (
select 
distinct
itemID,
title,
case when genre like '%Action%' then 1 else 0 end as 'Action',
case when genre like '%Adventure%' then 1 else 0 end as 'Adventure',
case when genre like '%Animation%' then 1 else 0 end as 'Animation',
case when genre like '%Comedy%' then 1 else 0 end as 'Comedy',
case when genre like '%Crime%' then 1 else 0 end as 'Crime',
case when genre like '%Documentary%' then 1 else 0 end as 'Documentary',
case when genre like '%Drama%' then 1 else 0 end as 'Drama',
case when genre like '%Fantasy%' then 1 else 0 end as 'Fantasy',
case when genre like '%Film-Noir%' then 1 else 0 end as 'Film_Noir',
case when genre like '%Horror%' then 1 else 0 end as 'Horror',
case when genre like '%Musical%' then 1 else 0 end as 'Musical',
case when genre like '%Mystery%' then 1 else 0 end as 'Mystery',
case when genre like '%Romance%' then 1 else 0 end as 'Romance',
case when genre like '%Sci-Fi%' then 1 else 0 end as 'Sci_Fi',
case when genre like '%Thriller%' then 1 else 0 end as 'Thriller',
case when genre like '%War%' then 1 else 0 end as 'War',
case when genre like '%Western%' then 1 else 0 end as 'Western',
case when genre like '%(no genres listed)%' then 1 else 0 end as 'No_Genre'
from nn.temp_movies
)
;



##Temporary movie_data table
drop table nn.movie_data;
create table nn.movie_data as (
select 
itemID,
title,
COALESCE(SPLIT_STR(genre,'|',1)) as genre_1, 
COALESCE(SPLIT_STR(genre,'|',2)) as genre_2,
COALESCE(SPLIT_STR(genre,'|',3)) as genre_3,
COALESCE(SPLIT_STR(genre,'|',4)) as genre_4,
COALESCE(SPLIT_STR(genre,'|',5)) as genre_5,
COALESCE(SPLIT_STR(genre,'|',6)) as genre_6,
COALESCE(SPLIT_STR(genre,'|',7)) as genre_7,
COALESCE(SPLIT_STR(genre,'|',8)) as genre_8,
COALESCE(SPLIT_STR(genre,'|',9)) as genre_9,
COALESCE(SPLIT_STR(genre,'|',10)) as genre_10
from nn.temp_movies
);

##Temporary table for finding distinct genre
drop table nn.distinct_genre ;
create table nn.distinct_genre as (
select distinct genre as b from (
select distinct REPLACE(TRIM(genre_1),'\r','') as genre from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_2),'\r','') as genre from nn.movie_data
union
select distinct REPLACE(TRIM(genre_3),'\r','') as genre from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_4),'\r','') as genre from nn.movie_data
union
select distinct REPLACE(TRIM(genre_5),'\r','') as genre from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_6),'\r','') as genre from nn.movie_data
union
select distinct REPLACE(TRIM(genre_7),'\r','') as genre  from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_8),'\r','') as genre from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_9),'\r','') as genre from nn.movie_data
union 
select distinct REPLACE(TRIM(genre_10),'\r','')as genre from nn.movie_data
) as x where genre is not null and genre <>  ''
) 
;


drop table nn.dim_movies_raw_2;
create table nn.dim_movies_raw_2 as (
select * from nn.movie_data
);


##Intermeditary querry
select itemID,title,'Action' as genre from nn.dim_movies_raw_2  where (genre_1 like '%Action%' or genre_2 = '%Action%' or genre_3 = '%Action%' or genre_4 = '%Action%' or genre_5 = '%Action%' or genre_6 = '%Action%' or genre_7 = '%Action%' or genre_8 = '%Action%' or genre_9 = '%Action%' or genre_10 = '%Action%')
union
select itemID,title,'Adventure' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Adventure%' or genre_2 = '%Adventure%' or genre_3 = '%Adventure%' or genre_4 = '%Adventure%' or genre_5 = '%Adventure%' or genre_6 = '%Adventure%' or genre_7 = '%Adventure%' or genre_8 = '%Adventure%' or genre_9 = '%Adventure%' or genre_10 = '%Adventure%')  
union
select itemID,title,'Animation' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Animation%' or genre_2 = '%Animation%' or genre_3 = '%Animation%' or genre_4 = '%Animation%' or genre_5 = '%Animation%' or genre_6 = '%Animation%' or genre_7 = '%Animation%' or genre_8 = '%Animation%' or genre_9 = '%Animation%' or genre_10 = '%Animation%')  
union
select itemID,title,'Childrens' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Childrens%' or genre_2 = '%Childrens%' or genre_3 = '%Childrens%' or genre_4 = '%Childrens%' or genre_5 = '%Childrens%' or genre_6 = '%Childrens%'or genre_7 = '%Childrens%' or genre_8 = '%Childrens%' or genre_9 = '%Childrens%' or genre_10 = '%Childrens%')  
union
select itemID,title,'Comedy' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Comedy%' or genre_2 = '%Comedy%' or genre_3 = '%Comedy%' or genre_4 = '%Comedy%' or genre_5 = '%Comedy%' or genre_6 = '%Comedy%' or genre_7 = '%Comedy%' or genre_8 = '%Comedy%' or genre_9 = '%Comedy%' or genre_10 = '%Comedy%')  
union
select itemID,title,'Crime' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Crime%' or genre_2 = '%Crime%' or genre_3 = '%Crime%' or genre_4 = '%Crime%' or genre_5 = '%Crime%' or genre_6 = '%Crime%' or genre_7 = '%Crime%' or genre_8 = '%Crime%' or genre_9 = '%Crime%' or genre_10 = '%Crime%')  
union
select itemID,title,'Documentary' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Documentary%' or genre_2 = '%Documentary%' or genre_3 = '%Documentary%' or genre_4 = '%Documentary%' or genre_5 = '%Documentary%' or genre_6 = '%Documentary%' or genre_7 = '%Documentary%' or genre_8 = '%Documentary%' or genre_9 = '%Documentary%' or genre_10 = '%Documentary%')  
union
select  itemID,title,'Drama' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Drama%' or genre_2 = '%Drama%' or genre_3 = '%Drama%' or genre_4 = '%Drama%' or genre_5 = '%Drama%' or genre_6 = '%Drama%' or genre_7 = '%Drama%' or genre_8 = '%Drama%' or genre_9 = '%Drama%' or genre_10 = '%Drama%')  
union
select itemID,title,'Fantasy' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Fantasy%' or genre_2 = '%Fantasy%' or genre_3 = '%Fantasy%' or genre_4 = '%Fantasy%' or genre_5 = '%Fantasy%' or genre_6 = '%Fantasy%' or genre_7 = '%Fantasy%' or genre_8 = '%Fantasy%' or genre_9 = '%Fantasy%' or genre_10 = '%Fantasy%')  
union
select itemID,title,'Film-Noir' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Film-Noir%' or genre_2 = '%Film-Noir%' or genre_3 = '%Film-Noir%' or genre_4 = '%Film-Noir%' or genre_5 = '%Film-Noir%' or genre_6 = '%Film-Noir%' or genre_7 = '%Film-Noir%' or genre_8 = '%Film-Noir%' or genre_9 = '%Film-Noir%' or genre_10 = '%Film-Noir%')  
union
select itemID,title,'Horror' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Horror%' or genre_2 = '%Horror%' or genre_3 = '%Horror%' or genre_4 = '%Horror%' or genre_5 = '%Horror%' or genre_6 = '%Horror%' or genre_7 = '%Horror%' or genre_8 = '%Horror%' or genre_9 = '%Horror%' or genre_10 = '%Horror%')  
union
select itemID,title,'Musical' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Musical%' or genre_2 = '%Musical%' or genre_3 = '%Musical%' or genre_4 = '%Musical%' or genre_5 = '%Musical%' or genre_6 = '%Musical%' or genre_7 = '%Musical%' or genre_8 = '%Musical%' or genre_9 = '%Musical%' or genre_10 = '%Musical%')  
union
select itemID,title,'Mystery' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Mystery%' or genre_2 = '%Mystery%' or genre_3 = '%Mystery%' or genre_4 = '%Mystery%' or genre_5 = '%Mystery%' or genre_6 = '%Mystery%' or genre_7 = '%Mystery%' or genre_8 = '%Mystery%' or genre_9 = '%Mystery%' or genre_10 = '%Mystery%')  
union
select itemID,title,'Romance' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Romance%' or genre_2 = '%Romance%' or genre_3 = '%Romance%' or genre_4 = '%Romance%' or genre_5 = '%Romance%' or genre_6 = '%Romance%' or genre_7 = '%Romance%' or genre_8 = '%Romance%' or genre_9 = '%Romance%' or genre_10 = '%Romance%')  
union
select itemID,title,'Sci-Fi' as genre from nn.dim_movies_raw_2 where (genre_1 = '%Sci-Fi%' or genre_2 = '%Sci-Fi%' or genre_3 = '%Sci-Fi%' or genre_4 = '%Sci-Fi%' or genre_5 = '%Sci-Fi%' or genre_6 = '%Sci-Fi%' or genre_7 = '%Sci-Fi%' or genre_8 = '%Sci-Fi%' or genre_9 = '%Sci-Fi%' or genre_10 = '%Sci-Fi%')  
union
select itemID,title,'Thriller' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Thriller%' or genre_2 = '%Thriller%' or genre_3 = '%Thriller%' or genre_4 = '%Thriller%' or genre_5 = '%Thriller%' or genre_6 = '%Thriller%' or genre_7 = '%Thriller%' or genre_8 = '%Thriller%' or genre_9 = '%Thriller%' or genre_10 = '%Thriller%')  
union
select itemID,title,'War' as genre from nn.dim_movies_raw_2 where (genre_1 = '%War%' or genre_2 = '%War%' or genre_3 = '%War%' or genre_4 = '%War%' or genre_5 = '%War%' or genre_6 = '%War%' or genre_7 = '%War%' or genre_8 = '%War%' or genre_9 = '%War%' or genre_10 = '%War%')  
union
select itemID,title,'Western' as genre from nn.dim_movies_raw_2  where (genre_1 = '%Western%' or genre_2 = '%Western%' or genre_3 = '%Western%' or genre_4 = '%Western%' or genre_5 = '%Western%' or genre_6 = '%Western%' or genre_7 = '%Western%' or genre_8 = '%Western%' or genre_9 = '%Western%' or genre_10 = '%Western%')  
union
select itemID,title,'(no genres listed)' as genre from nn.dim_movies_raw_2  where (genre_1 = '%(no genres listed)%' or genre_2 = '%(no genres listed)%' or genre_3 = '%(no genres listed)%' or genre_4 = '%(no genres listed)%' or genre_5 = '%(no genres listed)%' or genre_6 = '%(no genres listed)%' or genre_7 = '%(no genres listed)%' or genre_8 = '%(no genres listed)%' or genre_9 = '%(no genres listed)%' or genre_10 = '%(no genres listed)'%)
;  



##Creating the final dataset
drop table nn.dim_movies;
create table nn.dim_movies
select itemID,title,'Action' as genre from nn.dim_movies_raw_2  where (genre_1 like '%Action%' or genre_2  like  '%Action%' or genre_3  like  '%Action%' or genre_4  like  '%Action%' or genre_5  like  '%Action%' or genre_6  like  '%Action%' or genre_7  like  '%Action%' or genre_8  like  '%Action%' or genre_9  like  '%Action%' or genre_10  like  '%Action%')
union
select itemID,title,'Adventure' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Adventure%' or genre_2  like  '%Adventure%' or genre_3  like  '%Adventure%' or genre_4  like  '%Adventure%' or genre_5  like  '%Adventure%' or genre_6  like  '%Adventure%' or genre_7  like  '%Adventure%' or genre_8  like  '%Adventure%' or genre_9  like  '%Adventure%' or genre_10  like  '%Adventure%')
union
select itemID,title,'Animation' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Animation%' or genre_2  like  '%Animation%' or genre_3  like  '%Animation%' or genre_4  like  '%Animation%' or genre_5  like  '%Animation%' or genre_6  like  '%Animation%' or genre_7  like  '%Animation%' or genre_8  like  '%Animation%' or genre_9  like  '%Animation%' or genre_10  like  '%Animation%')  
union
select itemID,title,'Childrens' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Childrens%' or genre_2  like  '%Childrens%' or genre_3  like  '%Childrens%' or genre_4  like  '%Childrens%' or genre_5  like  '%Childrens%' or genre_6  like  '%Childrens%'or genre_7  like  '%Childrens%' or genre_8  like  '%Childrens%' or genre_9  like  '%Childrens%' or genre_10  like  '%Childrens%')  
union
select itemID,title,'Comedy' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Comedy%' or genre_2  like  '%Comedy%' or genre_3  like  '%Comedy%' or genre_4  like  '%Comedy%' or genre_5  like  '%Comedy%' or genre_6  like  '%Comedy%' or genre_7  like  '%Comedy%' or genre_8  like  '%Comedy%' or genre_9  like  '%Comedy%' or genre_10  like  '%Comedy%')  
union
select itemID,title,'Crime' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Crime%' or genre_2  like  '%Crime%' or genre_3  like  '%Crime%' or genre_4  like  '%Crime%' or genre_5  like  '%Crime%' or genre_6  like  '%Crime%' or genre_7  like  '%Crime%' or genre_8  like  '%Crime%' or genre_9  like  '%Crime%' or genre_10  like  '%Crime%')  
union
select itemID,title,'Documentary' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Documentary%' or genre_2  like  '%Documentary%' or genre_3  like  '%Documentary%' or genre_4  like  '%Documentary%' or genre_5  like  '%Documentary%' or genre_6  like  '%Documentary%' or genre_7  like  '%Documentary%' or genre_8  like  '%Documentary%' or genre_9  like  '%Documentary%' or genre_10  like  '%Documentary%')  
union
select itemID,title,'Drama' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Drama%' or genre_2  like  '%Drama%' or genre_3  like  '%Drama%' or genre_4  like  '%Drama%' or genre_5  like  '%Drama%' or genre_6  like  '%Drama%' or genre_7  like  '%Drama%' or genre_8  like  '%Drama%' or genre_9  like  '%Drama%' or genre_10  like  '%Drama%')  
union
select itemID,title,'Fantasy' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Fantasy%' or genre_2  like  '%Fantasy%' or genre_3  like  '%Fantasy%' or genre_4  like  '%Fantasy%' or genre_5  like  '%Fantasy%' or genre_6  like  '%Fantasy%' or genre_7  like  '%Fantasy%' or genre_8  like  '%Fantasy%' or genre_9  like  '%Fantasy%' or genre_10  like  '%Fantasy%')  
union
select itemID,title,'Film_Noir' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Film-Noir%' or genre_2  like  '%Film-Noir%' or genre_3  like  '%Film-Noir%' or genre_4  like  '%Film-Noir%' or genre_5  like  '%Film-Noir%' or genre_6  like  '%Film-Noir%' or genre_7  like  '%Film-Noir%' or genre_8  like  '%Film-Noir%' or genre_9  like  '%Film-Noir%' or genre_10  like  '%Film-Noir%')  
union
select itemID,title,'Horror' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Horror%' or genre_2  like  '%Horror%' or genre_3  like  '%Horror%' or genre_4  like  '%Horror%' or genre_5  like  '%Horror%' or genre_6  like  '%Horror%' or genre_7  like  '%Horror%' or genre_8  like  '%Horror%' or genre_9  like  '%Horror%' or genre_10  like  '%Horror%')  
union
select itemID,title,'Musical' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Musical%' or genre_2  like  '%Musical%' or genre_3  like  '%Musical%' or genre_4  like  '%Musical%' or genre_5  like  '%Musical%' or genre_6  like  '%Musical%' or genre_7  like  '%Musical%' or genre_8  like  '%Musical%' or genre_9  like  '%Musical%' or genre_10  like  '%Musical%')  
union
select itemID,title,'Mystery' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Mystery%' or genre_2  like  '%Mystery%' or genre_3  like  '%Mystery%' or genre_4  like  '%Mystery%' or genre_5  like  '%Mystery%' or genre_6  like  '%Mystery%' or genre_7  like  '%Mystery%' or genre_8  like  '%Mystery%' or genre_9  like  '%Mystery%' or genre_10  like  '%Mystery%')  
union
select itemID,title,'Romance' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Romance%' or genre_2  like  '%Romance%' or genre_3  like  '%Romance%' or genre_4  like  '%Romance%' or genre_5  like  '%Romance%' or genre_6  like  '%Romance%' or genre_7  like  '%Romance%' or genre_8  like  '%Romance%' or genre_9  like  '%Romance%' or genre_10  like  '%Romance%')  
union
select itemID,title,'Sci_Fi' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%Sci-Fi%' or genre_2  like  '%Sci-Fi%' or genre_3  like  '%Sci-Fi%' or genre_4  like  '%Sci-Fi%' or genre_5  like  '%Sci-Fi%' or genre_6  like  '%Sci-Fi%' or genre_7  like  '%Sci-Fi%' or genre_8  like  '%Sci-Fi%' or genre_9  like  '%Sci-Fi%' or genre_10  like  '%Sci-Fi%')  
union
select itemID,title,'Thriller' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Thriller%' or genre_2  like  '%Thriller%' or genre_3  like  '%Thriller%' or genre_4  like  '%Thriller%' or genre_5  like  '%Thriller%' or genre_6  like  '%Thriller%' or genre_7  like  '%Thriller%' or genre_8  like  '%Thriller%' or genre_9  like  '%Thriller%' or genre_10  like  '%Thriller%')  
union
select itemID,title,'War' as genre from nn.dim_movies_raw_2 where (genre_1  like  '%War%' or genre_2  like  '%War%' or genre_3  like  '%War%' or genre_4  like  '%War%' or genre_5  like  '%War%' or genre_6  like  '%War%' or genre_7  like  '%War%' or genre_8  like  '%War%' or genre_9  like  '%War%' or genre_10  like  '%War%')  
union
select itemID,title,'Western' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%Western%' or genre_2  like  '%Western%' or genre_3  like  '%Western%' or genre_4  like  '%Western%' or genre_5  like  '%Western%' or genre_6  like  '%Western%' or genre_7  like  '%Western%' or genre_8  like  '%Western%' or genre_9  like  '%Western%' or genre_10  like  '%Western%')  
union
select itemID,title,'(no genres listed)' as genre from nn.dim_movies_raw_2  where (genre_1  like  '%(no genres listed)%' or genre_2  like  '%(no genres listed)%' or genre_3  like  '%(no genres listed)%' or genre_4  like  '%(no genres listed)%' or genre_5  like  '%(no genres listed)%' or genre_6  like  '%(no genres listed)%' or genre_7  like  '%(no genres listed)%' or genre_8  like  '%(no genres listed)%' or genre_9  like  '%(no genres listed)%' or genre_10  like  '%(no genres listed)%')
; 



drop table all_movie_ratings ;
create table all_movie_ratings as(
select itemID , AVG(rating) as rating from ratings group by 1
);

drop table nn.DIM_ITEM_PROFILE;
create table nn.DIM_ITEM_PROFILE as (
select a.*,b.rating as avg_rating from nn.temporary_item_matrix as a join all_movie_ratings as b
on a.itemID = b.itemID
)
;

drop table movie_based_user_data_655;
create table movie_based_user_data_655 as 
select a.*,b.rating from  nn.DIM_ITEM_PROFILE as a join 
(select * from nn.ratings where userID = 655) as b on a.itemID = b.itemID
;


select * from movie_based_user_data_655;

