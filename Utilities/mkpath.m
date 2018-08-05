function [ out ] = mkpath( files )
%Like fullfile() but accepts stucts
if length(files) < 1, error('Stucture contains no files!'); end
file_name = {files.name};
file_path = {files.path};
out = fullfile(file_path,file_name);

if length(out) == 1, out = out{1}; end

end

