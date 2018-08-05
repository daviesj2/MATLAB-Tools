
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
figure;
zeta = pos2z(input('Desired %OS? >> '));
rlocus(TF);
sgrid(zeta,0);
rlocBounds = input('What bounds does the line intersect? [min max] >> ');
figure(2);
rlocus(TF,rlocBounds(1):0.01:rlocBounds(2));
sgrid(zeta,0);
fprintf('Zoom in then hit enter and select the intersection.')
pause
[k,p] = rlocfind(TF);
fprintf('Gain: %.3f\n',k)
fprintf('Poles:\n')
disp(p);
