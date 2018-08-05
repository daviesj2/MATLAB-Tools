function [ z ] = pos2z( POS )
%Converts Percent OverShoot to zeta damping ratio
% Takes POS in % and outputs unitless damping ratio
z = (-log(POS/100))./sqrt(pi^2 + log(POS/100).^2);

end