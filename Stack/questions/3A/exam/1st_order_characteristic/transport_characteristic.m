function transport_characteristic

clear
clc
close all

%{
see cours pdf stanford dans biblio 3A
%}
  
% on resout dot x(t) = a(t,x(t)), dot y(t) = f(t,x(t)) =0
%
function solveEDO(p1,p2,p3,dt,Nx,ll,T)
        g         = @(x) exp(-(x-ll/4).^2);
        atx       = @(t,x) sin(pi/ll*x);
        ftx       = @(t,x) 0;
        dx        = ll/(Nx+1);  
        
        x0 = 0;
 oderhs = @(t,z) [atx(t,z(1)),ftx(t,z(1))];
 tspan  = [0,T]; 
 [tsol,zsol] = ode45(oderhs,tspan,[x0,g(x0)]); 
  
  xsol = zsol(:,1);
  ysol = zsol(:,2)

  plot(tsol,xsol);
  end
  %}
  
  solveFinDiff(0,1,0,0.01,200,8,10)
    function res = solveFinDiff(p1,p2,p3,dt,Nx,ll,T)
        g         = @(x) exp(-(x-ll/4).^2);
        atx       = @(t,x) sin(pi/ll*x);
        ftx       = @(t,x) 0;
        dx        = ll/(Nx+1);   
        
        xv        = linspace(0,ll,Nx+2);
        nx        = xv(2:end-1);
        
        % solution courante, initialisee a t=0
        Unum      = g(nx)';
        
        lbd       = dt/(2*dx);                         
        %
            figure(1)
            axis([0 ll 0 1]);
            hold on
        %}     
        tn      = 0;
        while tn <= T
            % matrice qui relie U^(n+1) a U^n
            A         = eye(Nx,Nx)-lbd*diag(atx(tn+dt,nx(2:end)),-1)+lbd*diag(atx(tn+dt,nx(1:end-1)),1);
            invA      = inv(A);
            % plot solution analytique
            cla
            title(['t=',num2str(tn)]);
              plot(nx,Unum,'linewidth',2,'r:');
              drawnow
              pause(0.01);
            %}
            %return
            Fn      = ftx(tn+dt,nx);
            
            % Calcul de la solution numerique au temps n+1
            Unum    = invA*(Unum+Fn);          
            tn = tn+dt;
        end
        hold off
        res       = max(Unum);
    end
  
  

  
end
