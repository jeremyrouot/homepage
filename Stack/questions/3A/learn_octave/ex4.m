function ex4

n=7;
k=1;
dg=[];
while n>0
  dg = [mod(n,2) dg(:)'];
  n = floor(n/2);
  k=k+1;
end  

res = dg

endfunction