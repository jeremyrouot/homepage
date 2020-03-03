
function generate_taylor()
  clear
 
  entry = 1;
  %
  fileID = fopen("sol-taylor.txt","w");  
  Nb = randi(4)+1;
  for i=1:Nb
    alp(end+1) = randi(3)*(-1)^(randi(1)-1);
    bet(end+1) = randi(3)*(-1)^(randi(1)-1);
  end
  
  %{ 
  s 
  = sum(sum( ai * u(xk + bj*h),i,1,Nb),j,1,Nb)
  =  Nb*sum(ai,i)*u(xk) 
   + h*sum(ai,i)*sum(bj,j)*u'(xk)
   + h^2/2*sum(ai,i)*sum(bj^2,j)*u''(xk)
   + h^3/6*sum(ai,i)*sum(bj^3,j)*u'''(xk)
  %} 
  
  sa = sum(alp);
  sb = sum(bet);
  sbb = sum(bet.^2);
  sbb = sum(bet.^3);
 
  %Q: donner les coefficients r1,r2,r3 
  % s = r1*u(xk) + r2*u'(xk) + r3*u''(xk) 
  
  fclose(fileID);
  %}
  
  end