% Script to generate a report

% Define the week starting 
weekStart = datetime('06-Feb-2017');

% Load the stored data
load('allData.mat')

%% First check that we have enough data in our 'allData' table

% Check to see if the required data is in our allData store
% This would be similar to the logic which David sketched out in his
% example code. 

% This would use the importCambridgeFile and importOxfordFile functions

% if WeekStart not in allData
%   Load more data from spreadsheets
% else
%   Continue normally

%% Create figures for page 1

% Requires the data for the week from weekStart only, summed per line.
% Calll following function to down-select that data from the main table
fig1Tab = getFig1Table(weekStart,allData);

% Make figures
figure; bar(fig1Tab.sum_Hits); 
xticklabels(fig1Tab.LineID);xlabel('Line'); ylabel('Total Hits'); title('Sum of Hits');

figure; bar(fig1Tab.sum_Parts); 
xticklabels(fig1Tab.LineID);xlabel('Line'); ylabel('Total Parts'); title('Sum of Parts');

figure; bar(fig1Tab.sum_TotalHours); 
xticklabels(fig1Tab.LineID);xlabel('Line'); ylabel('Total Hours'); title('Sum of Total Hours');

figure; bar(fig1Tab.sum_ProductionUptime); 
xticklabels(fig1Tab.LineID);xlabel('Line'); ylabel('Total Production Uptime'); title('Sum of Production Uptime');

%% Create figures for page 2

%% Create figures for page 3