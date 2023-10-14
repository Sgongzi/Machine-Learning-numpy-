library(lattice)
d<-data.frame(x=c(0:45),y=c(1:46),z=c(rep(c("a","b"),times=23)));d
xyplot(y~x,data=d)

xyplot(y~x|z,data=d)   #按照条件变量绘制栅栏图
xyplot(y~x,group=z,pch=c(1:2),col=c(1:2),data=d)  #将两个面板绘制到一副图中
xyplot(y~x|z,pch=c(2:3),col=c(1:2),data=d)


attach(mtcars)
head(mtcars)

xyplot(mtcars$mpg~mtcars$wt|am,
main = "Miles per Gallon vs. Weight by am",
scales = list(cex=.8,col = "red"),   #cex 字符大小为原定的0.8
xlab = "Weight",ylab = "Mile per Gallon",
layout = c(2,1),aspect = 1.5,index.cond = list(c(2,1)))  
#输出2*1个面板，面板宽长比1.5，index.cond = list(c(2,1)))决定面板展示顺序 先展示am的2后1水平.还是先1水平再2水平


displacement<-equal.count(mtcars$disp,number=3,overlap=0)      #将发动机排量 这个连续变量离散化 变成三水平 

mypanel <-function(x,y){
panel.xyplot(x,y,pch=19)           # 填充圆圈
panel.rug(x,y)                     # 添加轴虚线
panel.grid(h=-1,v=-1)              # 添加水平和竖直的网格线，使用负数强制他们与轴标签对齐
panel.lmline(x,y,col = "red",lwd = 1,lty = 2)  #添加红色回归拟合线
}


xyplot(mtcars$mpg~mtcars$wt|displacement,
main = "Miles per Gallon vs. Weight by Engine Displacement",
scales = list(cex=.8,col = "red"),
xlab = "Weight",ylab = "Mile per Gallon",
layout = c(3,1),aspect = 1.5,panel = mypanel,index.cond = list(c(2,1,3)))


#将am变量作为条件，展示am不同值 汽车自动档和手动档样本的mpg值的大小，且做密度图


mtcars$transmission <- factor(mtcars$am,levels = c(0,1),labels = c("Automatic","Manual"))
colors <- c("red","blue")
lines <- c(1,2)
points <- c(16,17)

key.trans <- list(title = "Trasmission",space = "bottom",columns = 2,
text = list(levels(mtcars$transmission)),
points = list(pch = points,col = colors),
lines = list(col = colors,lty = lines),
cex.title = 1,cex = .9)

#key函数，添加分组变量的图例符号  图例放在什么地方，字体格式如何，线条的形式和颜色。

densityplot(~mpg,data = mtcars,groups = transmission,
main = "MPG Distribution by Transmission Type",
xlab = "Mile per Gallon",
pch = points,lty = lines,col = colors,lwd = 2,jitter = .005,
key = key.trans)

dotplot(mpg ~ wt)
levelplot(mpg~qsec*wt)
cloud(mpg~qsec*wt)

wireframe(volcano)
levelplot(volcano)
contourplot(volcano)

