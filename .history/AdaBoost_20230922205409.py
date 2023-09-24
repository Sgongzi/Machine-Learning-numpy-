#%% 需要的库

#输入 1.训练集(X,y) ,X输入是一个m*n的矩阵，y是一个向量 2. 基学习算法 3. 训练轮数（or学习器的数量）

#%%
#定义一个AdaBoost类
class AdaBoost:
    #定义训练次数T
    def __init__(self,n_learners):
        self.n_learners=n_learners
    #初始化样本权值
    def fit(self,X,y):

        a=np.full()


