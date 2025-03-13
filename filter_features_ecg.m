data = readmatrix("ecg.csv"); % For CSV files
plot(data);

fs=500;
fc=40; %cutoff frequency=40Hz;
order=4; %filter order

[b, a] = butter(order, fc/(fs/2), 'low');

filtered_ecg = filtfilt(b, a, data(1875,:));  % Transpose before and after filtering

t = (0:width(data)-1) / fs;
size(t)
size(filtered_ecg)

figure;
plot(t, filtered_ecg);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
title('Filtered ECG Signal (Low-Pass Butterworth)');
grid on;

%%to convert into bode plot
% [H,f]=freqz(b,a,1024,fs);
% figure;
% plot(f,20*log10(abs(H)));
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% title('Frequency Response of the Butterworth Filter');
% grid on;

% Load filtered ECG signal
fs = 500; % Sampling frequency (adjust if needed)

% Detect R-peaks
[~, locs] = findpeaks(filtered_ecg, 'MinPeakHeight', 0.8, 'MinPeakDistance', 10);

% Convert indices to time
t = (0:length(filtered_ecg)-1)/fs;
t_peaks = t(locs);

% Plot ECG with R-peaks
figure;
plot(t, filtered_ecg);
hold on;
plot(t_peaks, filtered_ecg(locs), 'ro'); % Mark detected R-peaks
xlabel('Time (s)');
ylabel('Amplitude (mV)');
title('ECG Signal with Detected R-peaks');
grid on;

% Given that locs contains the detected R-peaks
RR_intervals = diff(locs) / fs; % Convert to time (seconds)
HR = 60 / mean(RR_intervals);   % Heart Rate in BPM
HRV = std(RR_intervals);        % Heart Rate Variability

% Display results
fprintf('Heart Rate (HR): %.2f BPM\n', HR);
fprintf('Heart Rate Variability (HRV): %.4f sec\n', HRV);

if HR < 60
    disp('ECG Classification: Abnormal (Bradycardia)');
elseif HR > 100
    disp('ECG Classification: Abnormal (Tachycardia)');
else
    disp('ECG Classification: Normal');
end




