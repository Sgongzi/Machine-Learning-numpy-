#%% 需要的库
import numpy as np

#%%
#弱学习器数组构建



#输入 1.训练集(X,y) ,X输入是一个m*n的矩阵，y是一个向量 2. 基学习算法数组（包含多个弱学习器） 3. 训练轮数（or学习器的数量）

#%%
#定义一个AdaBoost类
class AdaBoost:
    #定义训练次数T
    def __init__(self,learners):
        self.n_learners=len(learners)
        self.learners=learners


    def fit(self,X,y):
        #得到X的结构(X为一个矩阵)
        dataMatrix=np.mat(X)
        m,n=dataMatrix.shape
        #初始化样本权值
        a=np.full(m,(1/m))
        #循环
        for i in range(1,self.n_learners+1):
            #单个分类学习器的训练
            