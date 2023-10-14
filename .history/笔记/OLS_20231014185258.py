#输入 一组向量X和y



import numpy as np
class OLS():
    #初始化数据Y=XW
    def __init__(self,X,Y):
        self.X=np.array(X)
        self.Y=Y
    
    def minSquareLoss(self):
        w=np.dot(np.linalg.inv(np.dot(self.X.T,self.X)),np.dot(self.X.T,self.Y))
        return w

    def SquareLoss(self):
        Y_hat=np.dot(self.X,w)
        e=self.Y-Y_hat
        loss=np.dot(e.T,e)
        return loss
"""
XW=Y 表示X的列向量的某个线性组合为Y，但是实际情况是找不到这样一组W使得X列向量的线性组合为Y（由于X的列向量的线性组合只存在其子空间S/列空间上），那么把Y做子空间S上的投影得到Y_hat
使得XW=Y_hat成立。
垂线e=Y-Y_hat,正交于X的列空间平面，X^Te=0
解得W=（X^TX)^-1X^TY

"""


#例子
x=np.array([[1,1],[0,1],[2,1]])
y=np.array([[2],[2],[3]])

ols=OLS(x,y)
w=OLS.minSquareLoss()
loss=OLS.SquareLoss()
print(loss)