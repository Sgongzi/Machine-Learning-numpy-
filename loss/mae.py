import numpy as np

def mae(y,y_pre):
    num_sample = y.shape[0]
    loss = np.sum(abs(y-y_pre))
    return loss/num_sample