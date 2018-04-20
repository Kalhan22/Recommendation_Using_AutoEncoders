select userID, count(*) as all_ratings from ratings group by 1
order by all_ratings DESC;

#655, 537, 201, 592, 293, 13, 90, 59, 308, 474, 450, 378, 234, 429, 416, 303, 327, 184, 334, 85, 276


drop table  temp_655_1;
create table temp_655_1 as 
select distinct itemID from ratings where userID = 655 and 
itemID in (select distinct itemID from ratings where userID = 537 ) and
itemID in (select distinct itemID from ratings where userID = 201 ) and
itemID in (select distinct itemID from ratings where userID = 592 ) and
itemID in (select distinct itemID from ratings where userID = 293 ) and 
itemID in (select distinct itemID from ratings where userID = 12 ) and
itemID in (select distinct itemID from ratings where userID = 90 ) and
itemID in (select distinct itemID from ratings where userID = 59 ) and 
itemID in (select distinct itemID from ratings where userID = 308 ) 
;



drop table temp_655_2;
create table temp_655_2 as 
select distinct itemID from temp_655_1 where
itemID in (select distinct itemID from ratings where userID = 474 ) and
itemID in (select distinct itemID from ratings where userID = 450 ) and
itemID in (select distinct itemID from ratings where userID = 378 ) and 
itemID in (select distinct itemID from ratings where userID = 234 ) and
itemID in (select distinct itemID from ratings where userID = 429 ) and
itemID in (select distinct itemID from ratings where userID = 416 ) and
itemID in (select distinct itemID from ratings where userID = 303 )
;



#Movies
select distinct itemID from temp_655_2 where 
itemID in (select distinct itemID from ratings where userID = 327 ) and 
itemID in (select distinct itemID from ratings where userID = 184 ) and
itemID in (select distinct itemID from ratings where userID = 334 ) and
itemID in (select distinct itemID from ratings where userID = 85 ) and
itemID in (select distinct itemID from ratings where userID = 276 ) 
;


drop table final_data_655_complete;

#655, 537, 201, 592, 293, 13, 90, 59, 308, 474, 450, 378, 234, 429, 416, 303, 327, 184, 334, 85, 276

drop table final_data_655_complete;
create table final_data_655_complete as 
select
a.itemID,
CASE WHEN X537 is null THEN 0 else X537 END as X537, 
CASE WHEN X201 is null THEN 0 else X201 END as X201, 
CASE WHEN X592 is null THEN 0 else X592 END as X592, 
CASE WHEN X293 is null THEN 0 else X293 END as X293, 
CASE WHEN X12 is null THEN 0 else X12 END as X12, 
CASE WHEN X90 is null THEN 0 else X90 END as X90, 
CASE WHEN X59 is null THEN 0 else X59 END as X59, 
CASE WHEN X308 is null THEN 0 else X308 END as X308, 
CASE WHEN X474 is null THEN 0 else X474 END as X474, 
CASE WHEN X450 is null THEN 0 else X450 END as X450, 

#378, 234, 429, 416, 303, 327, 184, 334, 85, 276
 
CASE WHEN X378 is null THEN 0 else X378 END as X378,  
CASE WHEN X234 is null THEN 0 else X234 END as X234, 
CASE WHEN X429 is null THEN 0 else X429 END as X429, 
CASE WHEN X416 is null THEN 0 else X416 END as X416, 
CASE WHEN X303 is null THEN 0 else X303 END as X303, 
CASE WHEN X327 is null THEN 0 else X327 END as X327, 
#682, 429, 95, 796 
CASE WHEN X184 is null THEN 0 else X184 END as X184, 
CASE WHEN X334 is null THEN 0 else X334 END as X334, 
CASE WHEN X85 is null THEN 0 else X85 END as X85, 
CASE WHEN X276 is null THEN 0 else X276 END as X276, 
b.rating as user_655_rating
from
matrix_data_transposed as a join (select  itemID, rating from ratings where userID = 655) as 
b on (a.itemID = b.itemID)
;


drop table final_data_655_complete_shuffled;
create table final_data_655_complete_shuffled as 
select * from final_data_655_complete order by rand();

select * from final_data_655_complete_shuffled;