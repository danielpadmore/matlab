function [ chart ] = createPlantChartDCT( alldata )
%% Creates chart for all lines die change time within a plant
data = alldata.plantDCT;
chart = figure;
ylabel('Average Die Change Time', 'FontSize', 15)
set(chart, 'Position', [100, 100, 600, 340])
x = 1:numel(data.DCT);

hold on
ax = gca;
ax.XTick = x;
ax.XTickLabel = alldata.lines;
set(gca, 'Ygrid', 'on', 'FontSize', 15, 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3);
axis([0.5, length(x)+0.5, 0, max(data.DCT)+(max(data.DCT)*0.1)])
title('Die Change Time', 'FontSize', 20)

errorUp = data.maxDCT - data.DCT;
errorDown = data.DCT - data.minDCT;
eBars = errorbar(x, data.DCT, errorDown, errorUp, 'r.');
eBars.Color = [0 0 0];

markADCT = scatter(x, data.DCT, 100, 'b', 'filled', 's');
labels = cellfun(@num2str, num2cell(round(data.DCT)),'UniformOutput', 0);
xLabelPos = x + 0.15;
yLabelPos = data.DCT;
text(xLabelPos, yLabelPos, labels);

% lgd = legend([markADCT, eBars], 'DCT', 'Max/Min', 'Location' ,'southoutside', 'Orientation', 'horizontal');
% lgd.Box = 'off';

set(gcf, 'renderer', 'painters');
end

