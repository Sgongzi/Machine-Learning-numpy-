
import numpy as np

def sigmoid(z):
    """
    y = 1/(1+e^-x)

    """
    y = 1/(1+np.exp(-z))
    return y 

def sigmoid_derivative(x):
    return sigmoid(x)*(1-sigmoid(x))


def tanh(z):
    """
    tanh(z) = (e^z-e^-z)/(e^z+e^-z)
    
    x= np.linspace(-1,1,10000)
    y = tanh(x)
    plt.plot(x,y)
    """
    a = np.exp(z)+np.exp(-z)
    b = np.exp(z)+np.exp(-z)
    return a/b

def relu(z):
    """
    
    """
    if z>=0:
        return z
    else:
        return 0


def softmax(z):
    """
    z:array-like shape(k,1)
    y = ezi/sumezi
    
    """
    sum = np.sum(np.exp(z))
    return np.exp(z)/sum

