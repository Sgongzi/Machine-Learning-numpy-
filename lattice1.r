library(lattice)
d<-data.frame(x=c(0:45),y=c(1:46),z=c(rep(c("a","b"),times=23)));d
xyplot(y~x,data=d)

xyplot(y~x|z,data=d)   #����������������դ��ͼ
xyplot(y~x,group=z,pch=c(1:2),col=c(1:2),data=d)  #�����������Ƶ�һ��ͼ��
xyplot(y~x|z,pch=c(2:3),col=c(1:2),data=d)


attach(mtcars)
head(mtcars)

xyplot(mtcars$mpg~mtcars$wt|am,
main = "Miles per Gallon vs. Weight by am",
scales = list(cex=.8,col = "red"),   #cex �ַ���СΪԭ����0.8
xlab = "Weight",ylab = "Mile per Gallon",
layout = c(2,1),aspect = 1.5,index.cond = list(c(2,1)))  
#���2*1����壬������1.5��index.cond = list(c(2,1)))�������չʾ˳�� ��չʾam��2��1ˮƽ.������1ˮƽ��2ˮƽ


displacement<-equal.count(mtcars$disp,number=3,overlap=0)      #������������ �������������ɢ�� �����ˮƽ 

mypanel <-function(x,y){
panel.xyplot(x,y,pch=19)           # ���ԲȦ
panel.rug(x,y)                     # ���������
panel.grid(h=-1,v=-1)              # ���ˮƽ����ֱ�������ߣ�ʹ�ø���ǿ�����������ǩ����
panel.lmline(x,y,col = "red",lwd = 1,lty = 2)  #��Ӻ�ɫ�ع������
}


xyplot(mtcars$mpg~mtcars$wt|displacement,
main = "Miles per Gallon vs. Weight by Engine Displacement",
scales = list(cex=.8,col = "red"),
xlab = "Weight",ylab = "Mile per Gallon",
layout = c(3,1),aspect = 1.5,panel = mypanel,index.cond = list(c(2,1,3)))


#��am������Ϊ������չʾam��ֵͬ �����Զ������ֶ���������mpgֵ�Ĵ�С�������ܶ�ͼ


mtcars$transmission <- factor(mtcars$am,levels = c(0,1),labels = c("Automatic","Manual"))
colors <- c("red","blue")
lines <- c(1,2)
points <- c(16,17)

key.trans <- list(title = "Trasmission",space = "bottom",columns = 2,
text = list(levels(mtcars$transmission)),
points = list(pch = points,col = colors),
lines = list(col = colors,lty = lines),
cex.title = 1,cex = .9)

#key��������ӷ��������ͼ������  ͼ������ʲô�ط��������ʽ��Σ���������ʽ����ɫ��

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

