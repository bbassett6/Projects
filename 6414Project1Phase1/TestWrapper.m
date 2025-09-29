clear all, close all;
%% constants init
B1 = 4;
Bf = 4;

G1 = 2^(B1-1); % stage 1-2 interstage gain

Gdf = 1;         % digital gain for stage final Dout
Gd3 = 2^(Bf-1);          % digital gain for stage 3 Dout
Gd2 = Gd3*2^(B1-1);          % digital gain for stage 2 Dout
Gd1 = Gd2*2^(B1-1);            % digital gain for stage 1 Dout

N = 2^16;
n = 1:N;
fs = 300e6;
ts = 1/fs;
fin = 500/N*fs;
LGBW = 30*fs;

k = 1.38e-23;       % boltzman (J/k)
T = 300;            % temp (k)

C_cdac = 100000e-15;   % cdac total capacitance
C_s = 2000000e-15;
C_f1 = C_s/G1;
C_f2 = C_s/G1;
C_c = 1000e-15;
C_samp = 1000000e-15;   % sample and hold cap
R_sw = .01;         % sample and hold res

FSR = 2.4;
magnitude = 1.2;

C_var = 0.001;
Vt_var = 0.01;
Vt_offset_en = true;

%%
output = sim('newAttempt.slx');

%%
Y = fft(output.Dout);

mag = abs(Y(1:N/2));     
mag = mag / max(mag);         
mag_dBFS = 20 * log10(mag);    
f = (0:N/2-1)*fs/N;

figure;
plot(f, mag_dBFS, 'LineWidth', 1.2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dBFS)');
title('Spectrum of Quantized Sine Wave (dBFS)');

figure
snr(output.Dout,fs);
SNR_db = snr(output.Dout,fs)
ENOB = (SNR_db-1.76)/6.02
% 
% fft_lin = fft(output.Dout(1:N));
% 
% Ypos = fft_lin(1:N/2);   %only positive frequencies
% 
% power_spectrum = abs(Ypos).^2;
% 
% signal_bin = fin*N/fs + 1;        
% bins_around = 100;       % I can include side bins if there is spectral leakage I want to capture
% signal_bins = (signal_bin - bins_around):(signal_bin + bins_around);
% 
% P_signal = sum(power_spectrum(signal_bins));
% 
% all_bins = 2:N/2;  % exclude DC (bin 1)
% noise_bins = setdiff(all_bins, signal_bins);
% P_noise = sum(power_spectrum(noise_bins));
% 
% SNR_dB = 10 * log10(P_signal / P_noise)
% ENOB = (SNR_dB-1.76)/6.02

