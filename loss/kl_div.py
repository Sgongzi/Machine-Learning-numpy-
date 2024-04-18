
import numpy as np

def KL_Div(p,q):
    """
    计算两个概率分布之间的KL散度。

    参数:
    （概率分布） 可以是输入和输出 y y_pre
    p -- 一个概率分布，列表或数组形式，元素之和应为1
    q -- 另一个概率分布，列表或数组形式，元素之和应为1

    返回:
    kl_div -- p和q之间的KL散度
    """
    

