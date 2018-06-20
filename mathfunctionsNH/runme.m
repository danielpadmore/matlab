%% Define Test functions and input values
egFunc1 = '@(x)x.^4 + x - 2';
egFunc2 = '@(x)x.^3 + 2.*x.^2 + 12.*x - 23';
a = 1.0626373;
b = 2;
n = 5;
ranVal1 = randi(10, 1);
ranVal2 = randi(100, 1);
%% Test Trapezium Rule Function Q1 (a) (i)
trapAns1 = trapRule(egFunc1, a, b, n);
trapAns2 = trapRule(egFunc2, a, b, n);
%% Test Simpson Rule Function Q1 (a) (ii)
simpAns1 = simpsonRule(egFunc1, a, b, n);
simpAns2 = simpsonRule(egFunc2, a, b, n);
%% Test cosExp function Q1 (a) (iii)
cosExpAns1 = cosExp(ranVal1);
cosExpAns2 = cosExp(ranVal2);
%% Test for specified function Q1 (b)
fn = '@(x)cosExp(x)';
n = 2;
a = 1.237172;
b = 8.0;
% Repeat answers for 5 strip widths
for i = 1:5
trapAnsB(i) = trapRule(egFunc1, a, b, n);
simpAnsB(i) = simpsonRule(egFunc1, a, b, n);
n = n.*2;
end
exactInt = integral(str2func(fn), b, a);
errTrapB = trapAnsB - exactInt;
errSimpB = simpAnsB - exactInt;
% Plot log of result error
figure
n = 2.^(1:5);
hold on
plot(log(n), log(errTrapB));
plot(log(n), log(errSimpB));
hold off
legend('Trapezoidal','Simpson')
% Simpson rule shows less error with high h width. The error decreases for
% both methods as n increases and more areas are calculated.

