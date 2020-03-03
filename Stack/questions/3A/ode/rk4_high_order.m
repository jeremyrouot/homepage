function rk4_high_order
% Code for the solution of the
% differential equation:
%
%   dy/dt = f(t,y)
%
%  The right hand side of the equation,
%  i.e. f(t,y) should be found in the
%  function rhs.m
%
clear                    % this clears any pre-existing variables
% global statement, if required, should go here
format long

%  inputs
function res=odef(y,t)
    l1=sin(4*(y(2)+2*t));
    l2=cos(y(1));
    res=[l1 l2 2*l1-l2^2];
end


y0=[0.2 1 0.7];
T = 10;
N = 21
tn = linspace(0,T,N);
h=tn(2)-tn(1)

%appel de la routine lsode de Octave
[ysol,st,~] = lsode("odef",y0,tn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Methode Euler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
yn=y0;
yEuler(1,:)=yn;
for i=1:N-1
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
for i=1:N-1
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
for i=1:N-1
fn = odef(yn,tn(i));
kk1=h*fn;
kk2=h*odef(yn+kk1/2,tn(i)+h/2);
kk3=h*odef(yn+kk2/2,tn(i)+h/2);
kk4=h*odef(yn+kk3,tn(i)+h);
yn = yn + 1/6*(kk1+2*kk2+2*kk3+kk4);
yRK4(i+1,:)=yn;
end
%}

ysol(end,2);
yEuler(end,2);
yRK2(end,2);
yRK4(end,:)


end