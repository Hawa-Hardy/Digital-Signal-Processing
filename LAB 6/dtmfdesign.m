function hh = dtmfdesign(fb, L, fs)
    % dtmfdesign: Design DTMF bandpass filters
    % hh = dtmfdesign(fb, L, fs) returns a matrix (L by length(fb)) where each column contains
    % the impulse response of a BPF, one for each frequency in fb.
    % fb = vector of center frequencies
    % L = length of FIR bandpass filters
    % fs = sampling frequency
    % Each BPF is scaled so that its frequency response has a maximum magnitude equal to one.
    
    hh = zeros(L, length(fb)); % Pre-allocate hh matrix
    for k = 1:length(fb)
        nn = 0:(L-1);
        hh(:, k) = cos(2 * pi * fb(k) * nn / fs);
        ww = 0:pi/500:pi;
        HH = freqz(hh(:, k), 1, ww);
        zz = max(abs(HH));
        HH1 = freqz((1 / zz) * hh(:, k), 1, ww); % Scale to max value equal to one
        
        plot(ww, abs(HH1));
        xlim([0 3.35]);
        ylim([0 1]);
        grid on;
        hold on;
    end
end
