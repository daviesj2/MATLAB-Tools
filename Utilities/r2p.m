function [ r, theta ] = r2p( complex,degree )
% Lab Group 4
% Outputs [Magnitude Angle]
if ~exist('degree','var'), degree = 0; end
r = abs(complex); %Get magnitude
theta = angle(complex); %calculate angle 
if degree, theta = theta*(180/pi); end%Convert to degrees if needed
%rTheta = [r theta]; %Concatonate for output

end


