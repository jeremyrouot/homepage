function generate_edp_laplace_Mixtes()
  clear
  format long
  %{
  % Resolution de : 
  %                   -u''(x) = cos(om*pi*x) 
  %                       u(0) = u0, u'(T)= upT
  % On construit une subdivision de [0,T] avec N+2 points
  % Parametres: u0,upT,T,om,N
  %} 
  
  entry = 1;
  %
  fileID = fopen("sol-edp2.txt","w");  
  for om=2:3:5
    f = @(x) cos(om*pi*x); 
    for T=1:2:8
      for N=51:27:(51+7*27)
        
        %subdivision de [0,T] avec N+2 points
        xx = linspace(0,T,N+2);
        h = xx(2)-xx(1);
        
        % Discretisation de la cond de Neumann
        % (u_(N+1)-u_N)/h = upT
        % u_(N+1) = h*upT + u_N
        
        % Matrice d'assemblage A
        A = diag(ones(N-1,1),-1)+    diag(ones(N-1,1),1) - 2 * diag(ones(N,1));
        A(N,N) = -1;
        invA = inv(A);     
        % vecteur solution
        u = zeros(N,1);
        % second membre
        sm = f(xx(2:end-1))'; 
        
        for u0=0:0.25:1
          for upT=0:0.25:1
            
            sm(1) =  f(xx(2)) + 1/h^2*u0;
            sm(end) =  f(xx(end-1)) + 1/h^2*(h*upT);
            
            u = -h^2*invA*sm;
            uex = [u0;u;u(end) + h*upT];
            res = sum(uex(1:end-1))*h;
            fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%0.11f];\n",entry,om,T,N,u0,upT,res); 
            entry = entry+1;
            
          end
        end
      end
    end
  end
  
  fclose(fileID);
  %}
  
  
  %% Resolution pour un cas precis
  %{
  om  = 5;
  T   = 3;
  N   = 213;
  u0  = 0;
  upT = 0.25;
  
  f = @(x) cos(om*pi*x); 
  
  %subdivision de [0,T] avec N+2 points
  xx = linspace(0,T,N+2);
  h = xx(2)-xx(1);
  
  % Discretisation de la cond de Neumann
  % (u_(N+1)-u_N)/h = upT
  % u_(N+1) = h*upT + u_N
  
  % Matrice d'assemblage A
  A = diag(ones(N-1,1),-1)+    diag(ones(N-1,1),1) - 2 * diag(ones(N,1));
  A(N,N) = -1;
  invA = inv(A);     
  % vecteur solution
  u = zeros(N,1);
  % second membre
  sm = f(xx(2:end-1))'; 
  
  sm(1) =  f(xx(2)) + 1/h^2*u0;
  sm(end) =  f(xx(end-1)) + 1/h^2*(h*upT);
  
  u = -h^2*invA*sm;
  uex = [u0;u;u(end) + h*upT];
  res = h*sum(uex(1:end-1))
  
%  upx = upT + sin(om*pi*T)/(om*pi) - sin(om*pi*x)/(om*pi);  
  up0 = upT + sin(om*pi*T)/(om*pi);
  
  b = sin(om*pi*T)+sin(om*pi*T)/(om*pi)+upT
  odef = @(x,u) [u(2),-f(x)];
  
  sx = linspace(0,T,100000);
  pas = sx(2)-sx(1);
  opt = odeset ("RelTol", 1e-12,"AbsTol",1e-10);
  [t,solu]=ode45(odef,sx,[u0,up0],opt);
  sum(solu(1:end-1,1))*pas
  
  up = diff(solu(:,1))./diff(t);
  up(end);
  
  %}
  
  
  end