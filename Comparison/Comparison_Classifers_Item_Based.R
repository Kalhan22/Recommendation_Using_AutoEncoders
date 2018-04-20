#Compare with Logistic Regression
#Neural Networks
library(nnet)
setwd("/Users/Kalhan/Desktop/Waterloo Data/Winter 2018/CS698/Neural Networks/Project/RAC/UserData/655")
data <- read.csv("full_data_item_based_655.csv")

data$avg_rating = data$avg_rating/5

train <- data[1:431, ]
test <- data[432:nrow(data), ]

#  X846 + X311 +  X94 +  X194  + X276  + X222  + X450  + X59 +  X7 + X378 + X712 + X864 + X293 + X618 + X303 + X308 + X682 + X429 + X95 + X796

# X655 +  X537 +  X201 +  X592 +  X293 + X13 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303  X327 +  X184 +  X334 + X85 +  X276

#Regression
model <- nnet(rating ~  Action +  Adventure +  Animation +  Comedy + Crime +  Documentary +  Drama +  Fantasy +  Film_Noir + Horror +  Musical +  Mystery +  Romance +  Sci_Fi +  Thriller +  War +  Western +  No_Genre + avg_rating ,size = 40,maxit=10000,decay=.002,MaxNWts = 20000,Hess = TRUE,linout=TRUE, data <- train)
nnet_model_prediction <- predict(model, test, type = "raw") 
prediction_class <- as.data.frame(nnet_model_prediction)
colnames(prediction_class) <- c('prediction_class')
final_dataset <- cbind(test,prediction_class)
veca = c(final_dataset$rating)
vecb = c(final_dataset$prediction_class)
print(Metrics::mse(veca,vecb))


#Classification
model <- nnet(as.factor(rating) ~  Action +  Adventure +  Animation +  Comedy + Crime +  Documentary +  Drama +  Fantasy +  Film_Noir + Horror +  Musical +  Mystery +  Romance +  Sci_Fi +  Thriller +  War +  Western +  No_Genre + avg_rating,size = 40,maxit=10000,decay=.002,MaxNWts = 20000,Hess = TRUE, linout=FALSE,data <- train)
nnet_model_prediction <- predict(model, test, type = "class") 
prediction_class <- as.data.frame(nnet_model_prediction)
colnames(prediction_class) <- c('prediction_class')
final_dataset <- cbind(test,prediction_class)
print(100*sum(final_dataset$rating == final_dataset$prediction_class)/nrow(final_dataset))


