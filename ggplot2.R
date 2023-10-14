#>>>>>>>>>>>>>>>>ggplot2 EDA 20180301<<<<<<<<<<<<<<<<<<<<

install.packages("ggplot2")
library(ggplot2)
data()

ls("package:ggplot2", pattern="^geom_.+") 
ls("package:ggplot2", pattern="^stat_.+")   #参考博客ggplot2作图详解5：图层语法和图形组合
ls("package:ggplot2", pattern="^scale_.+")
ls("package:ggplot2", pattern="^coordinate_.+")

#data 引入及说明
str(mpg) 
factor(mpg$class)

p <- ggplot(data=mpg,mapping=aes(x=cty, y=hwy))
qplot(data=mpg,x=cty, y=hwy)  #等价作图 qplot函数
p + geom_point()

summary(p)
summary(p+geom_point())

p <- ggplot(mpg,aes(x=cty, y=hwy, colour=factor(year))) #将年份映射到颜色属性
p + geom_point()


p + geom_point() + stat_smooth()  #增加平滑曲线

p <- ggplot(mpg, aes(x=cty,y=hwy))
p + geom_point(aes(colour=factor(year)))+
stat_smooth()

#两种等价的绘图方式
p <- ggplot(mpg, aes(x=cty,y=hwy))
p + geom_point(aes(colour=factor(year)))+stat_smooth()
**********************************
> p <- ggplot(mpg, aes(x=cty,y=hwy))
p + geom_point(aes(colour=factor(year)))+stat_smooth()

> d <- ggplot() +
geom_point(data=mpg, aes(x=cty, y=hwy, colour=factor(year)))+
stat_smooth(data=mpg, aes(x=cty, y=hwy))
> print(d)


************************************************

ggplot(data=mpg, aes(x=cty, y=hwy),colour=factor(year)) +stat_smooth(data=mpg, aes(x=cty, y=hwy))

d <- ggplot() +geom_point(data=mpg, mapping=aes(x=cty, y=hwy, colour=factor(year)))+stat_smooth(mpg)



 d<-ggplot(mpg, aes(x=cty, y=hwy, colour=factor(year))) +geom_point(data=mpg, aes(x=cty, y=hwy, colour=factor(year)))
+stat_smooth(mpg)
print(d)
*************************************************


#用标度来修改颜色取值
p + geom_point(aes(colour=factor(year)))+
stat_smooth()+
scale_color_manual(values =c('blue','red'))

#将排量映射到散点大小
p + geom_point(aes(colour=factor(year),size=displ))+
stat_smooth()+
scale_color_manual(values =c('blue2','red4'))

par(mfrow=c())
p + geom_point(aes(colour=factor(year),size=displ),
alpha=0.5,position = "jitter") + stat_smooth()+
scale_color_manual(values =c('blue2','red4'))+
scale_size_continuous(range = c(4, 10))

p + geom_point(aes(colour=factor(year),size=displ),
alpha=0.1) + stat_smooth()+
scale_color_manual(values =c('blue2','red4'))+
scale_size_continuous(range = c(4, 10))


#用坐标控制图形显示的范围
p + geom_point(aes(colour=factor(year),size=displ),
alpha=0.5,position = "jitter")+ stat_smooth()+
scale_color_manual(values =c('blue2','red4'))+
scale_size_continuous(range = c(4, 10))+
coord_cartesian(xlim = c(15, 25),ylim=c(15,40))

#利用facet分别显示不同年份的数据
p + geom_point(aes(colour=class, size=displ),
alpha=0.5, position = "jitter")+ stat_smooth()+
scale_size_continuous(range = c(4, 10))+
facet_wrap(~ year, ncol=1)

#增加图名并精细修改图例
p <- ggplot(mpg, aes(x=cty, y=hwy))
p + geom_point(aes(colour=class,size=displ),
alpha=0.5,position = "jitter")+
stat_smooth()+
scale_size_continuous(range = c(4, 10))+
facet_wrap(~ year,ncol=1)+
#opts(title='汽车油耗与型号')+
labs(y='每加仑高速公路行驶距离',
x='每加仑城市公路行驶距离')+
guides(size=guide_legend(title='排量'),
colour = guide_legend(title='车型',
override.aes=list(size=5)))

