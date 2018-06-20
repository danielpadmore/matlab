function [ chart ] = createPlantChartUptime( alldata )
%% Creates chart for all lines uptime within a plant
data = alldata.plantUptime;
chart = figure;
ylabel('Average Uptime %', 'FontSize', 15)
set(chart, 'Position', [100, 100, 600, 340])
x = 1:numel(data.uptime);

hold on
ax = gca;
ax.XTick = x;
ax.XTickLabel = alldata.lines;
set(gca, 'Ygrid', 'on', 'FontSize', 15, 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3);
axis([0.5, length(x)+0.5, 0, 100])
title('Uptime', 'FontSize', 20)

errorUp = data.maxUptime - data.uptime;
errorDown = data.uptime - data.minUptime;
eBars = errorbar(x, data.uptime, errorDown, errorUp, 'r.');
eBars.Color = [0 0 0];

markUptime = scatter(x, data.uptime, 100, 'b', 'filled', 's');
labels = cellfun(@num2str, num2cell(round(data.uptime)),'UniformOutput', 0);
xLabelPos = x + 0.15;
yLabelPos = data.uptime;
text(xLabelPos, yLabelPos, labels);

% lgd = legend([markUptime, eBars], 'Uptime', 'Max/Min', 'Location' ,'southoutside', 'Orientation', 'horizontal');
% lgd.Box = 'off';

set(gcf, 'renderer', 'painters');
end

