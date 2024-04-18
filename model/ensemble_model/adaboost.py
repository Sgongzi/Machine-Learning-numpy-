
import numpy as np

class DecisionStump():
    def __init__(self):
        
        self.label = 1
        self.feature_index = None
        self.threshold = None
        self.alpha = None


class Adaboost():
    def __init__(self, n_estimators=5):
        self.n_estimators = n_estimators
    
    def fit(self, X, y):
        m, n = X.shape
        
        w = np.full(m, (1/m))
        self.estimators = []
        for _ in range(self.n_estimators):
         
            estimator = DecisionStump()
          
            min_error = float('inf')
            
            for i in range(n):
                
                values = np.expand_dims(X[:, i], axis=1)
               
                unique_values = np.unique(values)
               
                for threshold in unique_values:
                    p = 1
                   
                    pred = np.ones(np.shape(y))
                  
                    pred[X[:, i] < threshold] = -1
                   
                    error = sum(w[y != pred])
                    
                    if error > 0.5:
                        error = 1 - error
                        p = -1
                   
                    if error < min_error:
                        estimator.label = p
                        estimator.threshold = threshold
                        estimator.feature_index = i
                        min_error = error
            
            estimator.alpha = 0.5 * np.log((1.0 - min_error) /
                                           (min_error + 1e-9))
     
            preds = np.ones(np.shape(y))
     
            negative_idx = (estimator.label * X[:, estimator.feature_index] < estimator.label *
                            estimator.threshold)
           
            preds[negative_idx] = -1
    
            w *= np.exp(-estimator.alpha * y * preds)
            w /= np.sum(w)
     
            self.estimators.append(estimator)
    
    def predict(self, X):
        m = len(X)
        y_pred = np.zeros((m, 1))
        
        for estimator in self.estimators:
        
            predictions = np.ones(np.shape(y_pred))
            
            negative_idx = (estimator.label * X[:, estimator.feature_index] < estimator.label *
                            estimator.threshold)
            
            predictions[negative_idx] = -1
            
            y_pred += estimator.alpha * predictions
       
        y_pred = np.sign(y_pred).flatten()
        return y_pred