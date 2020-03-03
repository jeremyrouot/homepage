function generate_ode_nonlipschitz()
  clear
  format long
  %{
  % Resolution de l'equation y' = y^alp
  alp = p/q
  
  la solution est ((1-alp)*t)^(q/(q-p))
  donc on demande: q>p (n'explose pas en zero), 
  q-p impair (puissance rationelle impair d'un reel negatif)
  % 
  %} 
  
  entry = 1;
  %{
  figure(1)
  hold on
  fileID = fopen("sol-ode.txt","w"); 
  
  for q=[3 5]
    p=max(q-2*randi(2)-1,2);
    
    alp = p/q;
    
    
    for aa=[-1 -3/4 -1/2 -1/4 1/4 1/2 3/4]
      for bb = [1 3/2 2];  
        for N=[20 40 80]
          xa = nthroot(((1-alp)*aa),q-p)^q   
          [tsol,xsol,sk] = solveEDO(q,p,N,xa,aa,bb);
          %    cla
          
          %    axis([aa,bb,-1,1])
          %      scatter(tsol,xsol,'+');
          %       plot([aa bb],[0 0],'r');
          
          %  drawnow
          %  pause(0.5)
          fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%0.11f,%0.11f,%i];\n",entry,p,q,N,aa,bb,xa,xsol(end),sk); 
          
          entry = entry+1;
          
        end
      end
    end
  end
  hold off
  
  fclose(fileID);
  %}
  
  function z = rhs(t,y,q,p)
    z = nthroot(y,q).^p;
  end
  
  [r1,r2,r3]=solveEDO(5,2,20,0.1344421424,0.5,1);
  r2(end)
  r3
  
  function [tsol,ysol,solk] = solveEDO(q,p,N,xa,aa,bb)
    %
    %  rk2 loop
    %
    yn      = xa;
    tn      = aa;
    
    ysol     = [xa];
    tsol    = [tn];
    h       = (bb-aa)/(N-1);
    solk    = inf;
    for k=1:N-1
      
      k1    = h*rhs(tn,yn,q,p);
      k2    = h*rhs(tn+h,yn+k1,q,p);
      aux   = yn;
      yn    = yn + 1/2*(k1+k2);
      if solk==inf && yn*aux<0 
        solk = k;
      end
      tn    = tn+h;
      ysol(end+1) = yn;
      tsol(end+1) = tn;
    end
  end
  
end
