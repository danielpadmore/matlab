function [ tbl ] = createLineDiesetTable( alldata, lineNum )
%CREATELINEDIESETTABLE Creates table of all diesets for specified pressline
pline = char(alldata.lines(lineNum));
data = alldata.weekRunTable.(pline);

tbl = table(data.Job, data.Description, data.Hits, data.HPH, data.Uptime, data.Parts, data.PPH);

end

