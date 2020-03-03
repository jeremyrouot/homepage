%% Laplace 2D par differences finies
%{

On cherche u une fonction de classe C^2 sur [0,L]x[0,L] verifiant

   d^2u       d^2u
- ------  -  ------  = f(x,y)
   dx^2       dy^2
 
 avec les conditions de Dirichlet homogenes:
      u(0,y) = u(x,0) = u(L,y) = u(x,L) = 0
     
    
     L  _____________________________________________
       |                                             |
       |                                 u(xi,yj)    |
    yj |---------------------------------- +         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
  y    |                                   :         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
       |                                   :         |
     0 |_____________________________________________|
       0                                  xi         L     
                            x       
%}

function res = laplace2D_eleve()
  clear 
  close all
  clc
  
  % borne sup du carre de resolution
  L           = 1;
  % nombre de points de subdivision
  N           = 10;
  % pas du maillage suivant x et y 
  h           = L/N
  % subdivision pour construire le maillage du carre [0;L]x[0,L]
  nc          = linspace(h,L-h,N);
  % maillage de la carre [0;L]x[0,L]
  [xx,yy]     = meshgrid(nc,nc);

  % terme source 
  f           = @(x,y) x;
  % terme source evalue sur les noeuds du maillage de taille NxN
  F           = f(xx,xx);
  % on transforme F en vecteur de taille N^2x1
  F           = reshape(F,N^2,1);
  
  % matrice identite de taille NxN
  Id          = eye(N,N);
  % construction de la matrice A tel que AU = F
  % A est une matrice par blocs :
  %       - les elements diagonaux sont la matrice D
  %       - les elements sur-diagonaux et sous diagonaux sont les matrices -Id
  D           = Id-diag(ones(N-1,1),1); 
  A           = kron(Id,D) - kron(diag(ones(N-1,1),-1),Id);
  % Resolution du systeme lineaire obtenu : on obtient U de taille N^2x1             
  U           = A\F;
  % on transforme le vecteur U en une matrice de taille NxN
  U           = reshape(U,N,N);
  
  % Affichage des resultats
  figure(1)
  scatter3(xx(:),yy(:),U(:),20,'b');
  
  res = h^2*sum(U);

end
