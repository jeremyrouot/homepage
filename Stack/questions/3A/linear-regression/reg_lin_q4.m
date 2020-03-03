format long
data = load('data-1.txt');

m=size(data,1);
n = size(data,2);
fdex = @(x) 2*cos(x+1);
fdex = @(x) log(abs(x)+1);
%fdex = @(x) x;

y = data(:,n);
fX = ones(m,n);
fX(:,2:end) = fdex(data(:,1:end-1));

%solution de la regression lineaire
theta = inv((fX')*fX)*(fX')*y

%valeur du cout
1/(2*m)*((fX*theta-y)')*(fX*theta-y)

%valeur du modele pour la valeur de x donnee
xv = 11;
yv = [1;fdex(xv)]' * theta 

 