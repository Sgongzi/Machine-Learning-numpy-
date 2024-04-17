

import numpy as np

def L1loss(y,y_pre,w,alpha):
    """
    (y-wx)^2 +lambda|w|
    """
    num_sample = y.shapep[0]

    mse = np.sum((y_pre-y)**2)/num_sample
    L1 = alpha*np.sum(abs(w))
    return mse+L1


def L2loss(y,y_pre,w,alpha):
    """
    (y-wx)^2 +lambda|w|^2
    """
    num_sample =y.shape[0]

    mse = np.sum((y-y_pre)**2)/num_sample
    L2 = alpha *np.sum(w*w)
    return mse+L2
