setwd('/home/git/githubdata/')
require('ggplot2')
require(wordcloud)
require(RColorBrewer)

png('cpp.png',width=550)
timeline<-as.matrix(read.table('cpp.csv',sep=' ',header=F))[60:100,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('javascript.png',width=550)
timeline<-as.matrix(read.table('javascript.csv',sep=' ',header=F))
timeline=timeline[which(!timeline[,1]=='javascript'),][60:99,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('java.png',width=550)
timeline<-as.matrix(read.table('java.csv',sep=' ',header=F))
timeline=timeline[which(!timeline[,1]=='java'),][60:99,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('r.png',width=550)
timeline<-as.matrix(read.table('r.csv',sep=' ',header=F))
timeline=timeline[60:100,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('python.png',width=550)
timeline<-as.matrix(read.table('python.csv',sep=' ',header=F))
timeline=timeline[which(!timeline[,1]=='python'),][60:99,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('ruby.png',width=550)
timeline<-as.matrix(read.table('ruby.csv',sep=' ',header=F))
timeline=timeline[which(!timeline[,1]=='ruby'),][60:99,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()

png('shell.png',width=550)
timeline<-as.matrix(read.table('shell.csv',sep=' ',header=F))
timeline=timeline[70:100,]
wordcloud((timeline[,1]),(as.double(timeline[,2])),rot.per=.15,colors=brewer.pal(8,"Dark2"))
dev.off()
