
import numpy as np

def residual_sum_of_squares(y,y_pre):
    """
    RSS = sum(y_i -y_hat)^2

    """
    error = (y-y_pre)**2
    return np.sum(error)

    
