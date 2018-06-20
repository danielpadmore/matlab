function [ f, values, variance, meanVal ] = plotControl( T, metric, varargin )
% plots control chart from inputs

f = figure;

for i = 1:numel(varargin)/2
    if isa(varargin{i+1}, 'char')
        T = T(strcmp(T.(varargin{i}), varargin{i+1}),:);
    elseif isa(varargin{i+1}, 'double')
        T = T(T.(varargin{i}) == varargin{i+1},:);
    else
        error('invalid input');
    end
end

T = sortrows(T,'t0');
T = T(~isinf(T.(metric)), :);

values = table(T.t0, T.(metric), 'VariableNames', {'t0', (metric)});
variance = nanvar(T.(metric));
stDev = nanstd(T.(metric));

p = plot(T.t0, T.(metric));
title(strcat(metric, {': Variance = '}, num2str(variance)));
axis([-inf, inf, 0, 1]);
grid on

% plot mean line
meanVal = nanmean(T.(metric));
meanVals = repmat(meanVal, 2);%numel(T.(metric)));
hold on
meanLine = plot([min(T.t0), max(T.t0)] , meanVals, 'b');

% plot warning limit lines (sigma)
UWL = meanVal + stDev;
LWL = meanVal - stDev;
hold on
plot([min(T.t0), max(T.t0)], repmat(UWL,2), 'y');
hold on
plot([min(T.t0), max(T.t0)], repmat(LWL,2), 'y');

% plot control limit lines (3*sigma)
UCL = meanVal + 3*stDev;
LCL = meanVal - 3*stDev;
hold on
plot([min(T.t0), max(T.t0)], repmat(UCL,2), 'r');
hold on
plot([min(T.t0), max(T.t0)], repmat(LCL,2), 'r');

end

