from sage import *

reset()

import numpy as np
import pylab as plt

a=-0.25;
b=1;
N=20;
h=(b-a)/(N-1);

tn=a;
yn=-0.0423466213;

def odef(t,y):
  return (nroot(y,5))**2

def nroot(x,q):
  if mod(q,2)==1:
    return x.sign()*(abs(x)**(1/q));
  else:
    return x**(1/q);
    

k=-1;
for i in range(1,N):
  k1=h*odef(tn,yn)
  k2=h*odef(tn+h,yn+k1)
  yold=yn;
  yn = yn + (k1+k2)/2.
  if yold*yn<0:
    k=i;
    print(k)
  tn = tn+h

print(yn,k)

