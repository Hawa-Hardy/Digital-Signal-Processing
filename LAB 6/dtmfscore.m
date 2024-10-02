%DTMFSCORE
% Usage: sc = dtmfscore (xx, hh)
% returns a score based on the max amplitude of the filtered output
% xx = input DTMF tone
% hh = impulse response of ONE bandpass filter
%
% The signal detection is done by filtering xx with a length-L
% BPF, hh, and then finding the maximum amplitude of the output.
% The score is either 1 or 0.
% sc = 1 if max(|y[n]|) is greater than, or equal to, 0.59
% sc = 0 if max(|y[n]|) is less than 0.59
%
function sc = dtmfscore (xx, hh)
xx = xx*(2/max(abs(xx))); %--Scale the input x[n] to the range [-2, +2]
yy=conv (hh, xx); % convolution of signal with BPF impulse response
if max(abs(yy))>=0.59 % binary output of signal presence in waveform
    sc=1;
else
    sc=0;
end
%Removing the comments below will result in a lot of your computational
%power being used up
%figure; plot(abs(yy))
%title('DTFM SCORE - Check for max amplitude function'); grid on
%xlabel('n'), ylabel('Magnitude')
end