"""
Generalized linear models------Linear Regression
author:doubletree 
"""


#libraries
import numpy as np
import scipy

from .base import LinearModel
from loss.mse import mse_loss
from loss.rss import residual_sum_of_squares
from utils.error import PredictError ,EvaluateError


#a simple linear regurlation
def stand_regres(xArr,yArr):
    xMat = np.mat(xArr)
    yMat = np.mat(yArr).T
    xTx = xMat.T*xMat
    if np.linalg.det(xTx) ==0:
        print('matrix is singular')
        return 
    w = np.linalg.solve(xTx,xMat.T*yMat)
    return w



class LinearRegression(LinearModel):
    """
    ols:y=wx+b
    ----------
    parameters:
    ----------
    1.optimization str ,default='lstsq' {lstsq','normal','gd'}
        
    2.center bool , default=True

    3.learning_rate float32

    4.max_iter int  
    """
    def __init__(self,optimization='lstsq',*,center=True,learning_rate=None,max_iter=None):
        self.optimization = optimization
        self.center = center
        
        self.lr = learning_rate
        self.max_iter = max_iter
        #[below]  return pararmeter for this model if you fit it 
        self.weight = None
        self.rss = None
        self.loss = None
        self.loss_list = None


    def fit(self,X,y):
        """
        fit model
        ---------------
        parameters:
        X:array-like (n_samples,n_features)
        y:array-like (n_samples,) 

        return: self
        """
        X = np.array(X,dtype=np.float32)
        y = np.array(y,dtype=np.float32)

        if self.center:
            #center:
            X_bar = np.mean(X,axis=0)
            y_bar = np.mean(y)
            X = X-X_bar
            y = y=y_bar
        
        #adjust (1,x)
        one_column = np.ones((X.shape[0],1))
        X_adj = np.hstack((X,one_column))

        if self.optimization=='lstsq':
            #use scipy,linalg.lstsq() <if matrix is singular>
            best_w,_,_,_ = scipy.linalg.lstsq(X_adj,y)
            self.coefficients = best_w


            return self
        
        elif self.optimization=='normal':
            #w =(x.T*x)^-1*x.T.y
        
            U = np.dot(X_adj.T,X_adj)
            V = np.dot(X_adj.T,y)
            L = np.linalg.cholesky(U)
            B = np.linalg.solve_triangular(L,V,lower=True)
            best_w = np.linalg.solve_triangular(L.T,B,lower=False)

            self.coefficients = best_w
            return self
        
        elif self.optimization=='gd':
            #initialize_params
            best_w = np.ones((num_train,))

            num_train = X_adj.shape[0]
            loss_list = [] 
            
            for _ in range(1,self.max_iter):
                y_pre = np.dot(X_adj,best_w)
                loss = mse_loss(y,y_pre)
                dw = np.dot(X_adj.T,(y_pre-y))/num_train
                best_w+= -self.lr*dw

                loss_list.append(loss)

            
            self.loss_lsit = loss_list
            self.rss = residual_sum_of_squares(y,np.dot(X_adj,best_w))
            self.mse = loss_list[-1]
            self.weight = best_w

            return self
        else:
            raise ValueError("for optimization ,you must choose 'lstsq','normal'or 'gd'.")


    def predict(self,X_test):
        if self.weight is None:
            raise PredictError('if you want to use a model to predict using ,you must fit it first')
        else:
            y_pre = np.dot(X_test,self.weight)
            return y_pre


    def evaluate(self,y,y_pre):
        if self.weight is None:
            raise EvaluateError('If you want to evaluate a model,you must fit it first')
        else:
            #R^2
            rss = residual_sum_of_squares(y,y_pre)
            #R^2
            mse = mse_loss(y,y_pre)
        return rss , mse




             

