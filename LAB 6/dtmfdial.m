function xx = dtmfdial(keyNames, fs)
    %DTMFDIAL Create a signal vector of tones which will dial
    % a DTMF (Touch Tone) telephone system.
    %
    % usage: xx = dtmfdial(keyNames, fs)
    % keyNames = vector of characters containing valid key names
    % fs = sampling frequency
    % xx = signal vector that is the concatenation of DTMF tones.

    dtmf.keys = ...
    ['1', '2', '3', 'A';
     '4', '5', '6', 'B';
     '7', '8', '9', 'C';
     '*', '0', '#', 'D'];
    dtmf.colTones = ones(4, 1) * [1209, 1336, 1477, 1633];
    dtmf.rowTones = [697; 770; 852; 941] * ones(1, 4);

    % Initialize the signal vector
    xx = [];

    % Duration of each DTMF tone pair
    toneDuration = 0.2; % 0.20 seconds
    silenceDuration = 0.05; % 0.05 seconds of silence between tones

    % Create each DTMF tone
    for k = 1:length(keyNames)
        key = keyNames(k);
        
        % Find the row and column for the key
        [ii, jj] = find(key == dtmf.keys);
        
        % Get the row and column frequencies
        f1 = dtmf.rowTones(ii, jj);
        f2 = dtmf.colTones(ii, jj);
        
        % Generate the time vector for the tone duration
        tt = 0:(1/fs):toneDuration;
        
        % Create the DTMF tone by summing two sinusoids
        tone = cos(2 * pi * f1 * tt) + cos(2 * pi * f2 * tt);
        
        % Concatenate the tone to the signal vector
        xx = [xx tone];
        
        % Add silence after the tone
        silence = zeros(1, round(silenceDuration * fs));
        xx = [xx silence];
    end
    
    % Plot the FFT magnitude spectrum
    N = length(xx);
    X = fft(xx);
    f = (0:N-1) * (fs/N); % Frequency vector
    figure;
    subplot(3,1,1);
    plot(f(1:N/2), abs(X(1:N/2)));
    title('FFT Magnitude Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    
    % Plot the dialed signal
    t = (0:N-1) / fs;
    subplot(3,1,2);
    plot(t, xx);
    title('Dialed Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Plot the normalized frequency
    normalized_frequency = (0:N-1) * (2*pi/N); % Normalized frequency vector
    subplot(3,1,3);
    plot(normalized_frequency(1:N/2)/pi, abs(X(1:N/2)));
    title('Normalized Frequency');
    xlabel('Frequency (\pi rad/sample)');
    ylabel('Magnitude');
end
