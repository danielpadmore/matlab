function fig1Tab = getFig1Table(weekStart, allData)
% Return a table with just the data for figure 1 - the average for the
% week, split over each line

    % Down-select our allData table
    % Use a logical index to get data from the week we're interested in
    weekIdx = (allData.StartTime>weekStart) & (allData.StartTime < weekStart + 7*days);
    
    % Now we just have data for the required week, by indexing into table
    % using the weekIdx logical index
    weekAllData = allData(weekIdx,:); 
    
    % Use varfun to apply the 'sum' function to the 4 columns we're
    % interested in. We specify these columns in 'InputVariables', and
    % specify that we want to group by 'LineID'
    fig1Tab = varfun(@sum,weekAllData,'InputVariables',{'Hits','Parts','TotalHours','ProductionUptime'},...
       'GroupingVariables','LineID');
   
   % Note that there is an extra field in the table 'GroupCount', which
   % says how many of each group have been summed. 
    

end