function [ returnTable ] = concatTable( varargin )
% function to build two tables together. Isolated function allows a nested
% function to exclude detected clashes and return a table without repeat
% entries.
% e.g. returnTable = [inputTable1; inputTable2]
% however if inputTable1 contains lines of data included in inputTable2,
% returnTable will only include a single line.
% transfer to subsref/subsasgn when switch to OOP...?

% set returnTable as first argument in
returnTable = varargin{1};

% loop for all arguments in
for i = 2:1:nargin
    % check next table argument for clashes against current returnTable
    addTable = checkDuplicates(returnTable, varargin{i});
    % concatenate checked addition table onto return table
    returnTable = [returnTable; addTable];
end

end

function checkedTable = checkDuplicates(existingTable, additionTable)

[~, ~, clashIndex] = intersect(existingTable, additionTable);

additionTable(clashIndex,:) = [];

checkedTable = additionTable;

end
