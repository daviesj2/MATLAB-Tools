function [ SingleSided_FFT, f, t ] = ezfft(X,fs,fc,bw,PlotX,PlotFFT,stack)
%Easily plots a single sided FFT for a vector
%   X       -   Input vector                    (Double)
%   fs      -   Sample Rate                     (Double)
%   fc      -   FFT's center frequency in Hz    (Double)
%   bw      -   FFT window span in Hz           (Double)
%   PlotX   -   Plot X vs time                  (logical)
%   PlotFFT -   Plot |FFT| vs Freq              (logical)
%   stack   -   Stack plots                     (logical)
% 	Jason Davies - 4/7/2017

if nargin < 2
    error('X and fs are required!');
end

if ~exist('PlotX','var'), PlotX = 1; end
if ~exist('inLog','var'), inLog = 1; end
if ~exist('PlotFFT','var'), PlotFFT = 1;end
if ~exist('stack','var')&&(PlotX&&PlotFFT), stack = 1;end

T = length(X)/fs;   %Sampling Period is #Samples/sample rate [(samples) / (samples/s)]
Length = fs*T;      %Signal length is sampling freq*sampling period

FFT = fft(X);%Compute FFT w/ padded zeros
Length = length(FFT); %Signal length is sampling freq*sampling period
DoubleSided_FFT = abs(FFT/(fs*T));%Compute doublesided Spectrum
SingleSided_FFT = DoubleSided_FFT(1:Length/2+1);%Compute Single Sided FFT
SingleSided_FFT(2:end-1) = 2*SingleSided_FFT(2:end-1);%Fold in the mirrored negative frequencies

if inLog
    SingleSided_FFT = 10*log(SingleSided_FFT)+20;
end

f = fs*(0:(Length/2))/Length;%Get the span of frequencies
t = linspace(0,T,fs*T); %Get time vector

if PlotFFT
    if stack 
        subplot(2,1,1);
    else
        h=figure();
        figure(h);
    end
    plot(f,SingleSided_FFT);
    xlabel('Frequency (Hz)')
    if inLog, ylabel('|X(\omega)| dBm'), else, ylabel('|X(\omega)| Watt'), end
    title('FFT(X(t))')
    if exist('fc','var') && exist('bw','var')
        xlim([fc-bw/2 fc+bw/2])
    end
end

if PlotX
    if stack 
        subplot(2,1,2);
    else
        h=figure();
        figure(h);
    end
    plot(t,X);
    xlabel('Time (s)');
    ylabel('X(t)');
    title('X(t)');
    
end
end

