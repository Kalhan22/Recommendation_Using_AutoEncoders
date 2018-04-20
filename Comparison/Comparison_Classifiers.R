#Compare with Logistic Regression
#Neural Networks
library(nnet)
setwd("/Users/Kalhan/Desktop/Waterloo Data/Winter 2018/CS698/Neural Networks/Project/RAC/UserData/655")
data <- read.csv("full_data_similar_user_655.csv")

train <- data[1:455, ]
test <- data[456:nrow(data), ]

#  X846 + X311 +  X94 +  X194  + X276  + X222  + X450  + X59 +  X7 + X378 + X712 + X864 + X293 + X618 + X303 + X308 + X682 + X429 + X95 + X796

# X655 +  X537 +  X201 +  X592 +  X293 + X13 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303  X327 +  X184 +  X334 + X85 +  X276

#Regression
model <- nnet(user_655_rating ~  X537 +  X201 +  X592 +  X293 + X12 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303 +  X327 +  X184 +  X334 + X85 +  X276,size = 40,maxit=10000,decay=.002,MaxNWts = 20000,Hess = TRUE,linout=TRUE, data <- train)
nnet_model_prediction <- predict(model, test, type = "raw") 
prediction_class <- as.data.frame(nnet_model_prediction)
colnames(prediction_class) <- c('prediction_class')
final_dataset <- cbind(test,prediction_class)
veca = c(final_dataset$user_655_rating)
vecb = c(final_dataset$prediction_class)
print(Metrics::mse(veca,vecb))


#Classification
model <- nnet(as.factor(user_655_rating) ~  X537 +  X201 +  X592 +  X293 + X12 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303 +  X327 +  X184 +  X334 + X85 +  X276,size = 40,maxit=10000,decay=.002,MaxNWts = 20000,Hess = TRUE, linout=FALSE,data <- train)
nnet_model_prediction <- predict(model, test, type = "class") 
prediction_class <- as.data.frame(nnet_model_prediction)
colnames(prediction_class) <- c('prediction_class')
final_dataset <- cbind(test,prediction_class)
print(100*sum(final_dataset$user_655_rating == final_dataset$prediction_class)/nrow(final_dataset))



#Classification
model <- multinom(as.factor(user_655_rating) ~  X537 +  X201 +  X592 +  X293 + X12 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303  + X327 +  X184 +  X334 + X85 +  X276,data <- train)
log_model_prediction <- predict(model, test, type = "class") 
prediction_class <- as.data.frame(log_model_prediction)
colnames(prediction_class) <- c('prediction_class')
final_dataset <- cbind(test,prediction_class)
print(100*sum(final_dataset$user_655_rating == final_dataset$prediction_class)/nrow(final_dataset))


#SVM
library(e1071)
model <- svm(as.factor(user_655_rating) ~   X537 +  X201 +  X592 +  X293 + X12 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303  +  X327 +  X184 +  X334 + X85 +  X276
             , kernel = c("radial"),data <- train)

svm_model_prediction <- predict(model, test, type = "class") 
prediction_class <- as.data.frame(svm_model_prediction)
colnames(prediction_class) <- c("Prediction_Class")
final_dataset <- cbind(test,prediction_class)
print(100*sum(final_dataset$user_655_rating == final_dataset$Prediction_Class)/nrow(final_dataset))


#Random Forest
library(randomForest)
model <- randomForest(as.factor(user_655_rating) ~   X537 +  X201 +  X592 +  X293 + X12 +  X90 +  X59 +  X308 +  X474 +  X450 +  X378 +  X234 +  X429 +  X416 +  X303   + X327 +  X184 +  X334 + X85 +  X276
                      ,importance=TRUE,proximity=TRUE,  train)

forest_model_prediction <- predict(model, test, type = "class") 
prediction_class <- forest_model_prediction
prediction_class <- as.data.frame(prediction_class)
colnames(prediction_class) <- c('Prediction_Class')
final_dataset <- cbind(test,prediction_class)
print(100*sum(final_dataset$user_655_rating == final_dataset$Prediction_Class)/nrow(final_dataset))










