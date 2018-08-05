function copy_files( inputFiles,outputPath)
%copyfile.m that supports structures
%Im too lazy to fix this to support dir structures without .path field...
%Oh well.
%
%Fixed it.


if isstruct(inputFiles) && isfield(inputFiles,'name')
    if ~isfield(inputFiles,'path'), [inputFiles.path] = deal(pwd); end
    for i = 1:length(inputFiles)
        [~, name, ext] = fileparts(fullfile(inputFiles(i).path,inputFiles(i).name));
        try
            copyfile(fullfile(inputFiles(i).path,inputFiles(i).name),fullfile(outputPath,[name ext]))
        catch
            mkdir(outputPath)
            copyfile(fullfile(inputFiles(i).path,inputFiles(i).name),fullfile(outputPath,[name ext]))
        end
    end
end