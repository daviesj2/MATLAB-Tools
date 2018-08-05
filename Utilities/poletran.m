function [ Ts, Tp, OS, zeta] = poletran( DominantPole )
%Extracts 2nd order TF performance characteristics from dominant pole
%   Dominant Pole - Complex form
Ts = 4/abs(real(min(DominantPole)));
Tp = pi/abs(imag(DominantPole));
zeta = abs(real(min(DominantPole)))/abs(imag(DominantPole));
OS = exp((-pi*zeta)/sqrt(1-zeta^2))*100;

end

