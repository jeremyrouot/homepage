function ode_forme_normale_tuto_2019_reacteur
  
  clear 
  clc
  
  %  inputs
  function [dqdt]=odef(q,a,c,d,u)
    dxdt= 1 + 1/a*q(1)-3*1/c*q(2)*q(3)+1/c*q(3)^3;
    dydt= 1/d*q(3);
    dzdt= u;
    dqdt = [dxdt;dydt;dzdt];
  end
  
  %{
  % on doit demarrer sur la singuliere ie y = z^2 
  entry = 1;
  fileID = fopen("forme_normale_mn.txt","w");   
  T = 2*pi;
  figure(1)
  for x0=[-5 4]
    for z0=[-3 2]
      y0 = z0^2;
      for a=1:4
        for c=1:4
          for d=1:4
            for om=1:2
              for phi=1:2:3
                for N=300:300
                  qf = solveFN(x0,z0,a,c,d,om,phi,N);
                  fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%i,%i,%i,%.11f,%.11f,%.11f];\n",entry,x0,z0,N,phi,om,d,c,a,qf(1),qf(2),qf(3)); 
                  entry = entry+1;
                  
                end
              end
            end
          end
        end
      end   
    end
  end
  fclose(fileID);
  %}
  
  function qf = solveFN(x0,z0,a,c,d,om,phi,N);
    qvec  = [];
    tvec  = [];
    y0 = 1/z0^2;
    qn = [1/x0;y0;1/z0];
    un = [cos(pi/phi)];
    h   = 2*pi/N;
    for i=0:N-1
      tn = i*h;
      un(end+1)  = cos(om*(tn+h)+pi/phi); 
      
      fn = odef(qn,a,c,d,un(end-1));
      kk1=h*fn;
      kk2=h*odef(qn+kk1,a,c,d,un(end));
      qn = qn + 1/2*(kk1+kk2);
      qvec(:,end+1) = qn;
      tvec(end+1) = tn;
    end
    %{
    cla
    plot(tvec,qvec)
    pause(0.5)
    drawnow
    %}
    fname = ['controls/ut',num2str(entry),'.txt'];
    fid = fopen (fname, "w");
    csvwrite(fname,un');
    fclose(fid);
    qf = qn;
  end
  
  
  
  function [dqdt]=odef2(q,a,c,d,u)
    dxdt= 1 + 1/a*q(1)-3*1/c*q(2)*q(3)+1/c*q(3)^3;
    dydt= 1/d*q(3);
    dzdt= u;
    dqdt = [dxdt;dydt;dzdt];
  end
  
  
  solve2(-5,-3,2,4,3,300)
  function qf = solve2(x0,z0,a,c,d,N);
    y0=1/z0^2;
    qn = [1/x0;y0;1/z0];
    un = [];
    h   = 2*pi/N;
    ut = load("toto.txt");
    size(ut)
    for i=0:N-1
     
      fn = odef2(qn,a,c,d,ut(i+1));
      kk1=h*fn;
      kk2=h*odef2(qn+kk1,a,c,d,ut(i+2));
      qn = qn + 1/2*(kk1+kk2);
    end
    qf = qn;

  end
  
  
end

