
from sage import *

reset()

import numpy as np
import pylab as plt


alp=np.array([-1,16,-30,16,-1])
bet=np.array([2,1,0,-1,-2])
bet2 =bet*bet
bet3 =bet*bet2

print(sum(alp*bet))
print(sum(alp*bet2))
print(sum(alp*bet2))

