% Utility Function to create allData

% Import from two different data sources
ox1 = importOxfordFile('Oxford\Oxford - Split1.csv');
ox2 = importOxfordFile('Oxford\Oxford - Split2.csv');
ox3 = importOxfordFile('Oxford\Oxford - Overlap3.csv');
cam = importCambridgeFile('Cambridge\Cambridge.csv');

% Concatenate table

allData = [ox1; ox2; cam];

% Sort by date (not strictly necessary, but useful to see)
allData = sortrows(allData,'StartTime','ascend');

% Save to .mat file
save('allData.mat','allData')