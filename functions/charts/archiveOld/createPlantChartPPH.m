function [ chart ] = createPlantChartPPH( alldata )
%% Creates chart for all lines PPH within a plant
data = alldata.plantPPH;
chart = figure;
ylabel('Average Parts per Hour', 'FontSize', 15)
set(chart, 'Position', [100, 100, 600, 340])
x = 1:numel(data.PPH);

hold on
% markTarget = scatter(x, data.targets, 100, '+', 'r');
ax = gca;
ax.XTick = x;
ax.XTickLabel = alldata.lines;
set(gca, 'Ygrid', 'on', 'FontSize', 15, 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3);
axis([0.5, length(x)+0.5, 0, max(data.PPH) + 150])
title('Parts per Hour', 'FontSize', 20)

errorUp = data.maxPPH - data.PPH;
errorDown = data.PPH - data.minPPH;
eBars = errorbar(x, data.PPH, errorDown, errorUp, 'r.');
eBars.Color = [0 0 0];

markPPH = scatter(x, data.PPH, 100, 'b', 'filled', 's');
labels = cellfun(@num2str, num2cell(round(data.PPH)),'UniformOutput', 0);
xLabelPos = x + 0.15;
yLabelPos = data.PPH;
text(xLabelPos, yLabelPos, labels);

% lgd = legend([markPPH, markTarget, eBars], 'PPH', 'Target', 'Max/Min', 'Location' ,'southoutside', 'Orientation', 'horizontal');
% lgd.Box = 'off';

set(gcf, 'renderer', 'painters');
end

