function ex5()

L=1:10;
L(6:end)=0;

res1 = find(L>0)
L(find(L==0))=-1;
res2 = L



endfunction