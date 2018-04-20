drop table content_user_based_655;
create table content_user_based_655 as 
select
a.itemID, 
title, 
Action, 
Adventure, 
Animation, 
Comedy,
Crime,
Documentary,
Drama,
Fantasy,
Film_Noir,
Horror,
Musical,
Mystery,
Romance,
Sci_Fi,
Thriller,
War,
Western,
No_Genre,
avg_rating, 
X537,
X201,
X592,
X293,
X12,
X90,
X59, 
X308,
X474,
X450,
X378,
X234,
X429,
X416,
X303,
X327,
X184,
X334,
X85,
X276,
user_655_rating
from
movie_based_user_data_655 as a join final_data_655_complete_shuffled as b on (a.itemID = b.itemID)
;

select * from content_user_based_655;