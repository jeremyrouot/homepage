clear all
% Euler's Method
% Initial conditions and setup
h = 0.05;  % step size
x = 1:h:4.75;  % the range of x
y = zeros(size(x));  % allocate the result y
y(1) = 0.6;  % the initial y value
n = numel(y);  % the number of y values
% The loop to solve the DE
for i=1:(n-1)
    f = sin(2*x(i)*y(i));
    y(i+1) = y(i) + h * f;
end

size(y,2)-1
y(end)