#直方图
p<- ggplot(mpg,aes(x=hwy))
p + geom_histogram()


#直方图的几何对象中内置有默认的统计变换
summary(p + geom_histogram())


p + geom_histogram(aes(fill=factor(year),y=..density..), alpha=0.3,colour='black')+
stat_density(geom='line',position='identity',size=1.5, aes(colour=factor(year)))+
facet_wrap(~year,ncol=1)

#条形图
p <- ggplot(mpg, aes(x=class))
p + geom_bar()

#根据计数排序后绘制的条形图
class2 <- mpg$class; class2 <- reorder(class2,class2,length)
mpg$class2 <- class2
p <- ggplot(mpg, aes(x=class2))
p + geom_bar(aes(fill=class2))


#根据年份分别绘制条形图，position控制位置调整方式
p <- ggplot(mpg, aes(class2,fill=factor(year)))
p+geom_bar(position='identity',alpha=0.5)




#根据年份分别绘制条形图，position控制位置调整方式
p <- ggplot(mpg, aes(class2,fill=factor(year)))
p+geom_bar(position='identity',alpha=0.5)

#并立方式
 p+geom_bar(position='dodge')

#叠加方式
 p+geom_bar(position='stack')

#相对比例
 p+geom_bar(position='fill')

#分面显示
 p+ geom_bar(aes(fill=class2))+facet_wrap(~year)

#饼图
 p <- ggplot(mpg, aes(x = factor(1), fill = factor(class))) +
geom_bar(width = 1)
p + coord_polar(theta = "y")

#箱线图
 p <- ggplot(mpg, aes(class,hwy,fill=class))
p+geom_boxplot()

p+ geom_violin(alpha=0.3,width=0.9)+
geom_jitter(shape=21)

#观察密集散点的方法

p <- ggplot(diamonds,aes(carat,price))

head(diamonds)
p + geom_point()

p + stat_bin2d(bins = 60)

p + stat_density2d(aes(fill = ..level..), geom="polygon") +
coord_cartesian(xlim = c(0, 1.5),ylim=c(0,6000))+
scale_fill_continuous(high='red2',low='blue4')


#随机生成100次风向，并汇集到16个区间内 
dir <- cut_interval(runif(100,0,360),n=16)
#随机生成100次风速，并划分成4种强度
mag <- cut_interval(rgamma(100,15),4)
sample <- data.frame(dir=dir,mag=mag)
#将风向映射到X轴，频数映射到Y轴，风速大小映射到填充色，生成条形图后再转为极坐标形式即可
 p <- ggplot(sample,aes(x=dir,y=..count..,fill=mag))
 p + geom_bar()+ coord_polar()

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>时间序列<<<<<<<<<<<<<<<<<<<<<<<<<<<<
install.packages("quantmod")   #自行搜索 定量金融包，可以获取金融类型数据，quantmod 包默认是访问 yahoo finance 的数据，
#其中包括上证和深证的股票数据，还有港股数据。上证代码是 ss，深证代码是 sz，港股代码是 hk，网上有更多数据搜索工具。
library(quantmod)
library(ggplot2)
getSymbols('^SSEC',src='yahoo',from = '1997-01-01') # 从yahoo金融中下载相关数据。后面指出是上证数据。
close <- (Cl(SSEC))
time <- index(close)
value <- as.vector(close)
yrng <- range(value)
xrng <- range(time)

data <- data.frame(start=as.Date(c('1997-01-01','2003-01-01','2012-01-22')),end=as.Date(c('2002-12-30','2012-01-20','2017-02-27')),core=c('江','胡','习'))
data;
timepoint <- as.Date(c('1999-07-02','2001-07-26','2005-04-29','2008-01-10','2010-03-31'))
timepoint;
events <- c('证券法实施','国有股减持','股权分置改革','次贷危机爆发','融资融券试点')
events;
data2 <- data.frame(timepoint,events,stock=value[time %in% timepoint])
data2;
p <- ggplot(data.frame(time,value),aes(time,value))
p + geom_line(size=1,colour='blue')+
geom_rect(alpha=0.1,aes(NULL,NULL,xmin = start, xmax = end, fill = core),ymin = yrng[1],ymax=yrng[2],data = data)+
scale_fill_manual(values = c('green','red','blue'))+
geom_text(aes(timepoint, stock, label = events),data = data2,vjust = -2,size =4)+
geom_point(aes(timepoint, stock),data = data2,size = 5,colour = 'red',alpha=0.5)

