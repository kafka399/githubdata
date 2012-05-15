setwd('/home/git/githubdata/')
require('ggplot2')
require(xts)
require(rgdal)
require(maptools)

#############load world map###############
# Data from http://thematicmapping.org/downloads/world_borders.php.
# Direct link: http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip
# Unpack and put the files in a dir dsn

world.map <- readOGR(dsn="/home/git/githubdata/", layer="TM_WORLD_BORDERS_SIMPL-0.3",input_field_name_encoding="latin1")
for(i in 1:length(names(world.map))) {
  if (class(world.map[[i]]) == "factor") {
    world.map[[i]] <- factor(iconv(world.map[[i]], from="latin1", to="utf-8"))
  }
}
gpclibPermit()
world.ggmap <- fortify(world.map, region = "NAME")

world.ggmap=world.ggmap[which(world.ggmap$lat>(-55)),]
world.ggmap=world.ggmap[which(world.ggmap$long>(-165)),]
world.ggmap=world.ggmap[which(world.ggmap$long<(175)),]
#################end########################



timeline<-as.matrix(read.table('tmp2.csv',sep=';',header=F))
tmp<-xts(timeline[,2],order.by=as.POSIXct(strftime(timeline[,1],'%Y-%m-%d %H:%M:%S')))

tmp[,1]=paste(toupper(substring(tmp[,1],1,1)),substring(tmp[,1],2),sep='')

temp=unlist(sapply(strsplit(as.character(tmp[,1]), " "), function(x){x[length(x)]}))
temp=paste(toupper(substring(temp,1,1)),substring(temp,2),sep='')
tmp[,1]=temp



nasa=(aggregate(temp,list(temp), length))
nasa=nasa[tail(order((nasa[,2])),30),]

hours=factor(format(index(tmp),'%Y-%m-%d %H'))
days=factor(format(index(tmp),'%Y-%m-%d'))

for(y in 1:200)
{

hourly=as.data.frame(tmp[which(levels(hours)[y]==hours),])
hourly=aggregate(hourly,list(hourly[,1]),length)


daily=as.data.frame(tmp[which(substring(levels(hours)[y],1,10)==days),])
daily=aggregate(daily,list(daily[,1]),length)

rez=nasa
for(i in 1:NROW(nasa))
{
  
  a=(hourly[which(as.character(nasa[i,1])==as.character(hourly[,1])),2]/
    daily[which(as.character(nasa[i,1])==as.character(daily[,1])),2])*100
  if(length(a)>0)
    rez[i,2]=a
  else
    rez[i,2]=0
}
#rez[,2]=factor(cut(round((rez[,2])),breaks=seq(from=0,to=17,by=3),include.lowest=TRUE,labels=seq(from=5,to=50,by=5)),               )

rez[which(rez[,1]=='Korea'),1]=c('Korea, Republic of')
rez[which(rez[,1]=='Usa'),1]=c('United States')
rez[which(rez[,1]=='Uk'),1]=c('United Kingdom')
rez[which(rez[,1]=='Czech'),1]=c('Czech Republic')
rez[which(rez[,1]=='Zealand'),1]=c('New Zealand')

df=cbind(world.ggmap,col=-1)
for(i in 1:NROW(rez))
{
  df[which(df$id == rez[i,1]),8]=as.numeric(rez[i,2])
}
a=cut(df$col,breaks=c(seq(from=-2,to=8,by=2),100),include.lowest=T)
levels(a)=c('#999999','#ffe6e6','#ffbfbf','#ff8080','#ff4040','#bf0000')
#levels(a)=c('#999999','#d90000','#bf0000' ,'#800000' 	,'#400000')
jpeg(paste('img',y,'.jpg',sep=''),width=650,quality=100)
print(ggplot(df, aes(map_id = id)) +
  geom_map(aes(fill = a), map =world.ggmap) +
  expand_limits(x = world.ggmap$long, y = world.ggmap$lat) +
  scale_fill_identity(guide = "none")+xlab(levels(hours)[y])+ylab(""))
dev.off()

}