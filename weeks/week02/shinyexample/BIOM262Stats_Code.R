############ Install necessary packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(rgl,mvtnorm)

source("dotPlotFuncs.R")

############  Code #1.  Explanatory, confounding, response example ##############

## 1a ## Correlated explanatory and confounding
ab1=rmvnorm(1000,c(0,0),cbind(c(1,.4),c(.4,1)))
explanatory.variable1=ab1[,1]
confounding.variable1=ab1[,2]
sprintf('Correlation between explanatory and confounding variables: %0.4f',cor(explanatory.variable1,confounding.variable1))
response.variable1=explanatory.variable1+confounding.variable1
plot3d(explanatory.variable1,confounding.variable1,response.variable1)

## 1b ## Uncorrelated explanatory and confounding
ab2=rmvnorm(1000,c(0,0),cbind(c(1,0),c(0,1)))
explanatory.variable2=ab2[,1]
confounding.variable2=ab2[,2]
sprintf('Correlation between explanatory and confounding variables: %0.4f',cor(explanatory.variable2,confounding.variable2))
response.variable2=explanatory.variable2+confounding.variable2
plot3d(explanatory.variable2,confounding.variable2,response.variable2)

#########  Code #2.  Summarizing data with statistics ########

## 2a ## 
lead.data=read.csv('http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter11/chap11q22BloodLeadKatrina.csv',header=T)
View(lead.data)
plotDotPlot(lead.data$ratio)

#########  Code #3.  Simple linear regression ########

## 3a ##

reg.data <- read.csv("tannin.csv")
View(reg.data)

## 3b ##
plot(reg.data$tannin,reg.data$growth,pch=21,bg="blue")

## 3c ##
lm(growth~tannin,data=reg.data)

## 3d ##
abline(lm(growth~tannin,data=reg.data),col="cyan")

## 3e ##
fitted <- predict(lm(growth~tannin,data=reg.data))


# residuals

for (i in 1:9) {
  lines(c(reg.data$tannin[i],reg.data$tannin[i]),c(reg.data$growth[i],fitted[i]),col="magenta")
}

## 3f ##
# estimating the maximum likelihood slope

b <-  seq(-1.43,-1,0.002)
sse <- numeric(length(b))
for (i in 1:length(b)) {
  a <- mean(reg.data$growth)-b[i]*mean(reg.data$tannin)
  residual <- reg.data$growth - a - b[i]*reg.data$tannin
  sse[i] <- sum(residual^2)
}
mlval=b[which(sse==min(sse))]
plot(b,sse,type="l",ylim=c(19,24))
arrows(mlval,min(sse),mlval,min(sse)-1,col="magenta")
abline(h=min(sse),col="cyan",lty=2)
lines(b,sse)


## 3g ##

# corrected sums of squares

SSX <- sum(reg.data$tannin^2)-sum(reg.data$tannin)^2/length(reg.data$tannin)
SSY <- sum(reg.data$growth^2)-sum(reg.data$growth)^2/length(reg.data$growth)
SSXY <- sum(reg.data$tannin*reg.data$growth)-sum(reg.data$tannin)*sum(reg.data$growth)/length(reg.data$tannin)

# box 7.5 figure

plot(c(0,10),c(0,10),xlab="",ylab="",type="n")
abline(h=5,lty=2)
lines(c(0,10),c(8,2))
text(2,6.2,expression(hat(y) - bar(y)))
text(2,8.45,expression(y - hat(y)))
arrows(7,5,7,9.5,code=3,length=0.1)
arrows(1,5,1,7.4,code=3,length=0.1)
arrows(1,9.5,1,7.4,code=3,length=0.1)
points(1,9.5,pch=16)
text(8,7.4,expression(y - bar(y)))
text(0.2,5,expression(bar(y)))
text(.2,7.4,expression(hat(y)))
text(.2,9.5,"y")


## 3h ##
# regression model in R


model <- lm(growth~tannin,data=reg.data)
summary(model)
summary.aov(model)


############ Code #4:  non-linear situation 
# a non-linear relationship

## 4a.1 ##
par(mfrow=c(1,1))
decay <- read.csv("decay.csv")
View(decay)

## 4a.2 ##
plot(decay$time,decay$amount,pch=21,col="blue",bg="cyan")

