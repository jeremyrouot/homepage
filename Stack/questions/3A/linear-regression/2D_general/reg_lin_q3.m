data = load('data-636.txt');

m=size(data,1);
fdex = @(x) sin(2.*x);

y = data(:,2);
fX = ones(m,2);
fX(:,2) = fdex(data(:,1));

inv((fX')*fX)*(fX')*y
 