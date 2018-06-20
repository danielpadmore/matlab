% Chart creation of HPH trend over number of elements entered.
function [ chart ] = chartDiesetHPH( inputData, xlabels, target, name )

% input checking and conversion to double
if ~isa(inputData, 'double')
    if isa(inputData, 'cell')
        inputData = cell2mat(inputData);
    else
        error('invalid data input');
    end
end
if ~exist('xlabels', 'var')
    xlabels = zeros(numel(inputData),1);
end

% throw error if trying to chart too many entries, alternate chart more
% appropriate
if numel(inputData) >= 20
    disp('Too many entries input, limited to latest 20 entries')
    inputData = inputData(end-19:end);
end

% set chart sizing and base plot data
chart = figure;
set(chart, 'Position', [100, 100, 600, 340])
y = inputData;
x = 1:numel(inputData);
aHand = axes('parent', chart);
hold(aHand, 'on')

% set mean value (needed for colours)
meanVal = mean(inputData);

% preallocate colours array
colours = zeros(numel(y),3);

% create bar chart and set axis limits and labels
for i = 1:numel(y)
    if strncmp(xlabels(i), 'L462', 4)
        colours(i,1) = 0;
        colours(i,2) = 1;
        colours(i,3) = 1;
    elseif y(i) > meanVal*1.7
        colours(i,1) = 0;
        colours(i,2) = 1;
    elseif y(i) > meanVal*1.5
        colours(i,1) = 0.1;
        colours(i,2) = 0.9;
    elseif y(i) > meanVal*1.3
        colours(i,1) = 0.2;
        colours(i,2) = 0.8;
    elseif y(i) > meanVal*1.1
        colours(i,1) = 0.3;
        colours(i,2) = 0.7;
    elseif y(i) > meanVal
        colours(i,1) = 0.4;
        colours(i,2) = 0.6;
    elseif y(i) < meanVal/1.7
        colours(i,1) = 1;
        colours(i,2) = 0;
    elseif y(i) < meanVal/1.5
        colours(i,1) = 0.9;
        colours(i,2) = 0.1;
    elseif y(i) < meanVal/1.3
        colours(i,1) = 0.8;
        colours(i,2) = 0.2;
    elseif y(i) < meanVal/1.1
        colours(i,1) = 0.7;
        colours(i,2) = 0.3;
    elseif y(i) < meanVal
        colours(i,1) = 0.6;
        colours(i,2) = 0.4;
    end
    barchart = bar(i, y(i), 'parent', aHand, 'facecolor', colours(i,:));
end
yAxMax = round(max(y)*1.1, -1);
xAxMax = round(max(x)+1);
axis([0, xAxMax, -inf, yAxMax])

% set title, axis labels, ticks and grid
if ~exist('name', 'var')
    name = char('');
end
titlestr = sprintf('%s - Hits per Hour Trend', char(name));
title(titlestr, 'FontSize', 20)
ylabel('Average Hits per Hour', 'FontSize', 15)
if ~exist('xlabels', 'var')
    xlabels = 1:numel(inputData);
end
xticklab = xlabels(1:numel(inputData));
set(gca, 'Xtick', x(1:1:end), 'xticklabels', transpose(xticklab), 'xticklabelrotation', 90, 'Ytick', 0:(round((max(y)/8),-1)):max(y) + 20, 'FontSize', 12);
set(gca, 'Ygrid', 'on', 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3)

% set colours
% set(barchart, 'FaceColor', [0,0,1], 'BarWidth', 0.4)
barchart.FaceAlpha = 0.8;

% set targetline
if exist('target', 'var')
    hold on
    xTarget = [-1000 1000];
    yTarget = repmat(target, 1, numel(xTarget));
    targetline = plot(xTarget, yTarget, 'red', 'LineWidth', 2);
    targetLabel = 'TAR';
    targetLabelPosX = xAxMax + xAxMax*0.02;
    targetLabelPosY = target;
    ttargetLabel = text(targetLabelPosX, targetLabelPosY, targetLabel);
    set(ttargetLabel, 'FontSize', 11)
end


% set meanline
hold on
xMean = [-1000 1000];
yMean = repmat(meanVal, 1, numel(xMean));
meanline = plot(xMean, yMean, 'blue', 'LineStyle', '--', 'LineWidth', 2);
meanLabel = '\mu';
meanLabelPosX = xAxMax + xAxMax*0.02;
meanLabelPosY = meanVal;
tmeanLabel = text(meanLabelPosX, meanLabelPosY, meanLabel);
set(tmeanLabel, 'FontSize', 14)

% label each bar val
barlabels = cellfun(@num2str, num2cell(round(y)),'UniformOutput', 0);
barLabelPosX = x - 0.4;
barLabelPosY = y + (0.04*yAxMax);
tbarLabel = text(barLabelPosX, barLabelPosY, barlabels);
set(tbarLabel, 'FontSize', 11)

% lgd = legend('HPH', 'Target', 'Location' ,'southoutside');
% lgd.Box = 'off';

set(gcf, 'renderer', 'painters');

return

end

