


import numpy as np

def log_likelihood(y,y_pre):
    num_sample = y.shape[0]
    
    #计算误差
    residuals = y-y_pre
    sigma_squared = 1.0/num_sample *np.sum(residuals**2)

    log_1 = -num_sample/2 *np.log(2*np.pi*sigma_squared**2)
    log= log_1-np.sum(residuals**2/sigma_squared)
    return log




