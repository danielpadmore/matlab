function [ chart ] = createLineWeekRunsUptime( alldata, lineNum )
%% Creates single line chart for HPH over last 20 weeks
lineName = alldata.lines(lineNum);
data = alldata.lineWeekRuns;
chart = figure;
set(chart, 'Position', [100, 100, 600, 370])
y = data.(char(lineName)).uptime;


% Zero data Protection (e.g. shutdown)
if isempty(y)
    return
end

x = 1:1:length(data.(char(lineName)).uptime);
barchart = bar(x, y);
yAxMax = (max(y)) + (max(y)*0.1);
axis([0, length(x)+1, 0, 100])

xticklab = data.(char(lineName)).desc;
set(gca, 'Xtick', x(1:1:end), 'xticklabels', xticklab, 'XTickLabelRotation', 70, 'Ytick', 0:(round((max(y)/8),-1)):max(y) + 20, 'FontSize', 8);
set(gca, 'Ygrid', 'on', 'GridColor', [0.1, 0.1, 0.1], 'GridAlpha', 0.3)

titlestr = sprintf('%s Line - Week Runs Uptime', char(lineName));
title(titlestr, 'FontSize', 20)
% xlabel('Week Number', 'FontSize', 15)
ylabel('Average Uptime %', 'FontSize', 15)

set(barchart, 'FaceColor', [0,0,1], 'BarWidth', 0.4)
barchart.FaceAlpha = 0.8;
labels = cellfun(@num2str, num2cell(round(y)),'UniformOutput', 0);
xLabelPos = x - 0.4;
yLabelPos = y + (0.04*yAxMax);
t = text(xLabelPos, yLabelPos, labels);
set(t, 'FontSize', 8)

hold on

%targetline = plot(alldata.weeks(end-20:end), data.target(end-20:end), 'r', 'LineWidth', 2);

% lgd = legend('HPH', 'Target', 'Location' ,'southoutside');
% lgd.Box = 'off';

set(gcf, 'renderer', 'painters');

return

end
