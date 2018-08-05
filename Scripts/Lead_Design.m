%Walks you through designing a passive Lead compensator
while true
    zpkinput = cell(3,[]);
    zpkinput{1} = input('input Open Loop TF Zeros in zpk([z,p,k]) format [z] >> ');
    zpkinput{2} = input('Poles [p] >> ');
    zpkinput{3} = input('Gain [k] >> ');
    if any(zpkinput{2} > 0)
        if ~strcmp(input('One or more of your poles are positive... Is that right? (yes/no) >> ','s'),'yes')
            continue
        end
    end
    TF = zpk(zpkinput{1:3})
    if ~strcmp(input('Does this look right? (yes/no) >> ','s'),'no'),
        break
    end
end

%% Find Desired Pole Location
Tsc = input('What is your desired settling time? >> ');
zeta = pos2z(input('Desired %OS? >> '));
sig_dc = 4/Tsc;
wn_c = sig_dc/zeta;
wd_c = wn_c*sqrt(1-zeta^2)';
DPL = -sig_dc + j*wd_c

%% Find angular contribution of original OL TF
angle_G = angle(polyval(poly(zpkinput{1}),DPL)/polyval(poly(zpkinput{2}),DPL));
theta_c = pi-angle_G;

Z_cmax = -(imag(DPL)/tan(theta_c)-real(DPL)); %Assumes no cont. from the pole. Ie max cont. from Zero.
fprintf('Max Zero Location: %.3f\n',Z_cmax)
Z_c = input('Desired Zero Location >> ');

theta_zc = atan(imag(DPL)/(real(DPL)-Z_c)); 
theta_pc =  theta_c-theta_zc;
P_c = imag(DPL)/tan(theta_pc)-real(DPL);

G_lead = zpk(Z_c,P_c,1)
G = TF*G_lead

rlocus(G);
sgrid(zeta,0);


rlocBounds = input('What bounds does the line intersect? [min max] >> ');
figure(2);
rlocus(G,rlocBounds(1):0.01:rlocBounds(2));
sgrid(zeta,0);
fprintf('Zoom in then hit enter and select the intersection.')
pause
[k,p] = rlocfind(G);
fprintf('Gain: %.3f\n',k)
fprintf('Poles:\n')
disp(p);
G= G*k;
