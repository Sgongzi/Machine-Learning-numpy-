
class PredictError(Exception):
    'if you want to use a model to predict using ,you must fit it first'
    def __init__(self,message):
        super().__init__(message)



class EvaluateError(Exception):
    'if you want to evaluate a model,you must fit it first'
    def __init__(self,message):
        super().__init__(message)

