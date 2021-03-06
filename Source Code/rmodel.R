library(rJava)
library(rpart)
library(RWeka)
library(class)
library(ggplot2)
library(rpart)
churn<-read.csv("E:\sanket\pendrive\sem 6\MP\churn_prediction\report\CD_DVD Content\Churn_prediction B15 Ms.Archana T\Source Code\\rchurn.csv", header=T)
names(churn)
str(churn)
summary(churn)
m2 <- J48(Churn.~ .,data = churn)
m3 <- table(churn$Churn.,predict(m2))
plot(m3)

f<-rpart(Churn.~ CustServ.Calls+Eve.Calls+Intl.Calls+Night.Calls+Day.Calls,method="class", data=churn)
plot(f, uniform=TRUE,main="Classification Tree for Churn")
text(f, use.n=TRUE, all=TRUE, cex=.7)

f<-rpart(Churn.~ CustServ.Calls+Eve.Charge+Intl.Charge+Night.Charge+Day.Charge, method="class", data=churn)
plotcp(f,lty=4,col="red")

plot(Churn. ~., data = churn, type = "c")
lines(Churn.~ Day.Charge,type="l")

# convert factor to numeric for convenience
churn$Churn. <- as.numeric(churn$Churn.)
ntrees <- max(churn$Churn.)
# get the range for the x and y axis
xrange <- range(churn$Day.Calls)
yrange <- range(churn$CustServ.Calls)
# set up the plot
plot(xrange, yrange, type="n", xlab="Day.Calls (num)", ylab="CustServ.Calls(num)" )
colors <- rainbow(ntrees)
linetype <- c(1:ntrees)
plotchar <- seq(15,15+ntrees,1)
# add lines
for (i in 1:ntrees) {
  tree <- subset(churn, Churn.==i)
  lines(tree$Day.Calls, tree$CustServ.Calls, type="b", lwd=1.5, lty=linetype[i], col=colors[i], pch=plotchar[i]) }
# add a title and subtitle
title("Churn", "line plot")
# add a legend
legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,pch=plotchar, lty=linetype, title="Tree")

qplot(Day.Calls, CustServ.Calls, data = churn,colour=Churn.)

qplot(Day.Calls,Night.Calls, data = churn,geom = c("point", "smooth"),color=Churn.)

dsc<- churn[sample(nrow(churn),100), ]
qplot(Day.Calls,CustServ.Calls, data = dsc, geom = c("point", "smooth"),color=Churn.)

qplot(Day.Calls,CustServ.Calls, data=churn,facets=Churn.~Area.Code)

dsc<- churn[sample(nrow(churn), 100),]
qplot(Day.Calls,Churn., data = dsc,geom = c("point", "smooth"),color=State)

qplot(Area.Code,Night.Mins, data=dsc)

qplot(Day.Calls,Night.Calls, data = churn, alpha=I(1/2))

qplot(Day.Calls, data = dsc,geom = "histogram",fill=Churn.)

qplot(Night.Calls, data = dsc,geom = "histogram",fill=Int.l.Plan)
