function [ chart ] = createLineTrendPPH( alldata, lineNum )
%% Creates single line chart for HPH over last 20 weeks
data = alldata.linePPH;
chart = figure;
set(chart, 'Position', [100, 100, 600, 340])
lineName = alldata.lines(lineNum);
y = data.(char(lineName));
x = 1:21;

barchart = bar(x, y(end-20:end));
yAxMax = max(y(end-20:end)) + (max(y(end-20:end))*0.1);
axis([0, 22, -inf, yAxMax])
xticklab = alldata.weeks(length(alldata.weeks)-20:length(alldata.weeks));
set(gca, 'Xtick', x(1:1:end), 'xticklabels', xticklab, 'Ytick', 0:(round((max(y)/8), -1)):max(y) + 20, 'FontSize', 12);
set(gca, 'Ygrid', 'on', 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3)

titlestr = sprintf('%s Line - Parts per Hour Trend', char(lineName));
title(titlestr, 'FontSize', 20)
xlabel('Week Number', 'FontSize', 15)
ylabel('Average Parts per Hour', 'FontSize', 15)

set(barchart, 'FaceColor', [0,0,1], 'BarWidth', 0.4)
barchart.FaceAlpha = 0.8;
labels = cellfun(@num2str, num2cell(round(y(end-20:end))),'UniformOutput', 0);
xLabelPos = x - 0.4;
yLabelPos = y(end-20:end) + (0.04*yAxMax);
t = text(xLabelPos, yLabelPos, labels);
set(t, 'FontSize', 11)

hold on
%targetline = plot(alldata.weeks(end-20:end), data.target(end-20:end), 'r', 'LineWidth', 2);

% lgd = legend('PPH', 'Target', 'Location' ,'southoutside');
% lgd.Box = 'off';
set(gcf, 'renderer', 'painters');

return

end