#>>>>>>>>>>>>>>>>>>>>>>>华夫格图<<<<<<<<<<<<<<<<<<<<<<<<<

library(circlize)
library(waffle)
require(ggplot2)
require(gtable)
require(grid)
#数据来源直播观察，分析各直播平台的七日观看人气
cols <- c(rgb(red = 0, green = 137, blue = 130, max = 255),
          rgb(red = 236, green = 161, blue = 136, max = 255),
          rgb(red = 109, green = 187, blue = 191, max = 255),
          rgb(red = 127, green = 127, blue = 127, max = 255),
          rgb(red = 150, green = 192, blue = 144, max = 255))
popularity <- c("虎牙(大约11.2亿人)"=17,"斗鱼(大约27.5亿人)"=42,
                "哔哩哔哩(大约2亿人)"=3,"企鹅电竞(大约21.3亿人)"=32,
                "触手(大约3.8亿人)"=6)
waffle(popularity,rows=8,size=4,colors=cols,xlab='')




install.packages("circlize")
install.packages("waffle")
install.packages("gtable")
#install.packages("grid")

library(circlize)
library(waffle)
require(ggplot2)
require(gtable)
require(grid)
mat<-matrix(c(1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4),nrow=4,ncol=85,byrow=TRUE)
colnames(mat)<-c('斐语','加泰罗尼亚语','丹麦语','荷兰语','法语','加利西亚语','意大利语','挪威语', '葡萄牙语','罗马尼亚语','西班牙','瑞典语','德语','印尼语','爪哇语', '牙买加语','马来语','斯瓦希里语','阿尔巴尼亚语','阿姆哈拉语','亚美尼亚语','阿塞拜疆语','白俄罗斯语','孟加拉语','波斯尼亚语','保加利亚语','缅甸语','宿务语','克罗地亚语','捷克语','宗喀语','爱沙尼亚语','芬兰语','格鲁吉亚语','希腊语','古吉拉特语','希伯来语','印地语','匈牙利语','冰岛语','伊洛果语','爱尔兰语','埃纳德语','哈萨克语','库尔德语','吉尔吉斯语','高棉语','老挝语','拉脱维亚语','立陶宛语','马其顿语','马拉地语','蒙语','尼泊尔语','普什图语','波斯语','波兰语','旁遮普语','俄语','赛尔维亚语','僧加罗语','斯洛伐克','斯洛维尼亚语','索马里语','菲律宾语','泰米尔语','巴利语','泰卢固语','德顿语','泰语','土耳其语','土库曼语','乌克兰语','乌尔都语','乌兹别克语','越南语','科萨语','祖鲁语','阿拉伯语','粤语','日语','韩语','普通话','台语','吴语')
rownames(mat)<-c('575-600 小时','750-900 小时','1100 小时','2200 小时+')

cols <- c(rgb(red = 0, green = 137, blue = 130, max = 255),
          rgb(red = 236, green = 161, blue = 136, max = 255),
          rgb(red = 109, green = 187, blue = 191, max = 255),
          rgb(red = 196, green = 189, blue = 151, max = 255),
          rgb(red = 127, green = 127, blue = 127, max = 255),
          rgb(red = 250, green = 192, blue = 144, max = 255))
languages<-c('汉语 (大约 1,190,000,000 人)'=17,'西班牙语 (大约 420,000,000 人)'=6,'英语 (大约 350,000,000 人)'=5,'印地语 (大约 280,000,000 人)'=4,'阿拉伯语 (大约 210,000,000 人)'=3,'其他语言 (大约 4,550,000,000 人)'=65)
waffle(languages,rows=8,size=4,colors=cols,xlab='') +  ggtitle("")
languages

