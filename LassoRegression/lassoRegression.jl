using CSV, StatsBase, GLM, CSV, Distributions, RCall, Random
cd("H:/GitHub")


R"""
rm(list=ls())
library(gglasso)
library(reshape)

myTrain = read.csv("myTrainSet.csv")
myValid = read.csv("myValidSet.csv")
myTest = read.csv("myTestSet.csv")
lambdaVals = read.csv("lambdaVals.csv");
lambdas = lambdaVals[,1]
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

#lambdas = c(1000,1500,2000)   ## TO CHANGE--> Just delete this line. trust me, rest will be good.!
obs = length(lambdas)
fits <- list()
coef <- list()
predict <- list()

for(i in 1:obs){
  fits[[i]] = gglasso(x = xTrain, y = yTrain, group = groups, lambda = lambdas[i],loss="ls")
  coef[[i]] = fits[[i]]$beta
  predict[[i]] = predict(fits[[i]],type = "class",newx=xTest)
}

#rSquaredVal = rep(0,obs)
rSquaredVal = rep(0,3)  ## TO CHANGE--> Just delete this line. trust me, rest will be good.!
for(i in 1:obs)
{
  rSquaredVal[i] =  1-((sum((yTest-predict[[i]])^2))/ (sum((yTest- mean(data.matrix(predict[[i]])))^2)))
}

plot(rSquaredVal)


#Std Dev on residuals
stdErr = rep(0,obs)

#stdErr = rep(0,3)  ## TO CHANGE --> Just delete this line. trust me, rest will be good.!
for(i in 1:obs)
{
  stdErr[i] = sqrt(mean(data.matrix((yTest-predict[[i]])^2)))
}
plot(stdErr[1:67])


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


"""

@rget rSquaredVal
@rget stdErr
@rget stdErrMyValid
