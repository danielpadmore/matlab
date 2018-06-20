function [ chart ] = createPlantChartHPH( alldata )
%% Creates chart for all lines HPH within a plant
data = alldata.plantHPH;
chart = figure;
ylabel('Average Hits per Hour', 'FontSize', 15)
set(chart, 'Position', [100, 100, 600, 340])
x = 1:numel(data.HPH);

hold on
markTarget = scatter(x, data.targets(1:length(x)), 100, '+', 'r');
ax = gca;
ax.XTick = x;
ax.XTickLabel = alldata.lines;
set(gca, 'Ygrid', 'on', 'FontSize', 15, 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3);
axis([0.5, length(x)+0.5, 0, max(data.HPH) + 150])
title('Hits per Hour', 'FontSize', 20)

errorUp = data.maxHPH - data.HPH;
errorDown = data.HPH - data.minHPH;
eBars = errorbar(x, data.HPH, errorDown, errorUp, 'r.');
eBars.Color = [0 0 0];

markHPH = scatter(x, data.HPH, 100, 'b', 'filled', 's');
labels = cellfun(@num2str, num2cell(round(data.HPH)),'UniformOutput', 0);
xLabelPos = x + 0.15;
yLabelPos = data.HPH;
text(xLabelPos, yLabelPos, labels);

% lgd = legend([markHPH, markTarget, eBars], 'HPH', 'Target', 'Max/Min', 'Location' ,'southoutside', 'Orientation', 'horizontal');
% lgd.Box = 'off';

% set(gca, 'Position', get(gca, 'OuterPosition') - ...
% get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [11.69 8.27]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 2.5 1.5]);
set(gcf, 'renderer', 'painters');

end

