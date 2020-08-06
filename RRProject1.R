library(dplyr)
library(lattice)
library(lubridate)
activity<-read.csv("activity.csv")
str(activity)
summary(activity)
###################################################################
tot_steps_pday<-tapply(activity$steps,activity$date,sum,na.rm=TRUE)
hist(tot_steps_pday,main = "TOTAL NUMBER OF STEPS TAKEN PER DAY",
     xlab="Total steps taken per day",ylab="Frequency",
     col="red",breaks = seq(0,25000,2500))
###################################################################
mean(tot_steps_pday)
median(tot_steps_pday)
###################################################################
avg_steps_pint<-tapply(activity$steps,activity$interval,mean,na.rm=TRUE)
avg_steps_pint_table<-cbind(names(avg_steps_pint),avg_steps_pint)
plot(avg_steps_pint_table,main="Average steps taken per Interval across each Date",
     xlab="Intervals",ylab="Average Steps Taken per Interval",
     col="turquoise",type="l",lwd=2)
###################################################################
names(which.max(avg_steps_pint))
###################################################################
tot_missing<-sum(is.na(activity$steps))
tot_missing
###################################################################
new_activity<-activity
for(i in 1:nrow(activity)){
  if(is.na(new_activity[i,]$steps)){
    missing_interval<-new_activity[i,]$interval
    new_activity[i,]$steps<-avg_steps_pint[as.character(missing_interval)]
  }
}
###################################################################
new_tot_steps_pday<-tapply(new_activity$steps,new_activity$date,sum,na.rm=TRUE)
hist(new_tot_steps_pday,main = "TOTAL NUMBER OF STEPS TAKEN PER DAY",
     xlab="Total steps taken per day",ylab="Frequency",
     col="red",breaks = seq(0,25000,2500))
###################################################################
mean(new_tot_steps_pday)
median(new_tot_steps_pday)
###################################################################
new_activity$date<-ymd(new_activity$date)
new_activity$day<-weekdays(new_activity$date)
new_activity$daytype<-"Weekday"
for(i in 1:nrow(new_activity)){
  if(new_activity[i,]$day=="Saturday"|new_activity[i,]$day=="Sunday"){
    new_activity[i,]$daytype<-"Weekend"
  }
}
####################################################################
agg_activity<-aggregate(new_activity$steps~new_activity$interval+new_activity$daytype,new_activity,mean)
names(agg_activity)<-c("interval","daytype","steps")
xyplot(steps~interval|daytype,agg_activity,type="l",layout=c(1,2),
       xlab="Interval",ylab="Mean Number of steps")
####################################################################