drop table content_user_based_405;
create table content_user_based_405 as 
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
X846,
X311,
X94,
X194,
X276,
X222,
X450, 
X59,
X7,
X378,
X712,
X864,
X293,
X618,
X303,
X308,
X682,
X429,
X95,
X796,
user_405_rating
from
movie_based_user_data_405 as a join final_data_405_complete_shuffled as b on (a.itemID = b.itemID)
;