#>>>>>>>>>>>>>>>>>>>>>>>>>>> 地图 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

install.packages("maps")

install.packages("maptools")

install.packages("directlabels")

install.packages("mapproj")

install.packages("plyr")

install.packages("ggsubplot")

install.packages("reshape2")

library(maps)
library(ggplot2)
library(maptools)
library(directlabels)
library(mapproj)
library(plyr)
library(ggsubplot)
library(reshape2)

#>>>>>>>>>>>>>>>>>>>>>>>>>>   2017.02.02     <<<<<<<<<<<<<<<<<<
#在R中绘制地图其实是十分方便的，最直接的办法大概就是安装maps和mapdata这两个包

install.packages("mapdat")

library(maps)
library(mapdat)
map("china")

https://segmentfault.com/a/1190000002890587

http://www.cnblogs.com/speeding/p/4094126.html

#>>>>>>>>>>>>>>>>>>>>>>>>>>        <<<<<<<<<<<<<<<<<<


#载入地图数据
setwd("C:/Work/Teaching Cufe/EDA/2017/Lecture 01 ggplot2/china-province-border-data/")
mymap <-readShapePoly("bou2_4p.shp")#读取地图

mymapd <- fortify(mymap)#打散地图为数据框，方便ggplot读取
## Regions defined for each Polygons
temp<-mymap@data#提取地图省份
plot(mymap)
xs<-data.frame(temp,id=seq(0:924)-1)#给省份编写id
china_mapdata<-join(mymapd, xs, type = "full") #将打散的数据以省份分组
#载入年鉴数据
healthdata <- read.csv("C:/Work/Teaching Cufe/EDA/2015/Lecture 17 ggplot2/healthdata.csv", header = T, sep = ",", stringsAsFactors = F)#读取历史数据
healthdata <- healthdata[-c(1:3),]#去除前三行无用数据
summary(healthdata)
#调整药品市场数据
NAME <- healthdata$数据库.分省季度数据 #提取省份名称
hdoct <- cbind(healthdata$X,NAME) #提取各省药品费用
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

mydata1 <- data.frame(NAME) #mydata1 <- data.frame(NAME, hdoct/100000000)

hdoct <- data.frame(hdoct)
mydata1<-join(mydata1,xs, type = "full")
mydata2<-join(xs,hdoct, by="NAME",type = "full")

dim(mydata1)
head(mydata2)

mydata1 <- data.frame(NAME = mydata1$NAME,各地药费用=mydata2$V1, id = mydata1$id)

myepidat <- data.frame(id = unique(sort(mymapd$id)))

myepidat<-join(myepidat, mydata1, type = "full")#给地图配上数据
temp <- data.frame(NAME = healthdata$NAME,lat=healthdata$lat, long = healthdata$long)#给各地名称一个经纬度

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#医院药品市场地图
theme_opts <- list(theme(

panel.grid.minor = element_blank(),#设置网格线为空
                         #panel.grid.major = element_blank(),#你可以去掉
                         panel.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置图版背景色
                         plot.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置绘图区背景色
                         panel.border = element_blank(),
                         legend.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),#以上全是设置xy轴
                         plot.title = element_text(size=10)))


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


p<-ggplot(myepidat)

ggplot(myepidat) + geom_map(aes(map_id = id, fill = mydata2$V1), color = "white", map = mymapd) +
# geom_point(data = temp,aes(x=long, y = lat,fill = NULL),colour = rgb(red = 165, green = 165, blue = 165, max = 255)) 
#+  geom_dl(data = temp,aes(x = long, y = lat,label = NAME), list('last.points',cex = 0.7, hjust = 1))+ 
  scale_fill_gradient(name="", high = rgb(red = 254, green = 67, blue = 101, max = 255),low = rgb(red = 162, green = 162, blue = 145, max = 255),  breaks = c(0, 103, 153, 153, 202, 317, 581)) +
  expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map()+  theme_opts + theme(legend.text=element_text(size=10))



mydata2$V1




