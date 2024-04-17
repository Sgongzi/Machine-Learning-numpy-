
import numpy as np
import random

class KFold():

    def __init__(self,
                 k=5,
                 random_state=True):
        self.k = k
        self.random_state = random_state

        

    def split(self,X):
        if self.random_state:
            random.seed(13)
        num_sample = X.shape[0]

        #生成一个随机的索引
        index_list = np.array_split(np.random.permutation(np.arange(num_sample)),self.k)

        return index_list


            
            





        



        
        