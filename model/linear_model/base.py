from abc import ABC ,abstractmethod


class LinearModel(ABC):
    def __init__(self):
        super().__init__()

    @abstractmethod
    def fit(self):
        """fit model"""
        pass

    @abstractmethod
    def predict(self):
        """predict model"""
        pass

    @abstractmethod
    def evaluate(self):
        """ evalution for model"""
        pass


    




