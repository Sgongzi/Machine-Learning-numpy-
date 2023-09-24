#%%调包
from  math import log

#输入数据集合dataSet

def calcShannonEnt(dataSet):

    #数据集长度---样本量的大小
    numEntrues=len(dataSet)
    #创建字典
    labelCounts={}

    for featVec in dataSet:
        #最后一个为数据类型标签
        currentLabel=featVec[-1]
        #数据类型不在字典键内，那么将标签加入字典 字典模式： {标签类型：数量}
        if currentLabel not in labelCounts.keys():
            labelCounts[currentLabel]=0
        labelCounts[currentLabel]+=1
    #初始化
    shannonEnt=0.0
    #遍历字典
    for v in labelCounts.values():
        #单个类型的占比
        prob = v/numEntrues
        shannonEnt+=(-1)*prob*log(prob,2)
    return shannonEnt

def createDataSet():
    dataSet=[[1,1,'yes'],[1,1,'yes'],[1,0,'no'],[0,1,'no'],[0,1,'no']]
    labels=['no surfacing','flippers']#标签
    return dataSet,labels

mydata,labels=createDataSet()
print(calcShannonEnt(mydata))

