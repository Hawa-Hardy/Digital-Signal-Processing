% a
Freq = 4000;          % Frequency of the sinusoids in Hz
samples = 25;         % Number of samples per period
T = 1/Freq;           % Period of the sinusoid

% Generate time vector tt from -T to T with sufficient samples
tt = -T : T/samples : T;

% Amplitudes
A1 = 22;              % Age
A2 = 1.2 * A1;        % 1.2 times age

% Time shifts
D = 19;               % Day of birth
M = 4;                % Month of birth
tm1 = (37.2 / M) * T; % Time shift for x1
tm2 = -(41.3 / D) * T;% Time shift for x2

% Generate the sinusoids
x1 = A1 * cos(2 * pi * Freq * (tt - tm1));
x2 = A2 * cos(2 * pi * Freq * (tt - tm2));

% Plotting
figure; % Creating new figure window

% Plot x1(t)
subplot(3, 1, 1);
plot(tt, x1);
title('HAWA HARDY - 4000 Hz Sinusoid x1(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot x2(t)
subplot(3, 1, 2);
plot(tt, x2);
title('4000 Hz Sinusoid x2(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot the sum of x1(t) and x2(t)
x3 = x1 + x2;
subplot(3, 1, 3);
plot(tt, x3);
title('x3(t) = x1(t) + x2(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

