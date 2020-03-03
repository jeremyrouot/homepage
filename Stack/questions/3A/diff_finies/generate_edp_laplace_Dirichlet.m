function generate_edp_laplace_Dirichlet()
  clear
  format long
  
  %{
  % Resolution de : 
  %                   -u''(x) = cos(om*pi*x) 
  %                       u(0) = u0, u(T)= uT
  % On construit une subdivision de [0,T] avec N+2 points
  % Parametres: u0,uT,T,om,N
  %} 
  
  entry = 1;
  %{
  fileID = fopen("sol-edp1.txt","w");  
  for om=2:3:5
    f = @(x) cos(om*pi*x); 
    for T=1:2:8
      for N=51:27:(51+7*27)
        
        %subdivision de [0,T] avec N+2 points
        xx = linspace(0,T,N+2);
        h = xx(2)-xx(1);
        
        % Matrice d'assemblage A
        A = diag(ones(N-1,1),-1)+    diag(ones(N-1,1),1) - 2 * diag(ones(N,1));
        invA = inv(A);     
        % vecteur solution
        u = zeros(N,1);
        % second membre
        sm = f(xx(2:end-1))'; 
        
        for u0=0:0.25:1
          for uT=0:0.25:1
            
            sm(1) =  f(xx(2)) + 1/h^2*u0;
            sm(end) =  f(xx(end-1)) + 1/h^2*uT;
            
            u = -h^2*invA*sm;
            uex = [u0;u;uT];
            res = h*sum(uex(1:end-1));
            fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%0.11f];\n",entry,om,T,N,u0,uT,res); 
            entry = entry+1;
            
          end
        end
      end
    end
  end
  
  fclose(fileID);
  %}
  
  
  %% Resolution pour un cas precis
  %
  om  = 5;
  T   = 7;
  N   = 186;
  u0  = 0.25;
  uT  = 0.75;
  
  f = @(x) cos(om*pi*x); 
  
  %subdivision de [0,T] avec N+2 points
  xx = linspace(0,T,N+2);
  h = xx(2)-xx(1);
  
  % Matrice d'assemblage A
  A = diag(ones(N-1,1),-1)+    diag(ones(N-1,1),1) - 2 * diag(ones(N,1));
  invA = inv(A);     
  % vecteur solution
  u = zeros(N,1);
  % second membre
  sm = f(xx(2:end-1))'; 
  sm(1) =  f(xx(2)) + 1/h^2*u0;
  sm(end) =  f(xx(end-1)) + 1/h^2*uT;
  
  u = -h^2*invA*sm;
  uex = [u0;u;uT];
  res = h*sum(uex(1:end-1))
  
  b = (uT-(cos(pi*om*T)-1)/(pi*om)^2-u0)/T
  odef = @(x,u) [u(2),-f(x)];
  
  sx = linspace(0,T,10000);
  pas = sx(2)-sx(1);
  opt = odeset ("RelTol", 1e-12,"AbsTol",1e-10);
  [t,solu]=ode45(odef,sx,[u0,b],opt);
  sum(solu(1:end-1,1))*pas
  %}
  