abline(lm(amount~time,data=decay),col="magenta")
summary(lm(amount~time,data=decay))

## 4a.3 ##

plot(decay$time,log(decay$amount),pch=21,col="blue",bg="magenta")
abline(lm(log(amount)~time,data=decay),col="blue")

model <- lm(log(amount)~time,data=decay)
summary(model)

## 4a.4 ##
par(mfrow=c(1,1))
plot(decay$time,decay$amount,pch=21,col="blue",bg="cyan")
xv <- seq(0,30,0.25)
yv <- 94.38536 * exp(-0.068528 * xv)
lines(xv,yv,col="magenta")

# model comparison

## 4a.5 ##

model2 <- lm(amount~time,data=decay)
model3 <- lm(amount~time+I(time^2),data=decay)
summary(model3)
AIC(model2,model3)
anova(model2,model3)

## 4b.1 ##
# non-linear regression using nls

deer <- read.csv("jaws.csv")
View(deer)

## 4b.2
par(mfrow=c(1,1))
plot(deer$age,deer$bone,pch=21,bg="lightgrey")

## 4b.3
model <- nls(bone~a-b*exp(-c*age),data=deer,start=list(a=120,b=110,c=0.064))
summary(model)
av <- seq(0,50,0.1)
bv <- predict(model,list(age=av),data=deer)
lines(av,bv,col="blue")

## 4b.4
model2 <- nls(bone~a*(1-exp(-c*age)),data=deer,start=list(a=120,c=0.064))
av2 <- seq(0,50,0.1)
bv2 <- predict(model2,list(age=av2),data=deer)
lines(av2,bv2,col="magenta")
summary(model2)

## 4b.5
anova(model,model2)



################# Code #5:  ANOVA #########


## 5a ##
# one-way anova

oneway <- read.csv("oneway.csv")
View(oneway)

## 5b ##
plot(1:20,oneway$ozone,ylim=c(0,8),ylab="y",xlab="order",pch=21,bg="magenta")
## 5c ##
abline(h=mean(oneway$ozone),col="blue")
## 5d ##
for(i in 1:20) lines(c(i,i),c(mean(oneway$ozone),oneway$ozone[i]),col="cyan")
## 5e ##
plot(1:20,oneway$ozone,ylim=c(0,8),ylab="y",xlab="order",
     pch=21,bg=as.numeric(oneway$garden))
## 5f ##
abline(h=mean(oneway$ozone[oneway$garden=="A"]))
abline(h=mean(oneway$ozone[oneway$garden=="B"]),col="red")
## 5g ##
index <- 1:length(oneway$ozone)
for (i in 1:length(index)){
  if (oneway$garden[i] == "A" )
    lines(c(index[i],index[i]),c(mean(oneway$ozone[oneway$garden=="A"]),oneway$ozone[i]))
  else 
    lines(c(index[i],index[i]),c(mean(oneway$ozone[oneway$garden=="B"]),oneway$ozone[i]), col="red")
}

#5h

summary(aov(ozone~garden,data=oneway))

################# Code #6:  ANCOVA #########

## 6a ##
ancdata <- read.csv("ipomopsis.csv")
View(ancdata)

## 6a ##
plot(ancdata$Root,ancdata$Fruit,pch=16,col="blue")
## 6b ##
plot(ancdata$Grazing,ancdata$Fruit,col="lightgreen",ylab="Fruit")

## 6c ##
# the wrong analysis (not controlling for initial size)

summary(aov(Fruit~Grazing,data=ancdata))

## 6d ##
# the correct anocova (controls for initial size)

model <- lm(Fruit~Root*Grazing,data=ancdata)
summary.aov(model)

## 6e ##
model <- lm(Fruit~Grazing*Root,data=ancdata)
summary.aov(model)
## 6f ##
model2 <- lm(Fruit~Grazing+Root,data=ancdata)
anova(model,model2)
summary.lm(model2)
## 6g ##
plot(ancdata$Root,ancdata$Fruit,pch=21,bg=(4*as.numeric(ancdata$Grazing)))
legend("topleft",c("grazed","ungrazed"),col=c(4,8),pch=16)
abline(-127.829,23.56,col="blue")
abline(-127.829+36.103,23.56,col="blue")
