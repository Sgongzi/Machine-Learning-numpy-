
import numpy as np 
import pandas as pd

#简单算法的问题：某类概率是0很容易算出0
class NaiveBayesian():
    """
    prior probability
    likelihood function

    Naive Bayesian is a classification algorithm based on Bayes' theorem
      and the assumption of conditional independence.

    X: pandas.dataframe
    y: pandas.dataframe

    """

    def __init__(self):
        self.prior = None
        self.condition_prob = None

        pass


    def fit(self,X,y):
        condition_prob = dict()
        classes = y[y.columns[0]].unique()#pd.series

        class_count = y.value_counts()
        #likelihood -prior
        prior_probs = class_count/len(y)


        for col in X.columns:
            for j in classes:
                pxy = X[(y==j).values][col].value_counts()
                for i in pxy.index:
                    condition_prob[(col,i,j)]=pxy[i]/class_count[j]
        self.prior = prior_probs
        self.condition_prob = condition_prob
        return self
    
    def predict(self,X_test,y_test):
        classes = y_test[y_test.columns[0]].unique()
        output=[]
        for c in classes:
            y = self.prior[c]
            p=1
            for i in X_test.items():
                p = p*self.condition_prob[tuple(list(i)+[c])]
            output.append(y*p)
        return classes[np.argmax(output)]
    





        