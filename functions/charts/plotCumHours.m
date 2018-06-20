function [ f ] = plotCumHours( T )
% Plots number of hits over input time from master

metric1 = 'totalHours';
metric2 = 'prodHours';

% create figure
f = figure;

% sort rows by time
T = sortrows(T,'t0');

% assign x & y
x = 1:numel(T.t0);
y1 = T.(metric1);
y2 = T.(metric2);
y1(isnan(y1)) = 0;
y2(isnan(y2)) = 0;
y1 = cumsum(y1);
y2 = cumsum(y2);
y3 = linspace(0, 168, numel(y1));

% calculate stats
varY = nanvar(y1);
stDev = nanstd(y1);
meanY = nanmean(y1);

% plot y
hold on
p3 = area(y3, 'FaceColor', [0 0 0.6]); % use for hours in week... needs better function deployment
p1 = area(y1, 'FaceColor', [0.6 0 0]);
p2 = area(y2, 'FaceColor', [0 0.6 0]);
grid on

% set axis limits
xAxMax = max(x);
xAxMin = min(x);
yAxMax = max([max(y1), max(y3)])*1.05;
axis([xAxMin, xAxMax, -inf, yAxMax])

% set ticks
xtickspace = round(numel(x)/20);
set(gca, 'Xtick', x(1:xtickspace:end), 'xticklabels', datestr(T.t0(1:xtickspace:end), 'dd mmm yy'), 'xticklabelrotation', 60, 'Ytick', 0:(round(max(y1)/8)):max(y3) + 20, 'FontSize', 8);
ytickspace = round(max(y1)/20);

% set title
title(strcat({'Chart to show '}, metric1, {' between '}, datestr(T.t0(1), 'dd/mm/yy'), {' - '}, datestr(T.t0(end), 'dd/mm/yy')), 'FontSize', 12);
ylabel(metric1, 'FontSize', 12)
xlabel('time (t)', 'FontSize', 12)

% plot mean line
% meanLine = plot([min(x), max(x)] , repmat(meanY, 2), 'b');

% plot end(Y) point
endY1 = plot([min(x), max(x)], repmat(y1(end),2), 'red');
endY2 = plot([min(x), max(x)], repmat(y2(end),2), 'green');

% labels at RHS Y Axis
% labelMean = strcat({'\mu='}, num2str(round(meanY, 2)));
% labelMeanPosX = xAxMax + xAxMax*0.01;
% labelMeanPosY = meanY;
% labelTextMean = text(labelMeanPosX, labelMeanPosY, labelMean);

labelEnd1 = strcat({'tot='}, num2str(round(y1(end), 2)));
labelEnd1PosX = xAxMax + xAxMax*0.01;
labelEnd1PosY = y1(end);
labelTextEnd1 = text(labelEnd1PosX, labelEnd1PosY, labelEnd1);

labelEnd2 = strcat({'run='}, num2str(round(y2(end), 2)));
labelEnd2PosX = xAxMax + xAxMax*0.01;
labelEnd2PosY = y2(end);
labelTextEnd2 = text(labelEnd2PosX, labelEnd2PosY, labelEnd2);
end

