#%% 需要的库
import numpy as np




#输入 1.训练集(X,y) ,X输入是一个m*n的矩阵，y是一个向量 2. 基学习算法 3. 训练轮数（or学习器的数量）

#%%
#定义一个AdaBoost类
class AdaBoost:
    #定义训练次数T
    def __init__(self,n_learners):
        self.n_learners=n_learners
    #
    def fit(self,X,y):
        #得到X的结构
        m,n=X.shape
        #初始化样本权值
        a=np.full(m,(1/m))
        #循环
        for i in range(1,n_learners+1):
            #单个分类学习器的训练(例子：基于决策树)
            learner=DecisionTree()
            #定义误差
            for j in range(n):
                

            #权重计算
            learner.a=0.5*np.log((1.0-error)/error)
            




