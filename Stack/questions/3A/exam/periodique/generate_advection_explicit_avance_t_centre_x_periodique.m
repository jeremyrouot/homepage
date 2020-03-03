function generate_advection_explicit_avance_t_centre_x_periodique()
clear
format long
%{
  % Resolution de l'equation d'advection: du/dt + vv*du/dx = 0, t>0, x in [0,l]
  sur [0,L] avec Nx+2 points de subdivisions
  
  CI : u(t=0,x) = sin(2*pi/ll*x)
  u(t,x)=u(t,x+L)
  output: - au bout d'un temps T, que vaut le max de Unum
%}

%
entry = 1;
fileID = fopen("sol-advection_expl_av_t_cent_x.txt","w");
for v=1:4
     for numlb=[1 2 4]
        for N=100:20:200
            for l=1:4
                for tf=[3 4 5]
                    lb = numlb/2;
                    %res = solveEDP(v,lb,N,l,tf);
                    res=inf;
                    fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%i];\n",entry,v,numlb,N,l,tf,res);
                    entry = entry+1;
                end
            end
        end
    end
end
fclose(fileID);
%}

%solveEDP(1,5,100,1,1)
    function res = solveEDP(vv,lbd,Nx,ll,T)
        g         = @(x) sin(2*pi/ll*x);
        dx        = ll/(Nx+1);    % pas en x
        ua        = @(t,x) g(x-vv*t);            % solution analytique
        
        xv        = linspace(0,ll,Nx+2);
        nx        = xv(2:end);
        
        % solution courante, initialisee a t=0
        Unum      = g(nx)';
        
        % parametre de stabilite
        dt        = lbd*dx/vv;
                
        % matrice qui relie U^(n+1) a U^n
        A         = eye(Nx+1,Nx+1)+lbd/2*diag(ones(Nx,1),-1)-lbd/2*diag(ones(Nx,1),1);
        A(1,end)    = lbd/2;
        A(end,1)    = -lbd/2;
               
        %{
            figure(1)
            axis([0 ll -1 1]);
            hold on
        %}     
        n       = 0;
        while n*dt <= T
            
            % plot solution analytique
            cla
            title(['t=',num2str(n*dt)]);
            % solution analytique au temps tn=(n-1)*dt
            uAn      = ua(n*dt,xv);
            
            % affichage de la solution analytique et numerique a t=tn
            %{
              plot(xv,uAn,'linewidth',1);
              plot(nx,Unum,'linewidth',2,'r:');
              drawnow
              pause(0.01);

            %}
            
            % Calcul de la solution numerique au temps n+1
            Unum    = A*Unum;
            
            n = n+1;
        end
        hold off
        res       = max(Unum);
    end

end
