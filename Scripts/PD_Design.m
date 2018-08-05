%% Get TF 
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
theta_Zc = pi-angle_G;
%% Calculate Zero location
Zc = wd_c /tan(theta_Zc)+sig_dc

%%Implement compenastor and TF
TF_c = TF*tf([1 Zc],1)

%Find Gain and characteristics

rlocus(TF_c);
sgrid(zeta,0);
rlocBounds = input('What bounds does the line intersect? [min max] >> ');
figure(2);
rlocus(TF_c,rlocBounds(1):0.01:rlocBounds(2));
sgrid(zeta,0);
fprintf('Zoom in then hit enter and select the intersection.')
pause
[k,p] = rlocfind(TF_c);
fprintf('Gain: %.3f\n',k)
fprintf('Poles:\n')
disp(p);
TF_c = TF_c*k;
