# in    : ensemble de points a coordonnees entieres
# out   : nombre de rectangle parallele aux axes

import matplotlib.pyplot as plt
# generate random integer values
from random import seed
from random import randint
# seed random number generator
#seed(1)

import numpy as np

def gen_points(Np,N):
    #Nb points in a NxN grid
    if Np>N**2:
        print('error: trop de points')
    L = np.zeros((Np,2))
    for i in range(0,Np):
        L[i,:] = [randint(0,N-1),randint(0,N-1)]
    return np.unique(L,axis=0)


def count_rec(L):
    nbs = 0
    Np  = L.shape[0]
    #on doit trouver des quadruplets de la forme
    # (x,y), (x2,y), (x2,y2), (x,y2)
    for ihg in range(0,Np):
        hg = L[ihg,:] #point courant en haut a gauche
        for ihd in range(0,Np):
            hd = L[ihd,:]
            #on prends que les rectangles a droite du point courant
            if hd[1]==hg[1] and hd[0]>hg[0]:
                #maintenant il faut trouver les deux autres sommets
                for ibd in range(0,Np):
                    bd = L[ibd,:]
                    if (bd[0]!=hd[0] or bd[1]>=hd[1]):
                        continue
                    for ibg in range(0,Np):
                        bg = L[ibg,:]
                        if bg[0]==hg[0] and bg[1]==bd[1] and bg[0]<bd[0]:
                            #bingo
                            print(hg,hd,bd,bg)
                            nbs += 1
    return nbs

LP = gen_points(10,3)
print(LP[:,1])
print(count_rec(LP))

colors = [[0,0,0]]
area = np.pi*3
plt.scatter(LP[:,0],LP[:,1], s=area, c=colors, alpha=0.5)
plt.show()
