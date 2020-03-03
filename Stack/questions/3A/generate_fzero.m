
function generate_fzero
clear

global PARAM

lid=[];
ii=1;
mm=1;
mM=2;
for k1=1:2
for e1=mm:mM 
for e2=mm:mM
for e3=mm:mM
for e4=mm:mM
for x0=0.2:0.2:0.4
for z0=0.7:0.2:0.9
for T=10:10:20
for NN=25:100:135
if e1+e2>0 && e3+e4>0 && e1+e2<4 && e3+e4<4
lid(ii,:) = [k1,e1,e2,e3,e4,x0,z0,T,NN];
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

function res=odef(x,t)

global PARAM

k1 = PARAM(1);
e1 = PARAM(2);
e2 = PARAM(3);
e3 = PARAM(4);
e4 = PARAM(5);
l1=k1*cos(x(2))^e1+sin(x(3))^e2;
l2=(3.0-k1)*sin(x(1))^e3+cos(x(3))^e4;
%l1=sin(k1*(e1*x(2)+e2*t));
%l2=cos((e3*x(1)));

res=[l1;l2;-l1-l2];

endfunction

entry=0;
for id=1:length(lid)
  PARAM=lid(id,:);

 
y0=[PARAM(6);1;PARAM(7)];
T=PARAM(8);
NN = PARAM(9);
%creation de la subdivision en temps
tn = linspace(0,T,NN);
h=tn(2)-tn(1);
N=NN-1;
%appel de la routine lsode de Octave
[ysol,st,~] = lsode("odef",y0,tn);

if st==2
entry=entry+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode Euler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yEuler(1,:)=yn;
for i=1:N
M = odef(yn,tn(i));
yn = yn + h*M;
yEuler(i+1,:)=yn;
end
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode RK2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yRK2(1,:)=yn;
for i=1:N
fn = odef(yn,tn(i));
kk1=h*fn;
kk2=h*odef(yn+kk1,tn(i)+h);
yn = yn + 1/2*(kk1+kk2);
yRK2(i+1,:)=yn;
end
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode RK4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yRK4(1,:)=yn;
for i=1:N
fn = odef(yn,tn(i));
kk1=h*fn;
kk2=h*odef(yn+kk1/2,tn(i)+h/2);
kk3=h*odef(yn+kk2/2,tn(i)+h/2);
kk4=h*odef(yn+kk3,tn(i)+h);
yn = yn + 1/6*(kk1+2*kk2+2*kk3+kk4);
yRK4(i+1,:)=yn;
end
%}

sigdig=5;
%fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%i,%i,%i,%i,significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i)];\n",entry,PARAM(1),PARAM(2),PARAM(3),PARAM(4),PARAM(5),PARAM(6),PARAM(7),PARAM(8),PARAM(9),ysol(end,1),sigdig,ysol(end,2),sigdig,ysol(end,3),sigdig,yEuler(end,1),sigdig,yEuler(end,2),sigdig,yEuler(end,3),sigdig,yRK2(end,1),sigdig,yRK2(end,2),sigdig,yRK2(end,3),sigdig,yRK4(end,1),sigdig,yRK4(end,2),sigdig,yRK4(end,3),sigdig);

%% on recupere seulement les second composantes et pas RK4
fprintf(fileID,"footable[%i]:[%i,%i,%i,%i,%i,%i,%i,%i,%i,significantfigures(%f,%i),significantfigures(%f,%i),significantfigures(%f,%i)];\n",...
entry,PARAM(1),PARAM(2),PARAM(3),PARAM(4),PARAM(5),PARAM(6),PARAM(7),PARAM(8),PARAM(9),...
ysol(end,2),sigdig,yEuler(end,2),sigdig,yRK2(end,2),sigdig);


clear yRK4 yn y0 N NN T yEuler yRK2 tn h

end
end

fclose(fileID);

endfunction