function bissection
clear
format long

a=-53/5;
b=27/5;
Nmax=17;

function y = ffun(x)
  y = -8*x^5+x^4+7*x^3+x^2-9*x+3;
endfunction

[sol, fval, info]=fzero(@(x)ffun(x),a);
sol

N=1
while N<=Nmax
  c = (a+b)/2;
  if (ffun(c)==0 | (b-a)/2 <1e-14) 
    c
    break
  endif
  N = N+1;
  if sign(ffun(c))==sign(ffun(a)) 
      a=c;
  else
      b=c;
  endif
end

N
a
b
c=(a+b)/2



endfunction
