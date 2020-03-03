
function lsode_comp
clear

global IDPB

function res=generer_id(k1,e11,e12,e13,k2,e21,e22,e23)
res=0;
l=[k1,e11,e12,e13,k2,e21,e22,e23];
for i=1:8
res=res+10^(i-1)*l(i);
end
endfunction


lid=[];
ii=1;
for e11=0:2 
for e12=0:2
for e13=0:2
for k1=1:2
for e21=0:2 
for e22=0:2
for e23=0:2
for k2=1:2
if (e11+e12+e13>0 && e11+e12+e13<3 && e21+e22+e23>0 && e21+e22+e23<3)
lid(ii) = generer_id(k1,e11,e12,e13,k2,e21,e22,e23);
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

fileID = fopen("sol-octave-ode.txt","w");

function res=odef(x,t)

global IDPB
n=IDPB;
k1=mod(n,10);
n=floor(n/10);
e1=mod(n,10);
n=floor(n/10);
e2=mod(n,10);
n=floor(n/10);
e3=mod(n,10);
n=floor(n/10);
l1=k1*x(1).^e1.*x(2).^e2.*x(3).^e3;
k2=mod(n,10);
n=floor(n/10);
e1=mod(n,10);
n=floor(n/10);
e2=mod(n,10);
n=floor(n/10);
e3=mod(n,10);
n=floor(n/10);
l2=k2*x(1).^e1.*x(2).^e2.*x(3).^e3;

res=[l1;l2;-l1-l2];

endfunction

disp('debut');
size(lid)
for id=1:length(lid)
  IDPB=lid(id);
 


y0=[1;1;1];
T=0.5;
%creation de la subdivision en temps
tn = linspace(0,T,100);
%appel de la routine lsode de Octave
[ysol,st,~] = lsode("odef",y0,tn);

if st==2
%on affiche les solutions
%{
figure(1)
hold on
plot(tn,ysol(:,1),'b','linewidth',1.2);
plot(tn,ysol(:,2),'r','linewidth',1.2);
plot(tn,ysol(:,3),'k','linewidth',1.2);
hold off
%}

fprintf(fileID,"footable[%i]:significantfigures(%f,3);\n",IDPB,ysol(end,2));
end

end
fclose(fileID);

endfunction