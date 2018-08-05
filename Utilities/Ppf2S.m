function [ S ] = Ppf2S( P,theta )
%Active power and PF angle to apparant power
%   P in units of power theta in degrees
Q = P*tand(theta);
S = P+1i*Q;