clear all

f = @(t,y) [y(2);sin(y(1))];

% Euler's Method
% Initial conditions and setup
h = 0.05;  % step size
x = 1:h:4.75;  % the range of x
y = zeros(2,size(x,2));  % allocate the result y
y(:,1) = [0.6;0.2];  % the initial y value
n = size(y,2);  % the number of y values
% The loop to solve the DE
for i=1:(n-1)
    i;
    y(:,i+1) = y(:,i) + h * f(x(i),y(:,i));
end

size(y,2)-1
y(end)