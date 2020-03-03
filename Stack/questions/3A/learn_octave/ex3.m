function ex3

A=[];
for i=1:3
  for j=1:5
    A(i,j)=i+j;
  end
end 
res = size(A,2)

endfunction