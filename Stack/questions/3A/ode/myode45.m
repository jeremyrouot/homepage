function myode45
clear


function res=odef(t,y)
res=[sin(y(2)),-sin(y(2)+2*y(1))]';
end

tspan=-0.6:0.04:1.4;
[tt,ysol]=ode45(@odef,tspan,[0.7,-0.9]'); 

ysol(end,:)

end