ggplot(myepidat) + geom_map(aes(map_id = id, fill = 各地药费用), color = "white", map = mymapd) +
  geom_point(data = temp,aes(x=long, y = lat,fill = NULL),colour = rgb(red = 165, green = 165, blue = 165, max = 255)) 
+  geom_dl(data = temp,aes(x = long, y = lat,label = NAME), list('last.points',cex = 0.7, hjust = 1))+ 
  scale_fill_gradient(name="", high = rgb(red = 254, green = 67, blue = 101, max = 255),low = rgb(red = 162, green = 162, blue = 145, max = 255),  breaks = c(0, 103, 153, 153, 202, 317, 581)) +
  expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map()+  theme_opts + theme(legend.text=element_text(size=10))


 #####geom_dl(data = temp,aes(x = long, y = lat,label = NAME), list('last.points',cex = 0.7, hjust = 1))设置省会标签，让省会标签随机移动一点距离以免过分重叠

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#调整卫生技术人员数数据
NAME <- healthdata$NAME #提取省份名称
hdoct <- healthdata$卫生技术人员 #卫生技术人员
n <- cut(hdoct, breaks = quantile(hdoct, probs = seq(0, 1,0.2)))#将卫生技术人员数据按百分位数分层
mydata1 <- data.frame(NAME, hdoct,n)
x <- unique(n)
x[6] <- n[2]
write.csv(x,"rgb.csv")
mydata1[is.na(mydata1$n) , "n"] <- n[2]
mydata1<-join(mydata1, xs, type = "full")


## Joining by: NAME
mydata1 <- data.frame(NAME = mydata1$NAME,n=mydata1$n, id = mydata1$id)

n=mydata1$n;n
id = mydata1$id;id


myepidat <- data.frame(id = unique(sort(mymapd$id)))
myepidat<-join(myepidat, mydata1, type = "full")
## Joining by: id
temp <- data.frame(NAME = healthdata$NAME,lat=healthdata$lat, long = healthdata$long)#给各地名称一个经纬度
#卫生技术人员地图
cols <- c(rgb(red = 131, green = 175, blue = 155, max = 255),
          rgb(red = 200, green = 200, blue = 169, max = 255),
          rgb(red = 249, green = 205, blue = 173, max = 255),
          rgb(red = 252, green = 157, blue = 154, max = 255),
          rgb(red = 254, green = 67, blue = 101, max = 255))
ggplot(myepidat) + geom_map(aes(map_id = id, fill = n), color = "white", map = mymapd) +
  geom_point(data = temp,aes(x = long, y = lat,fill = NULL),
             colour = rgb(red = 165, green = 165, blue = 165, max = 255)) +
  geom_dl(data = temp,aes(x = long, y = lat,label = NAME), 
          colour = rgb(red = 38, green = 38, blue = 38, max = 255),
          list('last.points',cex = 0.7, hjust = 1))+
  scale_fill_manual(name = "",values = cols, labels = element_blank()) + 
  expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map() +
  theme_opts + 
  theme(legend.position = "bottom", legend.box = "horizontal")#legend.position=c(.5,0.9)
#调整医院数数据
NAME <- healthdata$NAME #提取省份名称
hdoct <- healthdata$医院合计 #提取各省药品费用
mydata1 <- data.frame(NAME, hdoct)
mydata1<-join(mydata1, xs, type = "full")

## Joining by: NAME
mydata1 <- data.frame(NAME = mydata1$NAME,医院合计=mydata1$hdoct, id = mydata1$id)
myepidat <- data.frame(id = unique(sort(mymapd$id)))
myepidat<-join(myepidat, mydata1, type = "full")#给地图配上数据
## Joining by: id
temp <- data.frame(NAME = healthdata$NAME,lat=healthdata$lat, long = healthdata$long)#给各地名称一个经纬度我们将医院的数据仍然按连续变量做图，把数据准备好们就可以做图了，另外标签的区间仍然使用百分位数划分。
ggplot(myepidat) + geom_map(aes(map_id = id, fill = 医院合计), color = "white", map = mymapd) +
  geom_point(data = temp,aes(x = long, y = lat,fill = NULL),
             colour = rgb(red = 165, green = 165, blue = 165, max = 255)) +
  geom_dl(data = temp,aes(x = long, y = lat,label = NAME),
          list('last.points',cex = 0.7, hjust = 1))+
  scale_fill_gradient(name="",
                      high = rgb(red = 254, green = 67, blue = 101, max = 255),
                      low = rgb(red = 162, green = 162, blue = 145, max = 255),
                      breaks = c(145, 350, 570, 915, 1174, 1783)) + 
  expand_limits(x = c(73, 136), y = c(6, 54)) + coord_map()+
  theme_opts
