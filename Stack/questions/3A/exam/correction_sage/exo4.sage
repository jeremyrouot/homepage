
from sage import *

reset()

import numpy as np
import pylab as plt

f=open("toto.txt", "r")
f1=f.readlines()
ut=[float(item) for item in f1[0].split() if item]

a=2;
c=4;
d=3;

def odef(n,q):
  return np.array([1.-3/c*q[1]*q[2]+1/a*q[0]+1/c*q[2]**3,q[2]/d,ut[n]])

qn = np.array([-1/5.,1/9.,-1/3.])
N=300
h=2.*n(pi)/N 
for n in range(0,N):
  print(ut[n])
  k1 = h * odef(n,qn)
  k2 = h * odef(n+1,qn+k1)
  qn = qn + (k1+k2)/2.


print(qn)

