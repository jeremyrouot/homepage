clear 

u1=7;
u2=4;
un=u1;
unp1=u2;

for i=3:10
unp2=unp1*(5*i+un)/un
un=unp1;
unp1=unp2;
end
