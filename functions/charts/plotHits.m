function [ f ] = plotHits( T )
% Plots number of hits over input time from master

metric = 'hits';

% create figure
f = figure;

% sort rows by time
T = sortrows(T,'t0');

% assign x & y
x = 1:numel(T.t0);
y = T.(metric);

% calculate stats
varY = nanvar(y);
stDev = nanstd(y);
meanY = nanmean(y);

% plot y
p = plot(x, y);
grid on

% set axis limits
xAxMax = max(x);
xAxMin = min(x);
yAxMax = max(y);
axis([xAxMin, xAxMax, -inf, yAxMax])

% set ticks
tickspace = round(numel(x)/20);
set(gca, 'Xtick', x(1:tickspace:end), 'xticklabels', datestr(T.t0(1:20:end), 'dd mmm yy'), 'xticklabelrotation', 60, 'Ytick', 0:(round((max(y)/8),-1)):max(y) + 20, 'FontSize', 8);

% set title
title(strcat({'Chart to show '}, metric, {' between '}, datestr(T.t0(1), 'dd/mm/yy'), {' - '}, datestr(T.t0(end), 'dd/mm/yy')), 'FontSize', 12);
ylabel(metric, 'FontSize', 12)
xlabel('time (t)', 'FontSize', 12)

% plot mean line
hold on
meanLine = plot([min(x), max(x)] , repmat(meanY, 2), 'b');

% plot end(Y) point
endYLine = scatter(max(x), y(end), '*', 'black');

% plot variance
UWL = plot([min(x), max(x)], repmat(meanY + stDev,2), 'y');
UCL = plot([min(x), max(x)], repmat(meanY + stDev*3,2), 'r');
if meanY - stDev > 0
    LWL = plot([min(x), max(x)], repmat(meanY - stDev,2), 'y');
    if meanY - stDev*3 > 0
        LCL = plot([min(x), max(x)], repmat(meanY - stDev*3,2), 'r');
    end
end

% labels at RHS Y Axis
meanLabel = strcat({'\mu='}, num2str(round(meanY)));
meanLabelPosX = xAxMax + xAxMax*0.01;
meanLabelPosY = meanY;
tmeanLabel = text(meanLabelPosX, meanLabelPosY, meanLabel);

end

