function rk2_1D
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


%  inputs
function [dydt]=rhs(t,y)
    dydt=sin(t*y);
end


y0=0.6;
a=-0.3;
b = 3.2;
h = 0.07;
nstep = (b-a)/h
t = a:h:b;
yn=y0;

%
%  rk2 loop
%
for n = 1:nstep
   k1=h*rhs(t(n),yn);
   k2=h*rhs(t(n)+h,yn+k1);
   ynp1 = yn + 1/2*(k1+k2); 
   yn=ynp1;
end

yn



end