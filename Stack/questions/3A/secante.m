function secante
clear
format long

x0=1.7;
x1=2;
xnm1=x0;
xn=x1;

function y = ffun(x)
  y = -2*x^7+2*x^6-7*x^5+2*x^4+7*x^3-x^2-3*x+2;
endfunction

[sol, fval, info]=fzero(@(x)ffun(x),x0);
sol
err=1;
N=1
while err>1e-5
  xnp1 = xn - ffun(xn)*(xn-xnm1)/(ffun(xn)-ffun(xnm1));
  xnm1 = xn;
  xn = xnp1;
  err = abs(ffun(xnp1));
  N=N+1;
  err;
  xnp1
end

xnp1


xn-sol
N

endfunction
