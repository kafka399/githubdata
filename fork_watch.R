setwd('/home/git/githubdata/')
require('ggplot2')
require(xts)


timeline<-as.matrix(read.table('fork_watch.csv',sep=' ',header=F))

rez=data.frame(forks=(as.numeric((timeline[,2]))+1),watchers=(as.numeric((timeline[,3]))+1))
rez$forks[rez$forks<1]=1
rez$watchers[rez$watchers<1]=1
#ggplot(rez,aes(log(forks),log(watchers)))+geom_point()

png('fork_watch.png',width=550)
ggplot(rez,aes(log(forks),log(watchers)))+geom_point(alpha=0.2,colour='#ff6600')+
  geom_abline(intercept=4.5,slope=0.8, linetype='dashed',size=1.5,colour='#336699')+geom_abline(intercept=-2,slope=1.1951,, linetype='dashed',size=1.5,colour='#336699')+
  xlab('Forks')+ylab('Watchers')
dev.off()

tmp=cbind(log(rez$watchers),log(rez$forks))
#more forks than watchers
timeline[which(tmp[,1]<(tmp[,2]*1.1951-2) ),]

#projects, where rate of watchers is very high
timeline[which(tmp[,1]>(tmp[,2]*.8+4) ),]
