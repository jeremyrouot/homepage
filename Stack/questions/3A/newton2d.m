function newton2d
  clear 
  format long
  
  
  function res = ffun(z)
    x=z(1);
    y=z(2);
    res(1) = x*(y+2)-3;
    res(2) = y^2-2*x;
  endfunction
  
  [sol, fval, info]=fsolve(@(z) ffun(z),[1,2]);

  sol
endfunction
