
import numpy as np

def mse_loss(y,y_pre):
    """
    input 
    y:array 
    """
    num_train = y.shape[0]
    loss = np.sum((y_pre-y)**2)/num_train
    return loss


