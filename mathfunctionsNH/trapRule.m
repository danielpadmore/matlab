function [ area ] = trapRule( funcStr, a, b, n )
% Trap rule function using input function (in terms of x), input limits 'a' & 'b' and number of strips 'n'
x = linspace(a, b, n);                  % x coordinates of samples
fn = str2func(funcStr);                 % convert input function string to function handle
y = fn(x);                              % evaluate function with x
sumY = sum(y) - (y(1) + y(end)) ./ 2;   % sum y coordinates, taking just half of endpoints
dx = (b - a) / (n - 1);                 % width of each trapezoid
area = sumY * dx;                       % calculate area
end

