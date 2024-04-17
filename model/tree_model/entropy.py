
#calculate the entropy

import numpy as np
from math import log

def entropy(ele):
    """
    ele:取值类别的列表
    H(x) = -sum(p*log_p)
    """
    probs = [ele.count(i)/len(ele) for i in set(ele)]
    entropy = -sum([prob*log(prob,2) for prob in probs])
    
    return entropy



# gini
def gini(ele):
    """
    nums : 类别列表
    
    """ 
    probs = [ele.count(i)/len(ele) for i in set(ele)]
    gini = sum([p*(1-p) for p in probs])
    return gini

