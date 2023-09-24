#%%调包
from  math import log

#计算信息熵


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

#构建数据信息
def createDataSet():
    dataSet=[[1,1,'yes'],[1,1,'yes'],[1,0,'no'],[0,1,'no'],[0,1,'no']]
    labels=['no surfacing','flippers']#标签
    return dataSet,labels
#测试函数
mydata,labels=createDataSet()
print(calcShannonEnt(mydata))

#%%
#如何对数据集划分 or怎么样选择分支
#输入：待划分的数据集；属性集合中被选中的那一个（暂时不选择）属性的列表编号，返回的特征的值


def splitDataSet(dataSet,axis,values):
    #空集合
    retdataset=[]
    for idata in dataSet:
        #第axis个属性是否为values
        if idata[axis]==values:
            #第axis属性前的数据添加
            reidata=idata[:axis]
            #第axis属性后的数据添加
            reidata.extend(idata[axis+1:])
            retdataset.append(reidata)
    return retdataset
#测试函数
print(splitDataSet(mydata,0,0))

#%%
#选择最好的划分方法(对一次数据集)

#输入：数据集--数据的格式是列表，最后一个元素是标签
#属性集合a
def chooseBestFeatureToSplit(dataSet):
    #初始化
    baseEntropy=calcShannonEnt(dataSet)
    bestGain=0.0
    #属性集合
    feature=len(dataSet[0])-1
    #判断数据集合的状况
    
    for a in feature:
        # 构建一个属性的值的列表
        featurevalues=[idata[a] for idata in dataSet]
        #去除重复值
        uniquefeaturevalues=set(featurevalues)

        subentropy=0.0
        for f in featurevalues:
            subdataSet=splitDataSet(dataSet,a,f)
            #计算子集的信息熵
            proportion=len(subdataSet)/len(dataSet)
            subentropy=subentropy+proportion*calcShannonEnt(subdataSet)
        Gain=baseEntropy-subentropy
        if (Gain>bestGain):
            bestGain=Gain
            bestFeature=a
    return bestFeature

def decisiontree(dataSet):
    #清单
    y=[idata[-1] for idata in dataSet]
    #终止条件1：类别完全相同，则停止划分
    if set(y)==1:
        return y[0]
    #终止条件2：遍历完毕
    if len(dataSet[0])==1:
        return 
    #开始递归
    bestfeature=chooseBestFeatureToSplit(dataSet)
    #得到最优划分类别的取值列表
    valuelist=[]
    for i in dataSet:
        valuelist.append(i[bestfeature])
    uniquevalue=set(valuelist)
    #得到划分的子集
    for value in uniquevalue:
        subdataSet=splitDataSet(dataSet,bestfeature,value)
    return decisiontree(subdataSet)




