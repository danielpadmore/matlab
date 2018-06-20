function [ area ] = simpsonRule( funcStr, a, b, n )
% Trap rule function using input function (in terms of x), input limits 'a' & 'b' and number of strips 'n'
x = linspace(a, b, n);                  % x coordinates of samples
fn = str2func(funcStr);                 % convert input function string to function handle
y = fn(x);                              % evaluate function
sumY = 4.*sum(y(2:2:length(y)-1)) + 2.*sum(y(1:2:length(y)-1)) + y(1) + y(end);
dx = (b - a) / (n - 1);                 % width of each trapezoid
area = sumY * dx/3;                      % calculate area
end

