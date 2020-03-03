
from sage import *

reset()

import numpy as np
import pylab as plt

def gx(x):
  return sin(2*math.pi/L*x);

############################# ok ########################################
#implicite, retarde en temps, avance en espace
L=3;
N=150;
c=1;
lbd=3
T=2
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = (1-lbd)*np.diag(np.ones(N+1)) + lbd*np.diag(np.ones(N),k=1);
A[-1,0] = lbd
print(A)
while n*dt<=T:
  yn = (np.linalg.inv(A)).dot(yn)
  n+=1;
print(max(yn))
  

######################################################################
#explicite, avance en temps, centre en espace
L=4
N=200;
c=2;
lbd=1;
T=3
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = np.diag(np.ones(N+1))+lbd/2*np.diag(np.ones(N),k=-1)-lbd/2*np.diag(np.ones(N),k=1);
A[0,-1] = -lbd/2
A[-1,0] = lbd/2
print(A)
while n*dt<=T:
  yn = A.dot(yn)
  n+=1;
print(max(yn))

######################### ok ###########################################
#implicite, retarde en temps, centre en espace
L=4;
N=140;
c=4;
lbd=3;
T=2
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = np.diag(np.ones(N+1))-lbd/2*np.diag(np.ones(N),k=-1)+lbd/2*np.diag(np.ones(N),k=1);
A[0,-1] = -lbd/2
A[-1,0] = lbd/2
print(A)
while n*dt<=T:
  yn = (np.linalg.inv(A)).dot(yn)
  n+=1;
print(max(yn))

############################## ok  #####################################
#explicite, avance en temps,avance en espace
L=4;
N=150;
c=1;
lbd=1/4;
T=2
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = (1+lbd)*np.diag(np.ones(N+1)) - lbd*np.diag(np.ones(N),k=1);
A[-1,0] = -lbd
print(A)
while n*dt<=T:
  yn = A.dot(yn)
  n+=1;
print(max(yn))


########################### ok #########################################
#explicite, avance en temps, retarde en espace
L=1;
N=200;
c=2;
lbd=1/3;
T=1
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = (1-lbd)*np.diag(np.ones(N+1)) + lbd*np.diag(np.ones(N),k=-1);
A[0,-1] = lbd
print(A)
while n*dt<=T:
  yn = A.dot(yn)
  n+=1;
print(max(yn))




############################# ok ########################################
#implicite, retarde en temps, retarde en espace
L=4;
N=200;
c=4;
lbd=1/2
T=3
dx=L/(N+1);
dt=lbd*dx/c;
nx=[i*dx for i in range(1,N+2)]
yn=np.array(map(gx,nx))
n = 0;
A = (1+lbd)*np.diag(np.ones(N+1)) - lbd*np.diag(np.ones(N),k=-1);
A[0,-1] = -lbd
print(A)
while n*dt<=T:
  yn = (np.linalg.inv(A)).dot(yn)
  n+=1;
print(max(yn))



