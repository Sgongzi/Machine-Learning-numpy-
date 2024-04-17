
import numpy as np
import pandas as pd
import scipy

from itertools import combinations

import scipy.linalg

from.linear_reg import LinearRegression
from loss.mse import mse_loss
from loss.likelihood import log_likelihood
from loss.rss import residual_sum_of_squares
from data.kfold import KFold
from utils.sign import sign
from loss.regularization import L1loss,L2loss
from utils.error import PredictError,EvaluateError
from .base import LinearModel


class BestSubsetRegression(LinearModel):
    """
    O(n) = 2^n 
    evaluation = 'AIC' 'BIC' 'Cp'
    
    """
    def __init__(self,evaluation='aic'):

        self.evaluation = evaluation #<AIC;BIC;Cp>

        self.weight = None
        self.evaluation = None
        self.x_best =None
        self.model_index = None
    
    def fit(self,X,y):
        #change to np.array
        X = np.array(X,dtype=np.float32)
        y = np.array(y,dtype=np.float32)


        num_sample = X.shape[0]
        num_feature = X.shape[1]

        #model number :2^k-1 
        index = list(range(num_feature))
        models_list = [] #a containter to collect different index
        for i in range(num_feature):
            models_list.append(list(combinations(index,i)))

        
        ev_init = 100000#Setting a large initial value
        ev_list = []


        for i in range(len(models_list)):
            for j in range(len(models_list[i])):
                model = LinearRegression()
                w = model.fit(X[:,j],y)
                y_pre = np.dot(X[:,j],w)
                
                #feature
                k = X[:,j].shape+1

                if self.evaluation=='aic':
                    "2k-2ln(L)"
                    loss = log_likelihood(y,y_pre)
                    ev = 2*(k-loss)
                elif self.evaluation == 'bic':
                    "kln(n)-2ln(L)"
                    loss = log_likelihood(y,y_pre)
                    ev = k*np.log(num_sample)-2*loss

                elif self.evaluation == 'Cp':
                    "RSS/(n-p-1) +2p"
                    rss = residual_sum_of_squares(y,y_pre)
                    ev =  rss/(num_sample-k-1) + 2*k
                else:
                    raise ValueError("for evaluation ,you must choose 'aic','bic','Cp'.")
                
                
                ev_list.append((ev,i,j))

        #best subset
        for elem,loc_i,loc_j in ev_list:
            if elem < ev_init:
                ev_init = elem
                loc = (loc_i,loc_j)
        
        self.evaluation = ev_init 
        loc_i = loc[0]
        loc_j = loc[1]
        model_ = models_list[loc_i][loc_j]
        X_best = X[:,model_]
        w_best = LinearRegression.fit(X_best,y)
        self.w = w_best
        self.x_best =X_best
        self.model_index = model_
        return self
    
    def predict(self,X_test):
        
        if self.weight is None:
            raise PredictError('if you want to use a model to predict using ,you must fit it first')
        else:
            one_column = np.ones((X_test.shape[0],1))
            X_test = np.hstack((X_test,one_column))
            y_pre = np.dot(X_test[:,self.model_index],self.weight)


        return y_pre

    def evaluate(self,y,y_pre):
        if self.weight is None:
            raise EvaluateError('If you want to evaluate a model,you must fit it first')
        else:
            mse = mse_loss(y,y_pre)
        return mse
    
            




#<kcv>
def k_cross_validation_linear_reg(estimator,X,y,n_splits=5,random_state=True):
    """
    k: int split k fold
    estimator : instance linear regression model
    X: array-like
    y: array-like

    """
    kf = KFold(k=n_splits,random_state=random_state)
    num_feature = X.shape[0]
    evaluations=[]
    for test in kf.split(X):
        
        arr = np.array(range(num_feature))
        mask=np.ones(len(arr),dtype=bool)
        mask[test] = False
        train = arr[mask]

        X_train ,X_test = X[train] ,X[test]
        y_train,y_test = y[train] ,y[test]

        #train model
        estimator.fit(X_train,y_train)
        #get evaluation
        y_pre =estimator.predict(X_test)
        evaluation = estimator.evaluate(y_test,y_pre)
        evaluations.append(evaluation)

    return np.mean(evaluations)






class RidgeRegression(LinearModel):

    def __init__(self,c=0.2):
        self.c = c
        
        self.weight = None



    def fit(self,X,y):
        X = np.array(X,dtype='float32')
        y = np.array(y,dtype='float32')

        one_column = np.ones((X.shape[0],1))
        X_adj = np.hstack((X,one_column))

        num_sample,num_feature = X.shape
        U_adj = np.dot(X_adj.T,X_adj)+np.eye(num_sample)*self.c

        U_adj_inv = np.linalg.inv(U_adj)
        best_w = U_adj_inv @ X_adj.T@y
        self.weight = best_w

        return self
    
    def predict(self,X_test):
        if self.weight is None:
            raise PredictError('If you want to use a model to predict using ,you must fit it first')
        else:
            one_column = np.ones((X_test.shape[0],1))
            X_test = np.hstack((X_test,one_column))
            y_pre = np.dot(X_test,self.weight)

        return y_pre
        
    
    def evaluate(self,y,y_pre):
        if self.weight is None:
            raise EvaluateError('If you want to evaluate a model,you must fit it first')
        else:
            mse = mse_loss(y,y_pre)
        return mse 