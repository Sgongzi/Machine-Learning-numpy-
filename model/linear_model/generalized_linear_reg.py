import numpy as np
import pandas as pd
from utils.activation import sigmoid
from loss.entropy import CrossEntropyLoss
from .base import LinearModel
from.linear_reg import LinearRegression
from utils.error import PredictError,EvaluateError
import random





#gradient descent
def gradascent(X,y,lr:float,max_iter:int):
    """
    input :
    1.X array-like shape like (num__sample,num_feature+1) <include bias>
    2.y array-like shape like (num_sample,)

    3.lr float if you want use gradient descent you must set a learning rate
    4.max_iter int it determines the number of iterations
    """
    
    X = np.array(X,dtype='float32')
    y = np.array(y,dtype='float32')

    num_sample,num_feature = X.shape 
    w = np.ones((num_feature,))#initialise weight
    costs = [] #a container to collect loss
    for k in range(max_iter): #iterations
        y_pre = sigmoid(np.dot(X,w))
        error = y-y_pre
        dw = np.dot(X.T,error)/num_sample #differ
        w = w+lr*dw
        cost = CrossEntropyLoss(y,y_pre)
        costs.append(cost)
    return w ,costs

#stochastic gradient descent
def stocgradascent(X,y,lr:float,max_iter:int):
    """
    input :
    1.X array-like shape like (num__sample,num_feature+1) <include bias>
    2.y array-like shape like (num_sample,)

    3.lr float if you want use gradient descent you must set a learning rate
    4.max_iter int it determines the number of iterations
    """
    X = np.array(X,dtype='float32')
    y = np.array(y,dtype='float32')
    #just one sample
    num_sample,num_feature =X.shape

    w = np.ones((num_feature,))#initialise weight
    costs = []
    for i in range(max_iter):
        for j in range(num_sample):
            lr = lr*(1/(i+j))+0.01 #adjust learning rate <i>
            randomindex = int(random.uniform(0,num_sample))
            y_pre_i = sigmoid(np.dot(X[randomindex],w))

            error = y[i] - y_pre_i
            dw = error*X[i]
            w = w +lr*dw
        y_pre = np.dot(X,w)
        cost = CrossEntropyLoss(y,y_pre)
        costs.append(cost)

    return w ,costs



def classify(prob,k=0.5):
    #prob = sigmoid(np.dot(X,w))
    if prob>k:
        return 1.0
    else:
        return 0.0



#LogisticRegression
class LogisticRegression(LinearModel):
    """
    parameter:
    learning_rate :float
    max_iter : int
    method str 'sgd' or 'gd'

    
    """
    def __init__(self,method='sgd',*,learning_rate,max_iter):
        self.lr = learning_rate
        self.max_iter = max_iter
        self.method = method

        self.weight = None
        self.loss = None
        self.loss_list = None

    def fit(self,X,y):

        X = np.array(X,dtype='float32')
        y = np.array(y,dtype='float32')

        one_column = np.ones((X.shape[0],1))
        X_adj = np.hstack((X,one_column))

        num_sample,num_feature = X.shape
        if self.method=='sgd':
            trained_w,costs_list = stocgradascent(X_adj,y,lr=self.lr,max_iter=self.max_iter)
            
        elif self.method == 'gd':
            trained_w,costs_list = gradascent(X,y,lr=self.lr,max_iter=self.max_iter)
        else:
            raise ValueError("For method ,you must choose 'sgd' or 'gd'")
        

        self.weight = trained_w
        self.loss_list = costs_list
        self.loss = costs_list[-1]

        return self

    def predict(self,X_test,*,threshold=0.5):
        if self.weight is None:
            raise PredictError('if you want to use a model to predict using ,you must fit it first')
        else:
            y_pre = sigmoid(np.dot(X_test,self.weight))
            label = classify(y_pre,k = threshold)
        return label

    def predict_probability(self,X_test):
        if self.weight is None:
            raise PredictError('if you want to use a model to predict using ,you must fit it first')
        else:
            prob = sigmoid(np.dot(X_test,self.weight))
        return prob
    

    def evaluate(self,y,y_pre):
        if self.weight is None:
            raise EvaluateError('If you want to evaluate a model,you must fit it first')
        else:
            crossentropyloss = CrossEntropyLoss(y,y_pre)
        return crossentropyloss


