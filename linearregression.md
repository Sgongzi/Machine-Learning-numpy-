# linear regression

<aside>
💡 关于机器学习，线性模型linear regression，有很多超级优秀的教材和Blog，课程等等，但是我还是想写一点自己的理解和阅读资料后的一些总结和思考，并不适合零基础，只是自己留个存档，然后开源学习。

</aside>

$$
y = WX+b+\epsilon
$$

## 1.linear regression 的基本原理

我认为最传统的linear regression可以从两个角度去理解。一个是数值的方法。一个是概率的角度。从数值的角度来分析，线性回归是用一条直线（平面）或者更高维的但是线性的形式去拟合$X,y$，或者说使用一个$X$的线性组合去预测$y$。一般的拟合方法就是$ols$.

从这个角度来看，我们要使用最小二乘去优化参数$W$

最小二乘使用的是预测值和真实值的欧氏距离的概念，通过优化模型的均方误差（MSE）来得到最佳估计值。*

优化目标（object function)如下

$$
E = \sum_{i=1}^{m} (y_i-wx_i-b)^2
$$

下面以矩阵的形式表达：

1.优化目标

$$
w* = (y-XW)^T(y-XW)
$$

2.对上述优化目标求导得到

$$
\frac{\partial E}{\partial w} = 2X^T(XW -y)
$$

还有一个概率论的角度理解线性回归。概率论里有种重要的估计参数的方法，那就是大名鼎鼎的极大似然估计。一句话概括极大似然就是，给定一个经验分布或者说一组数据，那么这给分布或者数据最可能来自哪个分布（确定一个参数）。

对于一个回归问题，在统计学中有一个假设，那么就是误差项服从一个均值为0，方差恒定的一个正态分布。在一般的统计学中的线性回归问题$X$并不是一个随机变量，那么我们有

$$
p(\epsilon) = \frac{1}{\sqrt{2\pi}\sigma} exp(-\frac{\epsilon^2}{2\sigma^2})
$$

等价替换后得到

$$
p(\epsilon) = \frac{1}{\sqrt{2\pi}\sigma} exp(-\frac{(y-w^Tx)^2}{2\sigma^2})
$$

极大似然连乘积得到

$$
L(w) = \prod_{i=1}^{n}\frac{1}{\sqrt{2\pi}\sigma} exp(-\frac{(y-w^Tx)^2}{2\sigma^2})
$$

取对数得到对数似然函数

$$
lnL(w) = \sum_{i=0}{n}ln\frac{1}{\sqrt{2\pi}\sigma}exp(-\frac{(y_i-w^Tx_i)^2}{2\sigma^2})=mln\frac{1}{\sqrt{2\pi}\sigma}-\frac{1}{2\sigma^2}\sum_{i=1}^n (y_i-w^Tx_i)^2
$$

由于假设前提假设，$\sigma$为常数。因此本质也是最小化$\sum_{i=1}{n}(y_i-w^Tx_i)^2$

## 优化方法

### 1.求闭式解

一般来说就是直接通过$W=(X^TX)^{-1}X^TY$求解，重点是要求解$X^TX$的逆。

一般来说计算机有很多数值分析的方法求矩阵的逆，对求逆有兴趣的可以看看C++的engin库。但是如果存在多重共线性，这个要求逆的矩阵的数值将非常不稳定。

## 2.梯度下降

梯度下降在另一篇优化的文件再说。

## 评价

### $R^2$

$R^2$衡量模型的拟合优度，通过方差分析的方法分解回归模型，SST为总平方和，也就是所有的观测值和均值的差的平方和。SSR为回归平方和，表示的是模型的预测值和均值的差的平方和。在机器学习中，$R^2$越高意味着拟合能力越强，但是可能模型中包含着大量的无关变量，并不意味着模型就是最佳模型。

$$
R^2 = \frac{SSR}{SST}
$$

### MSE

$$
MSE = \frac{1}{n} \sum_{i-1}^n(y_i-y_{pre}i)^2
$$

可以直接理解为标签值和预测值的欧式距离，这个评价指标或者Loss处处可导，有比较好的数学性质，并且由于平方项，对error是存在惩罚的，对异常值敏感。

## 高斯马尔可夫定理

在经典线性回归模型的假设下（线性、独立、同分布的误差项，且具有常数方差），估计量是blue的。

（Best Linear Unbiased Estimator）属性指的是最佳线性无偏估计量。当估计量$W$满足下面的条件。

1.线性性；也就是说，估计量是参数的线性函数； 

2.无偏性 $E(w) = w$

3.最小方差 <在所有的无偏估计中，方差最小

## 特征选择

为什么要做特征选择呢？单说线性模型来说，对于计量或者统计学的解释性角度来说，由于多重共线性的出现，一方面导致闭式解中求逆困难，并且数值变得很不问题，并且模型的系数将不再具有解释性。对于机器学习的预测问题，因为模型会存在一个过拟合问题，也就是说你的训练误差越小，测试误差不一定越小，模型是需要有泛化能力。



## ridge regression 和 lasso

当正规方程的解析是不可逆的,加入一个估计项；$w = (X^TX+\lambda I)^{-1}X^Ty$

或者在估计方程中加入一个L2正则化。

使用拉格朗日法求解

对于一个lasso可以把问题设为

$$
min \frac {1}{n} \sum(w^Tx_i+b-y_i)^2  s.t |w|<t
$$

而一个ridge reg可以把问题设为

$$
min \frac {1}{n} \sum(w^Tx_i+b-y_i)^2  s.t |w|^2<t
$$

以二维为例子，绘制一个线性的空间，那么可以看出lasso可以把无关变量的系数收缩到0.

![Untitled](linear%20regression%202e3caa64699b4b6f8d37b4f5f2d15ed0/Untitled.png)