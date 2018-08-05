function [ complex ] = p2r( magnitude,theta )
%Translate polar coords to rectangular
if nargin == 1
    theta = magnitude(2);
    magnitude = magnitude(1);
end
theta = theta * (pi/180);
complex = magnitude*exp(1i*theta);

end

