
# This file was *autogenerated* from the file exo.sage
from sage.all_cmdline import *   # import sage library

_sage_const_40 = Integer(40); _sage_const_3 = Integer(3); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_2 = Integer(2); _sage_const_0p03703703704 = RealNumber('0.03703703704'); _sage_const_2p = RealNumber('2.')
from sage import *

reset()

import numpy as np
import pylab as plt



a=-_sage_const_1 ;
b=_sage_const_1 ;
N=_sage_const_40 ;
h=(b-a)/(N-_sage_const_1 );

tn=a;
yn=-_sage_const_0p03703703704 ;

def odef(t,y):
  return (y.nth_root(_sage_const_3 ))**_sage_const_2 

k=-_sage_const_1 ;
for i in range(_sage_const_0 ,N):
  k1=h*odef(tn,yn)
  k2=h*odef(tn+h,yn+k1)
  yold=yn;
  yn = yn + (k1+k2)/_sage_const_2p 
  if yold*yn<_sage_const_0 :
    k=i;
    print(k)
  tn = tn+h

print(yn,k)


