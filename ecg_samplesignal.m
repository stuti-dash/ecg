fs=500;
t=0:1/fs:2;

ecg_signal = sin(2*pi*1*t) + 0.5*sin(2*pi*3*t) + 0.2*sin(2*pi*10*t);

figure;
plot(t,ecg_signal);
xlabel('Time (s)');    
ylabel('Amplitude (mV)'); 
title('Simulated ECG Signal');
grid on;