setwd('/home/git/github/')
require('ggplot2')
require(xts)


timeline<-as.matrix(read.table('new_repos.csv',sep=',',header=T))
tmp<-xts(vector(length=NROW(timeline)),order.by=as.POSIXct(strftime(timeline[,1],'%Y-%m-%d %H:%M:%S')))
tmp[,1]=1

timeline=aggregate((tmp[,1]),list(factor(format(index(tmp),'%Y%m%d%H'))),sum)
tmp=data.frame(year=substr(as.character(index(timeline)),1,4),hour=substr(as.character(index(timeline)),9,10),count=(as.numeric(timeline)))

years = subset(tmp,tmp$year=='2012')
res = data.frame(aggregate(years$count,list(years$hour),median),
#sd=aggregate(years$count,list(years$hour),sd)[,2],
                 year=2012)

years = subset(tmp,tmp$year=='2011')
res = rbind(res, data.frame(aggregate(years$count,list(years$hour),median),
                            #sd=aggregate(years$count,list(years$hour),sd)[,2],
                            year=2011))


years = subset(tmp,tmp$year=='2010')
res = rbind(res, data.frame(aggregate(years$count,list(years$hour),median),
#sd=aggregate(years$count,list(years$hour),sd)[,2],
                            year=2010))

years = subset(tmp,tmp$year=='2009')
res = rbind(res, data.frame(aggregate(years$count,list(years$hour),median),
#sd=aggregate(years$count,list(years$hour),sd)[,2],
                            year=2009))

years = subset(tmp,tmp$year=='2008')
res = rbind(res, data.frame(aggregate(years$count,list(years$hour),median),
#sd=aggregate(years$count,list(years$hour),sd)[,2],
                            year=2008))

colnames(res)=c('hour','median','year')

#####log plot######
ggplot(res,aes(hour,log(median)))+
  geom_smooth(aes(group=year,colour=factor(year)),alpha=0.3,size=2)+
  scale_color_brewer(name='Year',palette="Set1")+xlab('Hour')+ylab('Median')

#####normal plot####
ggplot(res,aes(hour,median))+
  geom_smooth(aes(group=year,colour=factor(year)),alpha=0.3,size=2)+
  scale_color_brewer(name='Year',palette="Set1")+xlab('Hour')+ylab('Median')

