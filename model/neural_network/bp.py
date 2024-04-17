
import numpy as np
from utils.activation import sigmoid,tanh,relu
import random


class BaseNeuralNetwork(object):
    #initialise the neuralnetwork
    def __init__(self,
                 input_nodes,
                 hidden_nodes,
                 output_nodes,
                 *,
                 opitimation='sgd',
                 learning_rate,
                 epochs,
                 batch):
        
        self.input = input_nodes
        self.hidden = hidden_nodes
        self.output = output_nodes

        self.optimation = opitimation
        self.lr = learning_rate
        self.epochs = epochs

        #if use mini-batch
        self.batch = batch


        #return
        self.weight_ih = np.ones((self.input,self.hidden))

        self.weight_ho = np.ones((self.hidden,self.output))

    #initialise the neuralnetwork
    def forward(self,X,y):
        """
        X:array-like shape must like (num_train,input_nodes)
        y:array-like shape must like (num_train,)

        """

        X = np.array(X,ndim=2,dtype='float32')
        y = np.array(y,ndim=2,dtype='float32')

        self.sample = X.shape[0]
        
        h = sigmoid(np.dot(X,self.weight_ih))
        y_pre = sigmoid(np.dot(h,self.weight_ho))
        
        #计算每一层的error
        error_output = y_pre - y
        error_ih = np.dot(self.weight_ho,error_output.T)
        return 
    
    
    #function
    def graddescent(self,X,y):
        num_train,num_feature = X.shape
        for _ in range(self.epochs):
            error = self.forward(X,y)
            #update
            self.weight_ho = self.weight_ho +self.lr*np.dot(X,y)

            







    def train(self,X,y):
        if self.optimation == 'mini-batch':

            pass
        elif self.optimation == 'gd':
            pass
        elif self.optimation == 'sgd':
            pass
        else:
            raise ValueError('you must choose right optimation.')
        


    def predict(self):
        pass

def stocgraddescent(X,y,lr:float,max_iter:int,mini_loss):

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

def minibatch(X,y,lr,max_iter):
    pass


def bp(error):
