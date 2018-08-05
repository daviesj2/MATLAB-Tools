function rdisp( files )
%Display rdir structure in a nicely formatted way
%Input is an rdir sctructure or a string
if ischar(files)
    files=rdir(files);
    assignin('base','files',files);
end
requiredFields = {'name' 'date' 'bytes' 'isdir' 'datenum' 'path'};

if isstruct(files) &&  all(isfield(files,requiredFields))
    fprintf(['#      Name' repmat(' ',1,40) ' isDir    Size(KiB)   Path\n'])
    for i = 1:length(files)
        tabsnum = repmat(' ',1,7-length(num2str(i)));
        tabspath = repmat('  ',1,15-length(num2str(files(i).bytes)));
        if length(files(i).name) > 46; files(i).name = [files(i).name(1:42) '... ']; end
        tabsname = repmat(' ',1,47-length(files(i).name));
        fprintf(['%d' tabsnum '%s' tabsname '%d \t %.0f' tabspath '%s\n'],i,files(i).name,files(i).isdir,files(i).bytes/1024,files(i).path)
    end
else
    fprintf('This is not a rdir structure.\n')
    return
end

