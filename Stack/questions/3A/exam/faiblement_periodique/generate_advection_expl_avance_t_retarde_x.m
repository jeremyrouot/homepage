function generate_advection_expl_avance_t_retarde_x()
clear
format long
%{
  % Resolution de l'equation d'advection: du/dt + vv*du/dx = 0, t>0, x in [0,l]
  sur [0,L] avec Np2 points de subdivisions
  CI : u(t=0,x) = sin(2*pi/ll*x)
    u(t,0)=u(t,L)
  output: - au bout d'un temps T, que vaut le max de Unum
%}

%
entry = 1;
fileID = fopen("sol-advection_expl_av_t_ret_x.txt","w");
for v=1:4
    for k=[0 2 3 4]
        for N=100:50:200
            for l=1:4
                for tf=[1,2,3]
                    if k==0 
                        res=inf;
                    else
                        res = solveEDP(v,k,N,l,tf);
                    end
                    fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%0.15f];\n",entry,v,k,N,l,tf,res);
                    entry = entry+1;
                end
            end
        end
    end
end
fclose(fileID);
%}

    function res = solveEDP(vv,kk,Nx,ll,T)
        g         = @(x) sin(2*pi/ll*x);
        dx        = ll/(Nx+1);    % pas en x
        ua        = @(t,x) g(x-vv*t);            % solution analytique
        
        xv        = linspace(0,ll,Nx+2);
        nx        = xv(2:end);
        
        % solution courante, initialisee a t=0
        Unum      = g(nx)';
        
        % parametre de stabilite
        lbd       = 1/kk;
        dt        = lbd*dx/vv;
        
        % matrice qui relie U^(n+1) a U^n
        A         = (1-lbd)*eye(Nx+1,Nx+1) + lbd*diag(ones(Nx,1),-1);
        A(1,end)  = lbd;
        
        %{
            figure(1)
            axis([0 ll -1 1]);
            hold on
        %}
        n       = 0;
        while n*dt <= T
            
            % plot solution analytique
            %{
            cla
            title(['t=',num2str(n*dt)]);
            % solution analytique au temps tn=(n-1)*dt
            uAn      = ua(n*dt,xv);
            
            % affichage de la solution analytique et numerique a t=tn
              plot(xv,uAn,'linewidth',1);
              plot(nx,Unum,'linewidth',2,'r:');
              drawnow
              pause(0.001);
            %}
            
            % Calcul de la solution numerique au temps n+1
            Unum    = A*Unum;
            
            n = n+1;
        end
        %hold off
        res       = max(Unum);
    end


end