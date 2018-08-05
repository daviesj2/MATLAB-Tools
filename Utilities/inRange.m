function [ output ] = inRange( X,hi,lo )
% Checks to see if a scalar, vector, or matrix is within specified scalar
% range.
%   
%   X - Input scalar,vector, or matrix
%   hi - Hi range scalar
%   lo - Low range scalar
%   Output - Logical with dimensions of X


output = X > lo & X < hi;
end

