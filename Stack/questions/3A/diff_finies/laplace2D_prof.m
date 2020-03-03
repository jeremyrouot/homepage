% Laplace 2D par differences finies
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
function laplace2D_eleve()
  clear 
  close all
  clc
  
  function [er,ss] = solvelaplace(L,N,k)
    
    % pas du maillage suivant x et y 
    h           = L/(N+1);
    % subdivision pour construire le maillage du carre [0;L]x[0,L]
    nc          = linspace(h,L-h,N);
    % maillage de la carre [0;L]x[0,L]
    [xx,yy]     = meshgrid(nc,nc);
    
    % terme source
    f           = @(x,y) 2*k*(x.*(L-x) + y.*(L-y));
    solu        = @(x,y) k*x.*y.*(L-x).*(L-y);
    % terme source evalue sur les noeuds du maillage de taille NxN
    F           = f(xx,yy);
    % on transforme F en vecteur de taille N^2x1
    F           = reshape(F,N^2,1);
    
    % matrice identite de taille NxN
    Id          = eye(N,N);
    % construction de la matrice A tel que AU = F
    % A est une matrice par blocs :
    %       - les elements diagonaux sont la matrice D
    %       - les elements sur-diagonaux et sous diagonaux sont les matrices -Id
    D           = 4*Id -diag(ones(N-1,1),1) - diag(ones(N-1,1),-1); 
    A           = kron(Id,D) - kron(diag(ones(N-1,1),-1),Id) ...
    - kron(diag(ones(N-1,1),1),Id);
    % Resolution du systeme lineaire obtenu : on obtient U de taille N^2x1             
    U           = A\(h^2*F);
    % on transforme le vecteur U en une matrice de taille NxN
    U           = reshape(U,N,N);
    
    er = max(max(U-solu(xx,yy)));
    ss = h^2*sum(U(:));
    % Affichage des resultats
    %{
    figure(1)
    hold on
    scatter3(xx,yy,U,20,'b');
    scatter3(xx,yy,solu(xx,yy),10,'r','filled')
    hold off
    %}
  end
  
  
  fileID = fopen("sol-laplace.txt","w");  
  entry=1;
  for L=0.5:0.2:3
    for N=10:7:80     
      for k=1:2:16     
        
        [err,ss]  = solvelaplace(L,N,k);
        
        fprintf(fileID,"footable[%i]:[%i,%i,%i,%0.11f,,%0.11f];\n",entry,L,N,k,err,ss); 
        entry = entry+1;
      end
    end
  end
  
  fclose(fileID);

  
  
end
