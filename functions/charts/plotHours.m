function [ f ] = plotHours( T )
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

% calculate stats
varY = nanvar(y1);
stDev = nanstd(y1);
meanY = nanmean(y1);

% plot y
hold on
p1 = area(y1, 'FaceColor', [0.6 0 0]);
p2 = area(y2, 'FaceColor', [0 0.6 0]);
grid on
% set axis limits
xAxMax = max(x);
xAxMin = min(x);
yAxMax = max(y1);
axis([xAxMin, xAxMax, -inf, yAxMax])

% set ticks
xtickspace = round(numel(x)/20);
set(gca, 'Xtick', x(1:xtickspace:end), 'xticklabels', datestr(T.t0(1:xtickspace:end), 'dd mmm yy'), 'xticklabelrotation', 60, 'Ytick', 0:(round(max(y1)/8)):max(y1) + 20, 'FontSize', 8);
ytickspace = round(max(y1)/20);

% set title
title(strcat({'Chart to show '}, metric1, {' between '}, datestr(T.t0(1), 'dd/mm/yy'), {' - '}, datestr(T.t0(end), 'dd/mm/yy')), 'FontSize', 12);
ylabel(metric1, 'FontSize', 12)
xlabel('time (t)', 'FontSize', 12)

% plot mean line
meanLine = plot([min(x), max(x)] , repmat(meanY, 2), 'b');

% plot end(Y) point
endYLine = scatter(max(x), y1(end), '*', 'black');

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
labelMean = strcat({'\mu='}, num2str(round(meanY, 2)));
labelMeanPosX = xAxMax + xAxMax*0.01;
labelMeanPosY = meanY;
labelTextMean = text(labelMeanPosX, labelMeanPosY, labelMean);

labelUCL = strcat({'3\sigma='}, num2str(round(meanY + stDev*3, 2)));
labelUCLPosX = xAxMax + xAxMax*0.01;
labelUCLPosY = meanY + stDev*3;
labelTextUCL = text(labelUCLPosX, labelUCLPosY, labelUCL);

labelUWL = strcat({'\sigma='}, num2str(round(meanY + stDev, 2)));
labelUWLPosX = xAxMax + xAxMax*0.01;
labelUWLPosY = meanY + stDev;
labelTextUWL = text(labelUWLPosX, labelUWLPosY, labelUWL);

if exist('LWL', 'var')
    labelLWL = strcat({'\sigma='}, num2str(round(meanY - stDev, 2)));
    labelLWLPosX = xAxMax + xAxMax*0.01;
    labelLWLPosY = meanY - stDev;
    labelTextLWL = text(labelLWLPosX, labelLWLPosY, labelLWL);
    if exist('LCL', 'var')
        labelLCL = strcat({'3\sigma='}, num2str(round(meanY - stDev*3, 2)));
        labelLCLPosX = xAxMax + xAxMax*0.01;
        labelLCLPosY = meanY - stDev*3;
        labelTextLCL = text(labelLCLPosX, labelLCLPosY, labelLCL);
    end
end
end