##需要注意的是连续变量'scale_fill_gradient'的填充和非连续变量scale_fill_manual的填充方式是不一样的。


#医院床位数
theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         panel.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置图版背景色
                         plot.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设置绘图区背景色
                         panel.border = element_blank(),
                         legend.background = element_rect(fill=rgb(red = 242, green = 242, blue = 242, max = 255)),#设施图例背景色
                         legend.key = element_rect(colour = rgb(red = 242, green = 242, blue = 242, max = 255),
                                                   fill = rgb(red = 242, green = 242, blue = 242, max = 255)),#设置图例填充色
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
                         plot.title = element_text(size=10)))
p <- ggplot(data = mymapd) +
  geom_polygon(aes(x = long, y = lat, group = id), 
               colour = rgb(red = 165, green = 165, blue = 165, max = 255),
               fill = NA) +
  coord_map()+
  theme_opts
p <- p + geom_point(data = healthdata, aes(x=long, y=lat, size = 床位数),
                    position=position_jitter(width=.5, height=1),#标签位置随机移动
                    color=rgb(red = 254, green = 67, blue = 101, max = 255), alpha = 0.8) + 
  scale_size_area(name="床位数",breaks = c(104011, 106071, 150921, 188396, 300431, 489737), max_size=15) 
p + geom_dl(data = healthdata,aes(x=long, y=lat,label=省会), 
            colour = rgb(red = 175, green = 175, blue = 175, max = 255),
            list('last.points', cex = 0.8, hjust = 1))



#>>>>>>>>>>>>>>>>>制作面积图<<<<<<<<<<<<<<<<<

set.seed(3)
t.step<-seq(0,20)  #创建时间序列（0-20的time step)
grps<-letters[1:10] # 创建十组变量名（从a到j)
grp.dat<-runif(length(t.step)*length(grps),5,15) # 创建一个由随机数组成的十组变量的时间序列
grp.dat<-matrix(grp.dat,nrow=length(t.step),ncol=length(grps))  # 为绘图而创建所需的dataframe
grp.dat<-data.frame(grp.dat,row.names=t.step)
grp.dat
# 用ggplot2完成
p.dat<-data.frame(step=row.names(grp.dat),grp.dat,stringsAsFactors=F)
p.dat<-melt(p.dat,id='step')
p.dat$step<-as.numeric(p.dat$step)

# 导入ggplot2，以及绘制面积图，代码如下：
require(ggplot2)
library(reshape2)
require(gridExtra)

# 绘制面积图

head(p.dat);p.dat
p<-ggplot(p.dat,aes(x=step,y=value),col=c('red','lightgreen','purple'))
p1<-p + geom_area(aes(fill=variable))+ theme(legend.position="bottom")  #不填满
p2<-p + geom_area(aes(fill=variable),position='fill')  #可以展示成分数据，时间序列数据 可以比较清楚的看到不同组成部分的比例。

summary(p1);print(p1)
summary(p2);print(p2)


#>>>>>>>>>>>>>>>>>>>>交互式图形<<<<<<<<<<<<<<<<<

attach(mpg)
plot(cty, hwy)
locator(n =2, type = "n") #type: n,p,l,o
locator(n =2, type = "l")  #作直线
plot(locator(n =2, type = "b"))

plot(cty)
identify(cty)  #找到指定点的x坐标 

require(graphics) 
hca <- hclust(dist(USArrests)) 
plot(hca) 
(x <- identify(hca))
print

plot(-1:1, -1:1, type = "n", xlab = "Re", ylab = "Im")
K <- 20; 
text(exp(1i * 2 * pi * (1:K) / K), col = 2)