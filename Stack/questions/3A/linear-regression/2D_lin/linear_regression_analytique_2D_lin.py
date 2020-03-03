#% Regression lineaire avec Descente de Gradient
#%{
#
#On genere des donnes 2D (x^(i),t^(i)), i=1,...,M
#Les donnes doivent suivrent une certaine foncion dans des coordonnees
#adaptees
#On calcule la droite des moindres carrees par la methode du gradient 
# 
#%}

import numpy as np
import random, math
import matplotlib.pyplot as plt
from itertools import product
#from scipy.interpolate import griddata

# (x1i,x2i,...,xni,yi) dont les M donnees
# yi = Sum(thetai * funf(xi,params),i,1,M)  
# xvec est une matrice n x M
def gene_data(nom_fic,n,M,ths,funf):
    xvec = np.floor((minX + (maxX-minX)*(np.random.rand(M,n)))) 
    yvec =  np.array([hdex(np.insert(xvec,0,1,axis=1),ths)]).transpose()
    mu_bruit = 0. #np.mean(yvec)
    std_bruit = abs(np.mean(yvec)) #np.std(yvec)
    yvec = yvec + np.random.normal(mu_bruit,std_bruit,(M,1))
    xvec = xvec + np.random.normal(mu_bruit,std_bruit,(M,n))
    xvec = np.floor(xvec*1e4)/1e4
    yvec = np.floor(yvec*1e4)/1e4
    alldata = np.concatenate([xvec,yvec],axis=1)
    np.savetxt(nom_fic,alldata,fmt='%1.6e',delimiter=',')
    xvec = np.insert(xvec,0,1,axis=1) 
    return xvec,yvec

def hdex(X,ths):
    fX = funfvec(X)
    return np.dot(fX,ths)
    #return np.dot(X,ths)

#Gradient descent
def computeCost(myth,X,y): #Cost function
    """
    theta_start is an n- dimensional vector of initial theta guess
    X is matrix with n- columns and m- rows
    y is a matrix with m- rows and 1 column
    """
    return float((1./(2*M)) * np.dot((hdex(X,myth)-y).T,(hdex(X,myth)-y)))

#Plot the line on top of the data to ensure it looks correct
def myfit(xval,ths):
    return ths[0] + ths[1]*funfvec(xval)

##Definition des parametres
entry = 0
n = 1
a,b,c = 1,1,1
flist = [lambda x: a*x**(2) + b*x + c, \
        lambda x: a*math.cos(b*x), \
        lambda x: x]
k = random.randint(0,len(flist)-1)
k=2
bigstrmat = "matres:matrix("
f = open("data-q-rl-1d.txt","w+")
for M,thind,minX,maxX in list(product(range(100,500,50),range(0,2),range(0,4),range(4,8))):
    entry += 1
    ths = np.random.rand(n+1)
    funf = flist[k]
    funfvec = np.vectorize(funf) 
    nomfic='data-1d-a/data-'+str(entry)+'.txt'
    Xmat,Ymat = gene_data(nomfic,n,M,ths,funf)
    A = np.dot(Xmat.T,Xmat)
    if abs(np.linalg.det(A))<1e-4:
        continue
    Aux = np.dot(np.linalg.inv(A), Xmat.T)
    thetasol = np.dot(Aux , Ymat)   
    Jsol = computeCost(thetasol,Xmat,Ymat) 
    xsanscible = np.floor((minX + (maxX-minX)*(np.random.rand()))) 
    ysol = myfit(xsanscible,thetasol)[0]
    thsol = thetasol[thind][0]
    bigstrmat = bigstrmat + f"[{n},{a},{b},{c},{k},{M},{thind},{minX},{maxX},{thsol:.9f},{Jsol:.9f},{xsanscible},{ysol:.9f}]," 
f.write(bigstrmat[0:-1]+");")


"""
#generations des donnees
Xmat,Ymat = gene_data("data-1.txt",n,M,thetas,funf)

#Plot the data to see what it looks like
plt.figure(figsize=(10,6))
#plt.plot(Xmat[:,1],Ymat[:,0],'rx',markersize=10)
plt.plot(funfvec(Xmat[:,1]),Ymat[:,0],'rx',markersize=10)
plt.grid(True) #Always plot.grid true!
plt.ylabel('yi''s')
plt.xlabel('xi''s')
plt.savefig("fig1-data.pdf")
plt.show()

print(np.dot(Xmat.T,Xmat))
Aux = np.dot(np.linalg.inv( np.dot(Xmat.T,Xmat)), Xmat.T)
thetasol = np.dot(Aux , Ymat)   
print("Solution: ",thetasol)

plt.figure(figsize=(10,6))
plt.subplot(211)
plt.plot(Xmat[:,1],Ymat[:,0],'gx',markersize=10,label='Training Data')
plt.plot(Xmat[:,1],myfit(Xmat[:,1],thetasol),'k.',label = 'Hypothesis: h(x) = %0.2f + %0.2f  f(x)'%(thetasol[0],thetasol[1]))
plt.ylabel('yi''s')
plt.xlabel('xi''s')
plt.legend()
plt.subplot(212)
plt.plot(funfvec(Xmat[:,1]),Ymat[:,0],'rx',markersize=10,label='Training Data')
plt.plot(funfvec(Xmat[:,1]),myfit(Xmat[:,1],thetasol),'b-',label = 'Hypothesis: h(f(x)) = %0.2f + %0.2ff(x)'%(thetasol[0],thetasol[1]))
plt.grid(True) #Always plot.grid true!
plt.ylabel('yi''s')
plt.xlabel('f(xi''s)')
plt.legend()
plt.savefig("fig3-res.pdf")
plt.show()
"""
