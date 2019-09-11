setwd("C:/Users/uqethom9/Desktop/LassoRegression") # please set the workking directory as required. For some reason, I cannot point towards the dropbox folder.
rm(list=ls())
library(gglasso)
library(reshape)
#please install gglasso for the first time -->  install.packages("grplasso", dependencies=TRUE)
myTrain = read.csv("myTrainSet.csv")
myValid = read.csv("myValidSet.csv")
myTest = read.csv("myTestSet.csv")
## WALLTYPE:9 pose a problem. Such an entry is not there in the valid sets

factorCols = c("WALLTYPE","ROOFTYPE","PRKGPLC1","STOVENFUEL","DEFROST","TOASTER","FUELFOOD","COFFEE","TYPERFR1","TREESHAD","TVTYPE1","INTERNET"
               ,"WELLPUMP","AQUARIUM","STEREO","MOISTURE","FUELH2O","PROTHERMAC","RECBATH","SLDDRS","USENG","USESOLAR","ELWARM","ELWATER"
               ,"ELFOOD","EMPLOYHH","Householder_Race","EDUCATION","RETIREPY","POVERTY150")

myTrain[factorCols] = lapply(myTrain[factorCols], factor)
myValid[factorCols] = lapply(myValid[factorCols], factor)
myTest[factorCols]  = lapply(myTest[factorCols], factor)



group = rep(0,100)
len = length(myTrain)

levels = rep(0,69)
for (i in 1:len)
{
  if(is.factor(myTrain[,i]) ==FALSE)
  {levels[i]=1}
  else
  {
    levels[i] = length(levels(myTrain[,i]))-1
  }
}
groups = rep(levels[1],levels[1])
for(i in 1:len)
{
  groups = c(groups, rep(i,levels[i]))
}
groups = groups[2:104] # need to eliminate the first one and last one --> THINK..!


xTrain = model.matrix( ~ ., dplyr::select(myTrain, -KWH))[, -1];
xTest  = model.matrix( ~ ., dplyr::select(myTest, -KWH))[, -1];
yTrain = myTrain$KWH; yTest = subset(myTest, select=c(KWH))
obs = dim(yTest)[1]

# Designing the model matrix. This is also called one-hot encoding, where the categorical nature of variables can be specified
# Define groups    groups <- c(rep(1:4, each = 4), 5)
# we say that 13th variable (cat1) has 2 levels, and 14th one (cat2) has 5 levels. So consider n-1 both cases.
#yTrain = myData$KWH[trainIndices]; yTest = myData$KWH[-trainIndices]; 

lambdas = c(0,1,1.5,6.5,6.7,8,11,13,16,18,19,23,24,25,27,32,33,34,41,56,60,65,75,78,80,85,100,108,110,115,121,125,130,155,160,170,180,187.5,
            189,195,250,350,400,500,600,688,700,800,850,950,1000,1100,1200,1250,1300,1700,2450,2800,3000,3400,4500,5500,18000,35000,800000,
            2000000,5000000,100000000)


lambdas = c(1000,1500,2000)   ## TO CHANGE--> Just delete this line. trust me, rest will be good.!
obs = length(lambdas)
fits <- list()
coef <- list()
predict <- list()
for(i in 1:obs){
  fits[[i]] = gglasso(x = xTrain, y = yTrain, group = groups, lambda = lambdas[i],loss="ls")
  coef[[i]] = fits[[i]]$beta
  predict[[i]] = predict(fits[[i]],type = "class",newx=xTest)
} 



rSquaredVal = rep(0,68)
rSquaredVal = rep(0,3)  ## TO CHANGE--> Just delete this line. trust me, rest will be good.!
for(i in 1:obs)
{
  rSquaredVal[i] =  1-((sum((yTest-predict[[i]])^2))/ (sum((yTest- mean(data.matrix(predict[[i]])))^2)))
}

plot(rSquaredVal)


#Std Dev on residuals
stdErr = rep(0,68)

stdErr = rep(0,3)  ## TO CHANGE --> Just delete this line. trust me, rest will be good.!
for(i in 1:obs)
{
  stdErr[i] = sqrt(mean(data.matrix((yTest-predict[[i]])^2)))
}
plot(stdErr)


write.csv(stdErr,"stdErrorLasso.csv")
write.csv(rSquaredVal,"rSquaredErrorLasso.csv")



## For the test value:

################################# Bcoz myValid do not have all the categories -->Doesnt have WALLTYPE:8
which(myTrain$WALLTYPE==8)
f= myTrain[3250,]
myValid = rbind(myValid,f)
#################################



myValidX   = model.matrix( ~ ., dplyr::select(myValid, -KWH))[,-1] # does not have WALLTYPE 8
myValidY      = model.matrix( ~ ., dplyr::select(myValid, KWH))[,-1]
predictedValidY = predict(fits[[2]],type = "class",newx=myValidX)   # select the required fit number., But the validation set do not have all the Factors.!
stdErrMyValid = sqrt(mean((predictedValidY-myValidY)^2))




# Lines 57,71 and 83 needs to be deleted.