import numpy as np


def Entropy(p):
    """
    H(x) = -sum(p*log_p)
    """
    h = -np.sum(p*np.log(p))
    return h


#交叉熵损失函数要除以训练样本数量
def CrossEntropyLoss(y,y_pre):
    n = y.shape[0]
    loss = y*np.log(y_pre)+(1-y)*log(1-y_pre)
    cost = -np.sum(loss)/n

    return cost

