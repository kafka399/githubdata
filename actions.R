setwd('/home/git/github/')
require('ggplot2')
require(xts)

timeline<-as.matrix(read.table('actions.csv',sep=',',header=F))
tmp<-xts(vector(length=NROW(timeline)),order.by=as.POSIXct(strftime(timeline[,1],'%Y-%m-%d %H:%M:%S')))
tmp[,1]=1

timeline=aggregate((tmp[,1]),list(factor(format(index(tmp),'%Y%m%d%H'))),sum)
tmp=data.frame(year=substr(as.character(index(timeline)),1,4),hour=substr(as.character(index(timeline)),9,10),count=(as.numeric(timeline)))

years = subset(tmp,tmp$year=='2012')
res = data.frame(aggregate(years$count,list(years$hour),
                           function(x)
                           {
                             quantile(x,probs=c(.2,.5,.8))
                           }
                           ))
                 #sd=aggregate(years$count,list(years$hour),sd)[,2],
                 
#res=melt(data.frame(res),id='hour')

res=cbind(as.numeric(res[,1]),as.numeric(res$x[,3]),as.numeric(res$x[,2]),as.numeric(res$x[,1]))
colnames(res)=c('hour','busy','normal','calm')
res=data.frame(melt(data.frame(res),id='hour'))

png('actions.png',width=550)
ggplot(res,aes(hour,value))+
  geom_smooth(aes(group=variable,colour=factor(variable)),alpha=0.3,size=2)+
  xlab('Hour')+ylab('Median')+scale_color_brewer(name='Day',palette="Set1")

dev.off()
################### weekdays###################
timeline<-as.matrix(read.table('actions.csv',sep=',',header=F))
tmp<-xts(vector(length=NROW(timeline)),order.by=as.POSIXct(strftime(timeline[,1],'%Y-%m-%d %H:%M:%S')))
tmp[,1]=1

timeline=(aggregate((tmp[,1]),list(factor(format(index(tmp),'%Y-%m-%d'))),sum))
timeline=xts(as.numeric(timeline[,1]),order.by=as.POSIXct(index(timeline)))
timeline=(aggregate((timeline[,1]),list(factor(format(index(timeline),'%a'))),mean))
timeline=data.frame(weekday=index(timeline),count=as.numeric(timeline))

timeline$weekday=factor(timeline$weekday, levels=c( "Mon","Tue","Wed","Thu","Fri", "Sat", "Sun"   ))
png('actions_weekdays.png',width=550)
ggplot(timeline,aes(weekday,count,fill=weekday))+geom_bar()+scale_fill_brewer(name='Weekday',palette="Set1")+xlab('')+ylab('Number of actions')
dev.off()
