
function lsode_comp
clear

global IDPB NN

function res=generer_id(k1,e11,e12,e13,k2,e21,e22,e23,NN)
res=0;
l=[k1,e11,e12,e13,k2,e21,e22,e23,NN];
for i=1:length(l)
res=res+10^(i-1)*l(i);
end
endfunction


lid=[];
ii=1;
mm=0;
mM=1;
for e11=mm:mM 
for e12=mm:mM
for e13=mm:mM
for k1=1:2
for e21=mm:mM 
for e22=mm:mM
for e23=mm:mM
for k2=1:2
for NN=1:1:3
if (e11+e12+e13>0 && e11+e12+e13<3 && e21+e22+e23>0 && e21+e22+e23<3)
%lid(ii) = generer_id(k1,e11,e12,e13,k2,e21,e22,e23,NN);
lid(ii) = [k1,e11,e12,e13,k2,e21,e22,e23,NN];
ii=ii+1;
end
end
end
end
end
end
end
end
end
end

fileID = fopen("sol-octave-ode.txt","w");
fileID2 = fopen("sol-octave-ode2.txt","w");
fprintf(fileID2,"lid:[");

function res=odef(x,t)

global IDPB NN

n=IDPB;
k1=mod(n,10);
n=floor(n/10);
e1=mod(n,10);
n=floor(n/10);
e2=mod(n,10);
n=floor(n/10);
e3=mod(n,10);
n=floor(n/10);
%l1=k1*x(1).^e1.*x(2).^e2.*x(3).^e3;
l1=sin(k1*(e1*x(1)+e2*x(2)+e3*x(3)));
k2=mod(n,10);
n=floor(n/10);
e1=mod(n,10);
n=floor(n/10);
e2=mod(n,10);
n=floor(n/10);
e3=mod(n,10);
n=floor(n/10);
NN=mod(n,10);
n=floor(n/10);
l2=cos(k2*(e1*x(1)+e2*x(2)+e3*x(3)));
%l2=k2*x(1).^e1.*x(2).^e2.*x(3).^e3;

res=[l1;l2;-l1-l2];

endfunction


for id=1:length(lid)
  IDPB=lid(id);
 
y0=[1;1;1];
T=1;
%creation de la subdivision en temps
tn = linspace(0,T,NN*50);
h=tn(2)-tn(1);
N=size(tn,2)-1;
%appel de la routine lsode de Octave
[ysol,st,~] = lsode("odef",y0,tn);

if st==2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode Euler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yEuler(1,:)=yn;
for i=2:N+1
M = odef(yn,tn(i));
yn = yn + h*M;
yEuler(i,:)=yn;
end
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode RK2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yRK2(1,:)=yn;
for i=2:N+1
fn = odef(yn,tn(i));
kk1=h*fn;
kk2=h*odef(yn+kk1,tn(i)+h);
yn = yn + 1/2*(kk1+kk2);
yRK2(i,:)=yn;
end
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode RK4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yRK4(1,:)=yn;
for i=2:N+1
fn = odef(yn,tn(i));
kk1=h*fn;
kk2=h*odef(yn+kk1/2,tn(i)+h/2);
kk3=h*odef(yn+kk2/2,tn(i)+h/2);
kk4=h*odef(yn+kk3,tn(i)+h);
yn = yn + 1/6*(kk1+2*kk2+2*kk3+kk4);
yRK4(i,:)=yn;
end
%}

fprintf(fileID,"footable[%i]:[%i,significantfigures(%f,6),significantfigures(%f,6),significantfigures(%f,6),significantfigures(%f,6)];\n",IDPB,N+1,ysol(end,2),yEuler(end,2),yRK2(end,2),yRK4(end,2));
fprintf(fileID2,"%u,",IDPB);

end
end

fclose(fileID);
fprintf(fileID2,"]");
fclose(fileID2);
endfunction