
import numpy as np
from utils.activation import sigmoid,softmax
import random



class BaseNeuralNetwork(object):
    #initialise the neuralnetwork
    def __init__(self,
                 input_nodes,
                 hidden_nodes,
                 output_nodes,
                 *,
                 learning_rate,
                 epochs,
                 batch):
        
        self.input = input_nodes
        self.hidden = hidden_nodes
        self.output = output_nodes

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
        self.X=X
        self.y=y

        self.sample = X.shape[0]
        
        self.hidden_input = np.dot(X,self.weight_ih)
        self.hidden_output = sigmoid(np.dot(self.hidden_input))

        self.output_input = np.dot(self.weight_ho,self.hidden_output)
        self.output_output = softmax(self.output_input)
    
        
        #cal error
        self.error_output = -np.sum(y*np.log(y_pre)) #softmax ---cross entropy
        self.error_ho = np.dot(error_output,self.weight_ho.T)
        self.error_ih = np.dot(error_ho,self.weight_ih.T)

        return self
    def parameter_update(self):
        self.weight_ho_loss_function = self.output_output-self.y
        self.weight_ho_gradient = np.dot(self.weight_ho_loss_function,self.hidden_output)
        """
        continue
        """
        pass

    
    



            


            







