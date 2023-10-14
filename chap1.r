#chap1 
#1.2 binominal dis,multinominal dis 

norm
t
f
chisq

dbinom(x, size, prob, log = FALSE)
pbinom(q, size, prob, lower.tail = TRUE, log.p = FALSE)
qbinom(p, size, prob, lower.tail = TRUE, log.p = FALSE)
rbinom(n, size, prob)

rmultinom
help.search("multinominal")

rbinom(100, 10, 0.2)
pbinom(q, size, prob, lower.tail = TRUE, log.p = FALSE)

# n=10, pi=0.2, 0.5, 0.8
dbinom(2, 10, 0.2, log = FALSE)         # y=2的概率
pbinom(2, 10, 0.2)                      # y<=2的概率累计和
qbinom(0.95,10,0.2)                     # Pbinom的反运算

qnorm(0.975,0,1)                       #1.96
qnorm(0.025,0,1)                       #-1.96

pnorm(1.96,0,1)



c1<-dbinom(0:10, 10, 0.2, log = FALSE)
c2<-dbinom(0:10, 10, 0.5, log = FALSE)
c3<-dbinom(0:10, 10, 0.8, log = FALSE)
pichange<-cbind(c1,c2,c3)
pinew<-round(pichange,3)

#  pi=0.2, n=10, 100, 1000
pi<-0.4
d1<-dbinom(0:10, 10, pi, log = FALSE)
d2<-dbinom(0:100, 100, pi, log = FALSE)
d3<-dbinom(0:1000, 1000, pi, log = FALSE)

par(mfrow=c(2,3))
plot(c1);lines(c1)
plot(c2);lines(c2)
plot(c3);lines(c3)

plot(d1);lines(d1)
plot(d2);lines(d2)
plot(d3);lines(d3)


#1.3 Inference for a (Single) Proportion
#In the example concerning opinion on abortion, there were
#424 “yes” responses out of 950 subjects. Here is one way to use prop.test to analyze these data:

prop.test(424,950)
prop.test(424,950,p=.5,alternative="two.sided",conf.level=0.95,correct=TRUE)
prop.test(424,950,p=.4,alternative="greater",conf.level=0.99,correct=FALSE)

#?fisher.test/chisq.test chap2

## Agresti (1990, p. 61f; 2002, p. 91) Fisher's Tea Drinker
## A British woman claimed to be able to distinguish whether milk or
##  tea was added to the cup first.  To test, she was given 8 cups of
##  tea, in four of which milk was added first.  The null hypothesis
##  is that there is no association between the true order of pouring
##  and the woman's guess, the alternative that there is a positive
##  association (that the odds ratio is greater than 1).
TeaTasting <-matrix(c(3, 1, 1, 3),       nrow = 2,
       dimnames = list(Guess = c("Milk", "Tea"),
                       Truth = c("Milk", "Tea")))
fisher.test(TeaTasting, alternative = "greater")
## => p = 0.2429, association could not be established



#一元二次方程求解 极端p值或较小n值时的区间  利用显著性检验的二次关系构造区间
#一元二次方程：a*x^2+b*x+c=0，设a=1，b=5，c=6，求x？?uniroot
f2 <- function (x, a, b, c) a*x^2+b*x+c
a<-1;b<-5;c<-6
#a<-n+1.96^2 b<- -(2*n*p+1.96^2) c<- n*p^2

result1 <- uniroot(f2,c(0,-2),a=a,b=b,c=c,tol=0.0001) 
result1$root

result2 <- uniroot(f2,c(-4,-3),a=a,b=b,c=c,tol=0.0001) 
result2$root




