function [ matches ] = rdir( string, path )
%%Recursive form of dir() with added .path field.
% INPUTS:
%       string  [char]  -   Generally formatted matching string. Supports
%                           wildcard characters. Defaults to all items match (*).
%
%       path    [char]  -   Top level path to recurse into. 
%                           Defaults to current directory (.\). 
%
% OUTPUTS:
%       
%       matches [struct]-  Nx1 structure containing the following fields of
%                           information about matched itmes:
%
%                   
%               .name   -   Name of matched item
%               .date   -   Last modified or touched date
%               .bytes  -   Size of file in bytes
%               .datenum-   locale-dependent MATLAB serial date number
%               .path   -   Path containing matched file or folder
%
% Jason Davies - 4/26/2016

%% Input Handling
warning off;
if ~exist('path','var'), path = pwd; end %Check for required inputs
if ~exist('string','var'), string = '*'; end %Set defaults as nessecary
originalPath = pwd;
%fprintf('%s',path)
try 
    if strcmpi(fullfile(pwd,path),matlabroot)
        error('MATLABROOT')
    end
    cd(path) %Try to cd into top-level path
catch
    matches = []; %%If unable return empty matrix
    return
end
%% Main Logic
allObjects = dir(); %Get all objects in current directory into a temporary var
dirs = allObjects([allObjects.isdir]); %Get all objects that are directories

dirs(strcmp({dirs.name},'.')) = []; %Remove current and parent directories
dirs(strcmp({dirs.name},'..')) = []; % ^

clear allObjects; %Remove temporary variable


matches = dir(string); %%Obtain all matches in current dir
try
    [matches(1:end).path] = deal(pwd); %%Assign current dir to each match
catch
    matches = [];%Error state
    return
end

%% Recursion Calls
for i = 1:length(dirs),
    
    tempstruct = rdir(string,dirs(i).name); %Call rdir.m to delve into directory structure
    matches = vertcat(matches,tempstruct); %Concatonate output structure
    
end
cd(originalPath)
